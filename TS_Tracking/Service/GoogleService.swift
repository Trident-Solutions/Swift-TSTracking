//
//  GoogleService.swift
//  TS_Tracking
//
//  Created by Gajalakshmi on 12/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

class  GoogleApIService{
    
    private static let _instance               = GoogleApIService()
    
    //Mark:-> Google API Requests
    func retrieveGooglePlaceInformation(searchWord : String, completion:@escaping (NSArray) -> Void){
        let searchWordProtection:String = searchWord.replacingOccurrences(of: " ", with: "")
        
        var deliveryAddressModelArray  : [ChooseDeliverAddressModel] = [ChooseDeliverAddressModel]()
        
        if searchWordProtection.count != 0 {
            let currentLatitude: String = "13.0319"
            let currentLongitude : String = "80.2788"
            
            let urlString:String = "\(GoogleServices.placeAutocompleteApi)\(searchWord)&types=establishment|geocode&location=\(currentLatitude),\( currentLongitude),%@&radius=500&language=en&key=\(GoogleAPIKey.Key)&region=UK"
            
            let escapedString = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let url: URL = URL(string: escapedString!)!
            let defaultConfigObject:URLSessionConfiguration = URLSessionConfiguration.default
            let delegateFreeSession:URLSession = URLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: OperationQueue.main)
            let request:URLRequest = URLRequest(url: url)
            let task : URLSessionDataTask = delegateFreeSession.dataTask(with: request, completionHandler: { (data, response, error) in
                var jSONresult : [String:AnyObject] = Dictionary()
                do{
                    guard let responseData : Data = data else {return}
                    jSONresult = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    let results : NSArray = jSONresult["predictions"] as! NSArray
                    
                    let status : String = jSONresult["status"] as! String
                    if (status == "NOT_FOUND" || status == "REQUEST_DENIED"){
                        
                        var userInfo: [String : AnyObject] = Dictionary()
                        userInfo["error"] = status as AnyObject
                        
                        let newError: NSError = NSError(domain: "API Error", code: 666, userInfo: userInfo)
                        completion(["API Error", newError])
                    }
                    else{
                        let localSearchQueries = NSMutableArray(array: results)
                        
                        deliveryAddressModelArray.removeAll()
                        
                        for each in localSearchQueries{
                            
                            let searchResult : NSDictionary = each as! NSDictionary
                            let termsAry : [AnyObject] = (searchResult as AnyObject).value(forKey: "terms") as! [AnyObject]
                            let currentTermDic = termsAry[0]
                            let titleStr = ((currentTermDic as AnyObject).value(forKey: "value") as? String)
                            guard let description = (searchResult as AnyObject).value(forKey: "description") else { return
                            }
                            let placeID: String? = searchResult["place_id"] as? String
                            
                            let deliveryAddressModel = ChooseDeliverAddressModel(Title: titleStr ?? "", Description: description as! String, PlaceID: placeID ?? "")
                            deliveryAddressModelArray.append(deliveryAddressModel)
                            
                        }
                        completion(deliveryAddressModelArray as NSArray)
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
    }
    
    func fetchRoutePoints(startLocation : CLLocationCoordinate2D , destinationLocation :CLLocationCoordinate2D ,completion:@escaping (NSArray,[CLLocationCoordinate2D]) -> Void){
        let origin = "\(startLocation.latitude),\(startLocation.longitude)"
        let destination = "\(destinationLocation.latitude),\(destinationLocation.longitude)"
        
        let urlString = "\(GoogleServices.directionApi)\(origin)&destination=\(destination)&units=imperial&mode=driving&key=\(GoogleAPIKey.Key)"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    let routes = json["routes"] as! NSArray
                    var locationCoordinateArray:[CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
                    
                    if routes.count > 0 {
                        // let path  = GMSMutablePath()
                        let route = routes[0] as! [String:Any]
                        let legs = route[GoogleAPIService.legs] as! NSArray
                        let leg = legs[0] as! [String:Any]
                        let steps =  leg[GoogleAPIService.steps] as! NSArray
                        
                        for each in steps{
                            let eachDict = each as! [String:Any]
                            let PolylinePath = eachDict["polyline"] as! NSDictionary
                            let points = PolylinePath["points"] as! NSString
                            let polyLinePath : GMSPath = GMSPath(fromEncodedPath: points as String)!
                            for i in 0...polyLinePath.count() {
                                let str = "\(polyLinePath.coordinate(at: i))"
                                if str != "CLLocationCoordinate2D(latitude: -180.0, longitude: -180.0)"{
                                    locationCoordinateArray.append(polyLinePath.coordinate(at: i))
                                    
                                }
                            }
                        }
                        completion(routes,locationCoordinateArray)
                    }else{
                        completion(routes,locationCoordinateArray)
                    }
                }catch let error as NSError{
                    print("error:\(error)")
                }
            }
        }).resume()
    }
    
    
    func getPlaceDetails(place: String, completion: @escaping (_ complete: NSDictionary) -> Void) {
        
        let urlString: String = "\(GoogleServices.placeIdApi)\(place)&key=\(GoogleAPIKey.Key)"
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        let url: URL = URL(string: escapedString!)!
        let urlSessionConfig: URLSessionConfiguration = URLSessionConfiguration.default
        let defaultFreeSession: URLSession = URLSession(configuration: urlSessionConfig, delegate: nil, delegateQueue: OperationQueue.main)
        let request: URLRequest = URLRequest(url: url)
        let task: URLSessionTask = defaultFreeSession.dataTask(with: request) { (data, response, err) in
            var jsonResult: [String: AnyObject] = Dictionary()
            do {
                guard let responseData: Data = data else {return}
                jsonResult = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                let results: NSDictionary = jsonResult["result"] as! NSDictionary
                
                let status = jsonResult["status"] as! String
                if (status == "NOT_FOUND") || (status == "REQUEST_DENIED") {
                    var userInfo: [String: AnyObject] = Dictionary()
                    userInfo["error"] = status as AnyObject?
                    let newError: NSError = NSError(domain: "API Error", code: 666, userInfo: userInfo)
                    completion(["API Error": newError])
                } else {
                    completion(results)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
