//
//  UITextField.swift
//  TS_Tracking
//
//  Created by Gajalakshmi on 19/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import UIKit

enum FontSize : CGFloat {
    case textSize = 14
    case placeHolderSize = 15
}

enum UITextAutocapitalizationType : Int {
    case None
    case Words
    case Sentences
    case AllCharacters
}

extension UITextField{
    
    static func commonTxtFldProps() -> UITextField{
        let txtFld = UITextField()
        txtFld.translatesAutoresizingMaskIntoConstraints = false
        txtFld.keyboardType = UIKeyboardType.default
        txtFld.returnKeyType = UIReturnKeyType.next
        txtFld.font =  UIFont.systemFont(ofSize: FontSize.textSize.rawValue)
        txtFld.autocorrectionType = .no
        return txtFld
    }
    
    static func makeForDeliveryLocationTxtFld() -> UITextField{
        let txtFld = UITextField.commonTxtFldProps()
        txtFld.textAlignment = .left
        txtFld.textColor = UIColor.black
        txtFld.returnKeyType = .done
        txtFld.backgroundColor = UIColor.white
        txtFld.setLeftPaddingPoints(#imageLiteral(resourceName: "DestinationPoint"))
        txtFld.layer.cornerRadius = 5
        txtFld.layer.masksToBounds = true
        txtFld.attributedPlaceholder = NSAttributedString(string:"Enter Destination",attributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: FontSize.textSize.rawValue)])
        
        return txtFld
    }
    static func makeForSourceLocationTxtFld() -> UITextField{
        let txtFld = UITextField.commonTxtFldProps()
        txtFld.textAlignment = .left
        txtFld.textColor = UIColor.black
        txtFld.returnKeyType = .done
        txtFld.backgroundColor = UIColor.white
        txtFld.setLeftPaddingPoints(#imageLiteral(resourceName: "SourcePoint"))
        txtFld.layer.cornerRadius = 5
        txtFld.layer.masksToBounds = true
        txtFld.attributedPlaceholder = NSAttributedString(string:"Your Location",attributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: FontSize.textSize.rawValue)])
        return txtFld
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ image:UIImage){
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width:30, height: self.frame.size.height))
        let imageView = UIImageView(frame: CGRect(x: 5, y: (self.frame.size.height - 15) / 2, width: 15, height: 15))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        paddingView.addSubview(imageView)
        paddingView.backgroundColor = .red
        self.leftViewMode = .always
        self.leftView = paddingView
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
