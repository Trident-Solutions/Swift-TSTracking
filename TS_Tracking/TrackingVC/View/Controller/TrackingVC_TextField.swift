//
//  ChooseDeliveryAddVC_TextField.swift
//  Pick Me Locals
//
//  Created by Gajalakshmi on 19/02/19.
//  Copyright © 2019 Senthil. All rights reserved.
//

import UIKit

extension TrackingVC : UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == deliveryTxtFld{
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with:string)
            
            if newString.count > 0{
                
                self.autoCompleteService(input : newString)
                
            }else{
                
                deliveryAddressList.removeAll()
                
                self.deliveryAddressListContainsObject()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.deliveryTableView.alpha = 0

        return true
    }
    
    //Auto Completed
    func autoCompleteService(input : String) {
        
        self.deliveryTableView.alpha = 1

        DispatchQueue.global(qos: .default).async {
            
            self.googleApIService.retrieveGooglePlaceInformation(searchWord: input , completion: { (results : NSArray) in
                
                DispatchQueue.main.async {

                    //Set API Response to filterTempAddressList
                    
                    var locationSearchList:[ChooseDeliverAddressModel] = [ChooseDeliverAddressModel]()
                    
                    locationSearchList = results as! [ChooseDeliverAddressModel]
                    
                    self.deliveryAddressList = locationSearchList
                    
                    self.deliveryAddressListContainsObject()
                }
                
            })
        }
    }
    
    func deliveryAddressListContainsObject() {
        
        if self.deliveryAddressList.count > 0{
            
            self.noDataAvailLbl.alpha = 0
            
        }else{
            
            self.noDataAvailLbl.alpha = 1
        }
        self.deliveryTableView.reloadData()
    }
}


