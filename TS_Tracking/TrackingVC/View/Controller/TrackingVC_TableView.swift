//
//  ChooseDeliveryAddVC_TableView.swift
//  Pick Me Locals
//
//  Created by Gajalakshmi on 12/02/19.
//  Copyright © 2019 Senthil. All rights reserved.
//

import UIKit
import CoreLocation

extension TrackingVC : UITableViewDelegate , UITableViewDataSource{
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return deliveryAddressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        cell.textLabel?.text = deliveryAddressList[indexPath.row].Title
        cell.textLabel?.textColor = UIColor.lightGray
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.deliveryTxtFld.text = deliveryAddressList[indexPath.row].Title
        self.deliveryTableView.alpha = 0
        self.view.endEditing(true)
        trackingMapView.clear()
        self.googleApIService.getPlaceDetails(place: deliveryAddressList[indexPath.row].PlaceID, completion: { (place :  NSDictionary) in
            
            let geometryDic  : NSDictionary = place[GoogleAPIService.geometry] as! NSDictionary
            let locationDic : NSDictionary = geometryDic[GoogleAPIService.location] as! NSDictionary
            let destinationLat : NSNumber = locationDic[GoogleAPIService.lat] as! NSNumber
            let destinationLong : NSNumber = locationDic[GoogleAPIService.lng] as! NSNumber
            
            self.destinationCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(truncating: destinationLat), longitude: CLLocationDegrees(truncating: destinationLong))

            self.drawRoute(source: self.sourceCoordinate, destination: self.destinationCoordinate, IsPaddingEnable: true) {
                print("Polyline Draw at First Time")
            }

        })
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
    
}
