//
//  DeviceLocationDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

struct DeviceLocationRequest: Codable {
    let wifiInfo: WifiInfo
    let valueInfo: ValueInfo
    let location: Location
}

struct WifiInfo: Codable {
    let ssid: String
    let bssid: String
}

struct ValueInfo: Codable {
    let signalStrength: Int
    let batteryInfo: Int
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

struct DeviceLocationResponse: Codable {
    let serialNumber: String
    let wifiInfo: WifiInfoResponse
    let valueInfo: ValueInfo
    let location: Location
    let mappedLocation: MappedLocation
    let updatedAt: Date
}

struct WifiInfoResponse: Codable {
    let ssid: [String]
    let bssid: String
}

struct MappedLocation: Codable {
    let floor: Int
    let ward: String
}
