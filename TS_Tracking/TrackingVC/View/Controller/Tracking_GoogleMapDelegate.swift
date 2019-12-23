//
//  Tracking_GoogleMapDelegate.swift
//  Pick Me Locals
//
//  Created by Gajalakshmi on 12/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import UIKit
import GoogleMaps

extension TrackingVC : GMSMapViewDelegate {

    func mapView(_ didChangemapView: GMSMapView, didChange position: GMSCameraPosition) {
        let currentZoom = self.trackingMapView.camera.zoom
        self.currentMapZoomLevel = currentZoom
        
    }
    
    func changeCamerLocation(coordinate:CLLocationCoordinate2D){
        let camera = GMSCameraPosition.camera(withTarget:CLLocationCoordinate2D(latitude:coordinate.latitude, longitude:coordinate.longitude), zoom: self.currentMapZoomLevel)
               self.trackingMapView.animate(to: camera)
    }
    
}
