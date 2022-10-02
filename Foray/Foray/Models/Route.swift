//
//  Route.swift
//  Foray
//
//  Created by Eliot Winchell on 10/2/22.
//

import Foundation

// MARK: - Welcome8
struct Welcome8: Decodable {
    let formatVersion: String
    let routes: [Route]
}

// MARK: - Route
struct Route: Decodable {
    let summary: Summary
    let legs: [Leg]
    let sections: [Section]
}

// MARK: - Leg
struct Leg: Decodable {
    let summary: Summary
    let points: [Point]
}

// MARK: - Point
struct Point: Decodable {
    let latitude, longitude: Double
}

// MARK: - Summary
struct Summary: Decodable {
    let lengthInMeters, travelTimeInSeconds, trafficDelayInSeconds, trafficLengthInMeters: Int
    let departureTime, arrivalTime: Date
}

// MARK: - Section
struct Section: Decodable {
    let startPointIndex, endPointIndex: Int
    let sectionType, travelMode: String
}
