//
//  TrackingVC.swift
//  TS_Tracking
//
//  Created by Gajalakshmi on 12/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import UIKit
import GoogleMaps

class TrackingVC: UIViewController {
    
    var trackingMapView               = GMSMapView.commonMapviewVwProps()
    var locationDetailView            = UIView.makeForLocationView()
    var sourceTxtFld                  = UITextField.makeForSourceLocationTxtFld()
    var deliveryTxtFld                = UITextField.makeForDeliveryLocationTxtFld()
    var deliveryTableView             = UITableView.makeForChooseDeliveryTblVw()
    var noDataAvailLbl                = UILabel.makeForAdjustDeliveryLbl(text:LabelText.noData)

    //CLLocation Manager
    var locationManager               = CLLocationManager()
    var googleApIService              = GoogleApIService()

    //Timer
    var markerTimer                   : Timer?
    
    //MapZoomLevel
    var currentMapZoomLevel           : Float = 19
    var i                             : Int = 0

    //CurrentLocation Coordinates
    var currentLocationCoordinates    = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    // Animation coordinate
    var animationOldCoordinate        = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var animationNewCoordinate        = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var finalPolylineCoordinate       : [CLLocationCoordinate2D] =  [CLLocationCoordinate2D]()
    var routePolylineCoordinate       : [CLLocationCoordinate2D] =  [CLLocationCoordinate2D]()
    
    // Driver Marker
    var animationPositionMarker          = GMSMarker()

    //Polyline
    var sourceDottedPolyline          : GMSPolyline = GMSPolyline()
    var destDottedPolyline            : GMSPolyline = GMSPolyline()
    var routePolyline                 : GMSPolyline = GMSPolyline()
   
    //Path
    var polylinePath                  = GMSMutablePath()
    var gmsPolyline                   = GMSPolyline()

    var sourceCoordinate              = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var destinationCoordinate         = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var inrideArray                   : [CLLocationCoordinate2D] =  [CLLocationCoordinate2D]()

    //GMSMarker
    var destinationtMarker           = GMSMarker()
    var deliveryAddressList          : [ChooseDeliverAddressModel] = [ChooseDeliverAddressModel]()

    //Constraint
     var deliveryTableViewbottomConst  : NSLayoutConstraint!

    var firstTimeOpen                  : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        callCurrentLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }

}
