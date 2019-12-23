//
//  UITableView.swift
//  TS_Tracking
//
//  Created by Gajalakshmi on 19/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//

import UIKit

extension UITableView {
    
    static func commmonTblVwProps() -> UITableView {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.backgroundColor = .clear
        return table
    }
    
    static func makeForChooseDeliveryTblVw() -> UITableView{
        let table = UITableView.commmonTblVwProps()
        table.backgroundColor = .white
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }
}
