//
//  Define.swift
//  TS_Tracking
//
//  Created by Gajalakshmi on 13/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import Foundation

public struct GoogleServices{
    static let directionApi = "https://maps.googleapis.com/maps/api/directions/json?origin="
    static let placeAutocompleteApi = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="
    static let placeIdApi = "https://maps.googleapis.com/maps/api/place/details/json?placeid="
}

public struct GoogleAPIKey{
    static let Key =  "xxxx"
}

struct GoogleAPIService {
    static let legs               = "legs"
    static let end_location       = "end_location"
    static let start_location     = "start_location"
    static let lat                = "lat"
    static let lng                = "lng"
    static let points             = "points"
    static let overview_polyline  = "overview_polyline"
    static let distance           = "distance"
    static let duration           = "duration"
    static let steps              = "steps"
    static let geometry           = "geometry"
    static let location           = "location"
    static let formatted_address  = "formatted_address"
}

struct LabelText {
    static let noData = "No Data Available"
}

struct TextFieldext {
    static let Home = "Your Location"
}


struct ChooseDeliverAddressModel {
    var Title       : String
    var Description : String
    var PlaceID     : String
}
