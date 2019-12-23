//
//  Tracking_Animation.swift
//  Pick Me Locals
//
//  Created by Gajalakshmi on 12/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

extension TrackingVC {
    
    func markerAnimation(coordinates: [CLLocationCoordinate2D]){
        
        i = 0
        //start the timer, change the interval based on your requirement
        markerTimer =  Timer.scheduledTimer(withTimeInterval:1.1, repeats: true, block: { (_) in
            if coordinates.count > self.i{
                
                self.animationNewCoordinate = coordinates[self.i]
                self.markerAnimaton()
                self.i = self.i + 1
            } else {
                self.markerTimer?.invalidate()
                self.markerTimer = nil
            }
        })
    }
    
    func markerAnimaton(){
        
        animationPositionMarker.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
        
        if  animationOldCoordinate.latitude == 0 {
            let currentPlace:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:animationNewCoordinate.latitude, longitude:animationNewCoordinate.longitude)
            self.animationPositionMarker.position = currentPlace
            
        }else if animationOldCoordinate.latitude != 0 && animationNewCoordinate.latitude != 0{            
            self.animationPositionMarker.rotation = self.getBearingBetweenTwoPoints(point1:self.animationOldCoordinate, point2:self.animationNewCoordinate)
            
            CATransaction.begin()
            CATransaction.setValue(Int(1.0), forKey: kCATransactionAnimationDuration)
            CATransaction.setCompletionBlock({() -> Void in
                self.animationPositionMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            })
            
            let currentPlace:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:self.animationNewCoordinate.latitude, longitude:self.animationNewCoordinate.longitude)
            self.animationPositionMarker.position = currentPlace
            let camera = GMSCameraPosition.camera(withTarget:CLLocationCoordinate2D(latitude:self.animationNewCoordinate.latitude, longitude:self.animationNewCoordinate.longitude), zoom: currentMapZoomLevel)
            self.trackingMapView.animate(to: camera)
            CATransaction.commit()
        }
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        imageView.image = #imageLiteral(resourceName: "CarImages")
        self.animationPositionMarker.iconView = imageView
        self.animationOldCoordinate = animationNewCoordinate
        self.animationPositionMarker.map = self.trackingMapView
    }
    
    //GetBearingBetweenTwoPoints
    
    func getBearingBetweenTwoPoints(point1 : CLLocationCoordinate2D, point2 : CLLocationCoordinate2D) -> Double {
        
        let lat1 = degreesToRadians(degrees: point1.latitude)
        let lon1 = degreesToRadians(degrees: point1.longitude)
        
        let lat2 = degreesToRadians(degrees: point2.latitude)
        let lon2 = degreesToRadians(degrees: point2.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        return radiansToDegrees(radians: radiansBearing)
    }
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
}
