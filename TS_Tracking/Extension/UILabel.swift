//
//  UILabel.swift
//  TS_Tracking
//
//  Created by Gajalakshmi on 19/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func commonLabelProps() -> UILabel{
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.white
        lbl.isUserInteractionEnabled = true
        return lbl
    }
    static func makeForAdjustDeliveryLbl(text:String) -> UILabel{
        let lbl = UILabel.commonLabelProps()
        lbl.text = text
        lbl.textAlignment = .center
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }

}
