//
//  TableViewCell.swift
//  Pick Me Locals
//
//  Created by Trident on 19/02/19.
//  Copyright © 2019 Senthil. All rights reserved.
//

import UIKit

class ChooseDeliveryAddCell: UITableViewCell ,Identifiable {
    
    //
    //  VARIABLES & PARAMETERS
    //
    var baseView                   = UIView.makeForNavigationVw()
    var headerLabel                = UILabel.makeForTableHeaderLbl(text : "Saved Location")
    var titleLbl                   = UILabel.makeForTableTitleLbl(text : "Brittany Ferries")
    var descriptionLbl             = UILabel.makeForTableDescriptionLbl(text : "Wharf Rd, Portsmouth PO2 8RU, UK")
    var lineView                   = UIView.makeForTableSepLineView()
    var locationImageView          = UIImageView.makeForCommonImage(image: #imageLiteral(resourceName: "Recents"))
    var topSpaceVw                 = UIView.makeForView()
 
    var topSpaceVwHeightConst       : NSLayoutConstraint!
    var headerLabelHeightConst      : NSLayoutConstraint!

    // MARK: - LIFE CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.backgroundColor = .clear
    }
    
    /**
     -- layout subview
     -- set constraints
     **/
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.selectionStyle = .none
  
        contentView.addSubview(baseView)
        baseView.addSubview(locationImageView)
        baseView.addSubview(titleLbl)
        baseView.addSubview(descriptionLbl)
        baseView.addSubview(headerLabel)
        baseView.addSubview(lineView)
//        baseView.addSubview(topSpaceVw)

        
        NSLayoutConstraint.activate([
            baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            baseView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0),
            baseView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0),
            baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor , constant: 50),
            lineView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.4)
            ])
        
        NSLayoutConstraint.activate([
            descriptionLbl.leadingAnchor.constraint(equalTo: lineView.leadingAnchor, constant: 0),
            descriptionLbl.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -10),
            descriptionLbl.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -30),
            descriptionLbl.heightAnchor.constraint(equalToConstant: 20)
            ])
        
//        descriptionLbl.backgroundColor = .green

        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: descriptionLbl.leadingAnchor, constant: 0),
            titleLbl.bottomAnchor.constraint(equalTo: descriptionLbl.topAnchor, constant: -5),
            titleLbl.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -30),
            titleLbl.heightAnchor.constraint(equalToConstant: 20)
            ])
        
//        titleLbl.backgroundColor = .red

        NSLayoutConstraint.activate([
            locationImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 15),
            locationImageView.topAnchor.constraint(equalTo: titleLbl.topAnchor, constant: 5),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        headerLabelHeightConst = headerLabel.heightAnchor.constraint(equalToConstant: 20)

        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 15),
            headerLabel.bottomAnchor.constraint(equalTo: titleLbl.topAnchor, constant: -10),
            headerLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -35),
            headerLabelHeightConst
            ])
        
        topSpaceVwHeightConst = topSpaceVw.heightAnchor.constraint(equalToConstant: 2)
        
//        NSLayoutConstraint.activate([
//            topSpaceVw.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 0),
//            topSpaceVw.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 0),
//            topSpaceVw.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: 0),
//            topSpaceVwHeightConst
//            ])
//        
//        topSpaceVw.backgroundColor = UIColor.FlatColor.White.WhiteSmoke3
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
