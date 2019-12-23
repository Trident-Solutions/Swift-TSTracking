//
//  UIView.swift
//  TS_Tracking
//
//  Created by Gajalakshmi on 19/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    static func makeForView() -> UIView {
        let view = UIView()
        view.frame = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }
    
    static func makeForLocationView() -> UIView{
        let view = UIView.makeForView()
        view.backgroundColor = UIColor.white
        view.dropShadow()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 4
        return view
    }
    
    func dropShadow() {
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
    }

}

