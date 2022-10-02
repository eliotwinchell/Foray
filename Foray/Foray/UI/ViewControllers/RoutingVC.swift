//
//  RoutingVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/1/22.
//

import Foundation
import UIKit
import MapKit
import TeslaSwift
import NotificationBannerSwift

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}

class RoutingVC: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    
    private var networkVehicle: Vehicle?
    private var vehicleLocation: DriveState? {
        didSet {
            let initialLocation = CLLocation(latitude: vehicleLocation?.latitude ?? 35.2785431, longitude: vehicleLocation?.longitude ?? -120.7514578)
            let vehiclePin = MKPointAnnotation()
            vehiclePin.coordinate = CLLocationCoordinate2D(latitude: vehicleLocation?.latitude ?? 35.2785431, longitude: vehicleLocation?.longitude ?? -120.75145781)
            vehiclePin.subtitle = "Your Vehicle"
            
            DispatchQueue.main.async {
                self.mapView.centerToLocation(initialLocation)
                self.mapView.addAnnotation(vehiclePin)
            }
        }
    }
    
    var searchBar: UISearchBar? = nil
    var vehicleID: String = ""
    var api: TeslaSwift!
    
    var urlComponents = URLComponents(string: "http://167.172.132.223:3000/api/chargersWithinBounds")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        view.backgroundColor = CustomColor.customBackgroundColor
                
        let defaults = UserDefaults.standard
        vehicleID = defaults.string(forKey: "vehicleID") ?? "NA"
        
        view.backgroundColor = .black
        mapView.layer.cornerRadius = 45
        
        self.getVehicle()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.didDragMap(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.didPinchMap(_:)))
        panGesture.delegate = self
        pinchGesture.delegate = self
        mapView.addGestureRecognizer(panGesture)
        mapView.addGestureRecognizer(pinchGesture)
        
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        searchVC.modalPresentationStyle = .fullScreen
        resultSearchController = UISearchController(searchResultsController: searchVC)
        resultSearchController?.searchResultsUpdater = searchVC
        resultSearchController?.modalPresentationStyle = .fullScreen
        
        searchVC.handleMapSearchDelegate = self
        
        navigationController?.modalPresentationStyle = .fullScreen
        
        self.view.layoutIfNeeded()
        self.view.updateConstraintsIfNeeded()
                
        let searchBar = resultSearchController!.searchBar
         searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        navigationController?.modalPresentationStyle = .fullScreen

        self.definesPresentationContext = true

        resultSearchController?.hidesNavigationBarDuringPresentation = false
        searchBar.setImage(UIImage(named: "cursor"), for: .search, state: .normal)
        
        searchVC.mapView = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //Assign Delegate and blank the search bar text
        searchBar?.text = ""
        searchBar?.delegate = self

    }
        
    private func getVehicle() {
        DispatchQueue.main.async{
            self.api.getVehicle(self.vehicleID) { (result: Result<Vehicle, Error>) in
                switch result {
                    case .success(let networkVehicle):
                        self.networkVehicle = networkVehicle
                        
                        if (networkVehicle.state == "asleep") {
                            _ = self.api.wakeUp(vehicle: networkVehicle).done{(response: Vehicle) -> Void in
                                self.getLocation()
                            }
                        } else {
                            self.getLocation()
                        }
                        
                        print("successfully loaded network vehicle")
                    case .failure(let error):
                        print("failure to auth API")
                        print(error.localizedDescription)
//                        DispatchQueue.main.async{
//                            let banner = StatusBarNotificationBanner(title: "Unable to connect to Tesla's Network", style: .danger)
//                            banner.show()
//                        }
                }
            }
        }
    }
    
    private func getLocation() {
        DispatchQueue.main.async{
            self.api.getVehicleDriveState(self.networkVehicle!) { (result: Result<DriveState, Error>) in
            switch result {
                case .success(let driveState):
                    self.vehicleLocation = driveState
                    
                    print("successfully loaded network vehicle")
                case .failure(let error):
                    print("failure to auth API")
                    print(error.localizedDescription)
                    DispatchQueue.main.async{
                        let banner = StatusBarNotificationBanner(title: "Unable to connect to Tesla's Network", style: .danger)
                        banner.show()
                    }
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.subtitle == "Your Vehicle" {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "charger-glyph")
            annotationView.image = UIImage(named: "vehicle-icon")
            
            return annotationView
        } else {
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "charger-glyph")
            annotationView.glyphImage = UIImage(named: "charger-glyph")
            annotationView.glyphTintColor = .white
            
            return annotationView
        }
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 5000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension RoutingVC: HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark){
        // center map between the start and end points

        let destination: MKPlacemark = placemark
        let annotation = MKPointAnnotation()
        print(vehicleLocation!.latitude!)
        print(vehicleLocation!.longitude!)
        print(destination.coordinate.latitude)
        print(destination.coordinate.longitude)
        if let vehicleCoords = vehicleLocation {
            let rawString = "https://api.tomtom.com/routing/1/calculateRoute/\(vehicleCoords.latitude!)%2\(vehicleCoords.longitude!)%3\(destination.coordinate.latitude)%2\(destination.coordinate.longitude)/json?key=ukGnJX18sgSGk7miWLxlL2PPbyuDhNsH"
            let tomtomUrl = URL(string: rawString)
            
            print(tomtomUrl.absoluteURL)
            var request = URLRequest(url: tomtomUrl!.absoluteURL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             
            let task = URLSession.shared.dataTask(with: tomtomUrl!) { data, response, error in
                if let data = data {
                    if let welcome8 = try? JSONDecoder().decode(Welcome8.self, from: data) {
                        let legs = welcome8.routes[0].legs
                        for i in 0..<legs.count {
                            print(legs[i])
//                            let annotation = MKPointAnnotation()
//                            annotation.coordinate = CLLocationCoordinate2D(latitude: charger.location[1], longitude: charger.location[0])
//                            annotation.subtitle = String(format: "Supercharger \n Stalls: %d", charger.stallCount)
//                            self.mapView.addAnnotation(annotation)
                        }
                    } else {
                        print("no chargers")
                    }
                } else if let error = error {
                    print("HTTP request failed \(error)")
                }
            }
            task.resume()
        }
        
//
//        // clear existing pins
////        mapView.removeAnnotations(mapView.annotations)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = placemark.coordinate
//        annotation.title = placemark.name
//        if let city = placemark.locality,
//        let state = placemark.administrativeArea {
//            annotation.subtitle = "(city) (state)"
//        }
//        mapView.addAnnotation(annotation)
//        let span = (0.05, 0.05)
//        let region = (placemark.coordinate, span)
        //mapView.setRegion(region, animated: true)
    }
}

extension RoutingVC: UIGestureRecognizerDelegate {
    func requestChargers() {
        let topRightLat = String(format: "%.5f", mapView.region.center.latitude + mapView.region.span.latitudeDelta / 2)
        let topRightLong = String(format: "%.5f", mapView.region.center.longitude + mapView.region.span.longitudeDelta / 2)
        let bottomLeftLat = String(format: "%.5f", mapView.region.center.latitude - mapView.region.span.latitudeDelta / 2)
        let bottomLeftLong = String(format: "%.5f", mapView.region.center.longitude - mapView.region.span.longitudeDelta / 2)
        
        urlComponents.queryItems = [
            URLQueryItem(name: "topRightLat", value: topRightLat),
            URLQueryItem(name: "topRightLong", value: topRightLong),
            URLQueryItem(name: "bottomLeftLat", value: bottomLeftLat),
            URLQueryItem(name: "bottomLeftLong", value: bottomLeftLong)
        ]
        let url = urlComponents.url!.absoluteURL
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let chargers = try? JSONDecoder().decode([Charger].self, from: data) {
                    for i in 0..<chargers.count {
                        let charger = chargers[i]
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: charger.location[1], longitude: charger.location[0])
                        annotation.subtitle = String(format: "Supercharger \n Stalls: %d", charger.stallCount)
                        self.mapView.addAnnotation(annotation)
                    }
                } else {
                    print("no chargers")
                }
            } else if let error = error {
                print("HTTP request failed \(error)")
            }
        }
        task.resume()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @objc func didDragMap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            requestChargers()
        }
    }

    @objc func didPinchMap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            requestChargers()
        }
    }
}

extension RoutingVC {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = .blue
        pinView?.canShowCallout = true
        
        let smallSquare = CGSize(width: 30, height: 30)
        
        let button = UIButton(frame: CGRect(origin: CGPointZero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), for: [])
        button.addTarget(self, action: Selector(("getDirections")), for: .touchUpInside)
        
        pinView?.leftCalloutAccessoryView = button
        
        return pinView
    }
}
