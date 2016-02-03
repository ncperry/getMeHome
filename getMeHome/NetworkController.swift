//
//  NetworkController.swift
//  getMeHome
//
//  Created by Nate Perry on 2/2/16.
//  Copyright © 2016 Nate Perry. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SWXMLHash

let devToken = "UQCCW0V0QNQ"

enum Route: String {
    case r750 = "750"
}

struct Vehicle {
    let location: CLLocation
}

extension NSData {
    var asString: String? {
        return String(data: self, encoding: NSUTF8StringEncoding)
    }
}

class NetworkController {
    static func getRoute(route: Route, completion: Result<Vehicle, NSError> -> ()) {
        let path = "http://api.rideuta.com/SIRI/SIRI.svc/VehicleMonitor/ByRoute?route=\(route.rawValue)&onwardcalls=false&usertoken=\(devToken)"
        Alamofire.request(.GET, path).response { (request, response, data, error) in
            let xml = SWXMLHash.parse(data!)
            let firstJourney = xml["Siri"]["VehicleMonitoringDelivery"]["VehicleActivity"]["MonitoredVehicleJourney"][0]
            let firstLocation = firstJourney["VehicleLocation"]
            let latitude = firstLocation["Latitude"].element?.text
            let longitude = firstLocation["Longitude"].element?.text
            
            if let latitude = latitude, longitude = longitude, latDegrees = Double(latitude), longDegress = Double(longitude) {
                let location = CLLocation(latitude: latDegrees, longitude: longDegress)
                let vehicle = Vehicle(location: location)
                print("sucessfully parsed one vehicle!")
                print("vehicle: \(vehicle)")
                completion(.Success(vehicle))
            }
        }
    }
}