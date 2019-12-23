//
//  TrackingVC_Services.swift
//  Pick Me Locals
//
//  Created by Gajalakshmi on 12/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//


import UIKit
import CoreLocation
import GoogleMaps

extension TrackingVC {

    func  animateCarwithDriverCoordinateArray(coordinateArray:[CLLocationCoordinate2D]){
        self.sourceDottedPolyline.map = nil
        self.gmsPolyline.map = nil
        self.drawRoute(source: self.currentLocationCoordinates, destination: self.destinationCoordinate, IsPaddingEnable: true) {}
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1, execute: {
            self.markerAnimation(coordinates: coordinateArray)
        })
    }
    
    func animateCarwithPolylinePoint(myLocation:CLLocation){
        var smallestDistance: CLLocationDistance = 30
        var splitArray : [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        for i in 0..<self.finalPolylineCoordinate.count {
            let eachCoordinate = self.finalPolylineCoordinate[i]
            let eachLocation = CLLocation(latitude: eachCoordinate.latitude, longitude: eachCoordinate.longitude)
            let distanceInMeter = myLocation.distance(from: eachLocation)
            if  Double(distanceInMeter) < Double(smallestDistance){
                smallestDistance = distanceInMeter
                splitArray.removeAll()
                splitArray =  Array(self.finalPolylineCoordinate[0..<i])
            }
        }
        
        if splitArray.count > 0{
            self.sourceDottedPolyline.map = nil
            self.gmsPolyline.map = nil
            
            if splitArray.count == 1 {
                self.finalPolylineCoordinate.remove(at: 0)
            }else{
                self.finalPolylineCoordinate = Array(self.finalPolylineCoordinate[splitArray.count-1..<self.finalPolylineCoordinate.count])
            }
            
            self.drawPolylineWithArrayOfPoints(polylineCoordinates: self.finalPolylineCoordinate)
            if self.markerTimer != nil{
                self.markerTimer?.invalidate()
                self.markerTimer = nil }
            self.animationOldCoordinate.latitude = 0
            self.animationOldCoordinate.longitude = 0
            self.animationNewCoordinate = CLLocationCoordinate2D(latitude:splitArray[0].latitude,longitude:splitArray[0].longitude)
            
            if splitArray.count == 1{
                self.markerAnimation(coordinates: [self.finalPolylineCoordinate[0]])
            }else{
                self.markerAnimation(coordinates: splitArray)
            }
        }
    }
    
    //Mark:-  DrawLinePath
    
    func drawPolylineWithArrayOfPoints(polylineCoordinates:[CLLocationCoordinate2D]){
        polylinePath = GMSMutablePath()
        for eachCoordinate in polylineCoordinates {
            polylinePath.add(eachCoordinate)
        }
        
        gmsPolyline = GMSPolyline(path: polylinePath)
        gmsPolyline.strokeWidth = 3
        gmsPolyline.strokeColor = UIColor.black
        gmsPolyline.map = trackingMapView
    }
    
    //Mark:-  DrawRoute_EnRoute_Inride_Trip
    
    func drawRoute
        (source:CLLocationCoordinate2D ,destination:CLLocationCoordinate2D,IsPaddingEnable:Bool, completion:@escaping () -> Void){
        if source.latitude != 0  &&   destination.latitude != 0{
            
            self.googleApIService.fetchRoutePoints(startLocation:source, destinationLocation:  destination, completion: { (routes :  NSArray, coodinates: [CLLocationCoordinate2D]) in
                
                OperationQueue.main.addOperation({
                    if routes.count > 0{
                        let route = routes[0] as! [String:Any]
                        self.getFirst_Last_CoordinateOfPath(route: route, completion: { (firstCordinate, lastCordinate,leg) in
//                            UIView.animate(withDuration: 0.5, animations: {
//                                let camera = GMSCameraPosition.camera(withLatitude: firstCordinate.latitude ,longitude: firstCordinate.longitude , zoom: self.currentMapZoomLevel)
//                                self.trackingMapView.animate(to: camera)
//                            })
                            
                            self.finalPolylineCoordinate = coodinates
                            self.drawPolylineWithArrayOfPoints(polylineCoordinates: coodinates)
                            
                            let count = self.drawLinePath(routes: routes, IsPaddingEnable: IsPaddingEnable)
                            if count > 1 {
                                self.sourceDottedPolyline.map = nil
                                self.destDottedPolyline.map = nil
                                
                                if IsPaddingEnable {
                                    self.sourceDottedPolyline =  self.drawDottedPath(coordinate1: firstCordinate, coordinate2:source)
                                    self.animationPositionMarker.position = source
                                    self.sourceDottedPolyline.map =  self.trackingMapView
                                    
                                    let size = CGSize(width:20, height:30)
                             
                                    DispatchQueue.main.async {
                                        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:size.width, height: size.height))
                                        imageView.image = #imageLiteral(resourceName: "CarImages")
                                        self.animationPositionMarker.iconView = imageView
                                        self.animationPositionMarker.position =  source//self.driverNewCoordinate
                                        self.animationPositionMarker.map = self.trackingMapView
                                    }
                                }
                                
                                self.destDottedPolyline = self.drawDottedPath(coordinate1: lastCordinate, coordinate2: destination)
                                self.destDottedPolyline.map =  self.trackingMapView
                            }
                        })
                    }
                    
                    if IsPaddingEnable{
                        if destination.latitude != 0 {
                            let startLocation = destination
                            self.destinationtMarker = GMSMarker()
                            self.destinationtMarker.position = startLocation
                            let mrkVw = UIView()
                            mrkVw.frame = CGRect(x: 0, y: 0, width: 50, height: 70)
                            let markerView = UIImageView(image: #imageLiteral(resourceName: "Destination"))
                            mrkVw.addSubview(markerView)
                            markerView.frame = CGRect(x: 0, y: 10, width: 50, height: 70)
                            markerView.contentMode = .scaleAspectFit
                            self.destinationtMarker.iconView = mrkVw
                            self.destinationtMarker.iconView?.contentMode = .scaleAspectFit
                            self.destinationtMarker.map = self.trackingMapView
                        }
                    }
                    
                    completion()
                })
            })
        }else{
            
            self.locationManager.stopUpdatingHeading()
            completion()
        }
    }
    
    func getFirst_Last_CoordinateOfPath(route:[String:Any],completion:@escaping (CLLocationCoordinate2D,CLLocationCoordinate2D,[String:Any]) -> Void){
        
        let legs = route[GoogleAPIService.legs] as! NSArray
        let leg = legs[0] as! [String:Any]
        let endlocationValue =  leg[GoogleAPIService.end_location] as! NSDictionary
        let lat : NSNumber = endlocationValue[GoogleAPIService.lat] as! NSNumber
        let long : NSNumber = endlocationValue[GoogleAPIService.lng] as! NSNumber
        let lastCordinate  = CLLocationCoordinate2D(latitude: CLLocationDegrees(truncating: lat), longitude: CLLocationDegrees(truncating: long))
        
        
        let startlocationValue =  leg[GoogleAPIService.start_location] as! NSDictionary
        let lat1 : NSNumber = startlocationValue[GoogleAPIService.lat] as! NSNumber
        let long1 : NSNumber = startlocationValue[GoogleAPIService.lng] as! NSNumber
        let firstCordinate  = CLLocationCoordinate2D(latitude: CLLocationDegrees(truncating: lat1), longitude: CLLocationDegrees(truncating: long1))
        completion(firstCordinate,lastCordinate,leg)
    }
    
    //Mark:-  DrawLinePath
    
    func drawLinePath(routes: NSArray, IsPaddingEnable:Bool) -> UInt{
        
        routePolyline.map = nil
        for route in routes{
            let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: GoogleAPIService.overview_polyline) as! NSDictionary
            let points = routeOverviewPolyline.object(forKey: GoogleAPIService.points)
            let path = GMSPath.init(fromEncodedPath: points! as! String)
            routePolyline = GMSPolyline.init(path: path)
            routePolyline.strokeWidth = 3
            routePolyline.strokeColor = UIColor.black
            if IsPaddingEnable{
                let bounds = GMSCoordinateBounds(path: path!)
                self.trackingMapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 40.0))
            }
            //            routePolyline.map = self.mapView
            return (path?.count())!
        }
        return 0
    }
    
    //Mark:-  DrawDottedPath
    
    func drawDottedPath(coordinate1:CLLocationCoordinate2D ,coordinate2:CLLocationCoordinate2D) -> GMSPolyline
    {
        let dottedPath = GMSMutablePath()
        dottedPath.add(coordinate1)
        dottedPath.add(coordinate2)
        
        let dottedPolyline = GMSPolyline.init(path: dottedPath)
        dottedPolyline.strokeWidth = 3
        let styles = [GMSStrokeStyle.solidColor(.lightGray),GMSStrokeStyle.solidColor(.clear)]
        dottedPolyline.spans = GMSStyleSpans(dottedPath, styles,[1,1],  GMSLengthKind(rawValue: 1)!)
        return dottedPolyline
    }
    

}
