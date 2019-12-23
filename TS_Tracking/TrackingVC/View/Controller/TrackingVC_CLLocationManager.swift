//
//  TrackingVC_CLLocationManager.swift
//  Pick Me Locals
//
//  Created by Gajalakshmi on 12/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

extension TrackingVC {
    
    //Mark:- Call Current Location
    
    func callCurrentLocation() {
        locationManager.delegate = self
        locationManager.distanceFilter = .nan; //whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension TrackingVC : CLLocationManagerDelegate {
    
    //Mark:- CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error" + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        trackingMapView.animate(toBearing: newHeading.trueHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if manager.location != nil {
            
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            
            if firstTimeOpen {
                self.currentLocationCoordinates = locValue
                firstTimeOpen = false
                self.sourceCoordinate = locValue
                self.sourceCoordinate = CLLocationCoordinate2D(latitude: 51.719552, longitude: -3.469461)
                self.changeCamerLocation(coordinate:self.sourceCoordinate)
                self.sourceTxtFld.text = TextFieldext.Home
            }else{
                if sourceCoordinate.latitude != 0 && destinationCoordinate.latitude != 0 {
                    var speed: CLLocationSpeed = CLLocationSpeed()
                    speed = (locationManager.location?.speed)!
                    
                    if speed > 1 {
                        
                        DispatchQueue.main.async {
                            self.inrideArray.append(locValue)
                            let coordinate₀ = CLLocation(latitude: self.inrideArray[0].latitude, longitude: self.inrideArray[0].longitude)
                            let coordinate₁ = CLLocation(latitude:locValue.latitude, longitude:locValue.longitude)
                            let distanceInMeters = coordinate₀.distance(from: coordinate₁) // result is in meters
                            let lastCoordinate = CLLocation(latitude: self.inrideArray[self.inrideArray.count - 1].latitude, longitude:self.inrideArray[self.inrideArray.count - 1].longitude)
                            let destinationLocation = CLLocation(latitude:self.destinationCoordinate.latitude, longitude:self.destinationCoordinate.longitude)
                            let destinationDistanceInMeters = lastCoordinate.distance(from:destinationLocation)
                            
                            if distanceInMeters > 20 || destinationDistanceInMeters < 20{
                                self.inrideArray.removeAll()
                                self.currentLocationCoordinates = locValue
                                
                                if GMSGeometryIsLocationOnPathTolerance(CLLocationCoordinate2D(latitude:self.currentLocationCoordinates.latitude,longitude:self.currentLocationCoordinates.longitude), self.polylinePath, true, 30){
                                    
                                    let tapLocation = CLLocation(latitude: self.currentLocationCoordinates.latitude, longitude: self.currentLocationCoordinates.longitude)
                                    
                                    self.routePolylineCoordinate.removeAll()
                                    self.animateCarwithPolylinePoint(myLocation: tapLocation)
                                }else{
                                    print("Not on path")
                                    self.routePolylineCoordinate.append(self.currentLocationCoordinates)
                                    self.animateCarwithDriverCoordinateArray(coordinateArray: self.routePolylineCoordinate)
                                }
                            }
                        }
                        
                    }
                    
                }
            }
            
        }
    }
}
