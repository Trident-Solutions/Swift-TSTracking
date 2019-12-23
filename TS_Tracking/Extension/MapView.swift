//
//  mapView.swift
//  TS_Tracking
//
//  Created by Gajalakshmi on 13/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import Foundation
import GoogleMaps

extension GMSMapView {
    
    static func commonMapviewVwProps() -> GMSMapView{
        
        let mapview = GMSMapView()
        mapview.translatesAutoresizingMaskIntoConstraints = false
        do{
            if let styleURL = Bundle.main.url(forResource: "DayStyle", withExtension: "json") {
                mapview.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }
        }
        catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        return mapview
    }
}
