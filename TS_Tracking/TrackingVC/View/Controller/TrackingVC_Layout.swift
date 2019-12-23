//
//  TrackingVC_Layout.swift
//  Pick Me Locals
//
//  Created by Gajalakshmi on 12/12/19.
//  Copyright © 2019 Gajalakshmi. All rights reserved.
//


import UIKit

extension TrackingVC {
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Setup
    
    func setupUI()  {
        
        self.trackingMapView.delegate = self
        self.trackingMapView.isMyLocationEnabled = true
        
        self.deliveryTableView.dataSource = self
        self.deliveryTableView.delegate = self
        
        self.deliveryTxtFld.delegate = self
        self.sourceTxtFld.isUserInteractionEnabled  = false
        self.deliveryTableView.allowsSelection = true
        self.deliveryTableView.alpha = 0
        
        layoutViews()
            
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---    
    
    //Mark:- layoutViews
    
    func layoutViews() {
        
        self.view.addSubview(trackingMapView)
        self.view.addSubview(locationDetailView)
        locationDetailView.addSubview(sourceTxtFld)
        locationDetailView.addSubview(deliveryTxtFld)
        self.view.addSubview(deliveryTableView)
        deliveryTableView.addSubview(noDataAvailLbl)
        
        NSLayoutConstraint.activate([
            trackingMapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            trackingMapView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            trackingMapView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0),
            trackingMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            locationDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            locationDetailView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            locationDetailView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            locationDetailView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            sourceTxtFld.topAnchor.constraint(equalTo: locationDetailView.topAnchor, constant: 5),
            sourceTxtFld.centerXAnchor.constraint(equalTo: locationDetailView.centerXAnchor, constant: 0),
            sourceTxtFld.widthAnchor.constraint(equalTo: locationDetailView.widthAnchor, constant: -40),
            sourceTxtFld.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            deliveryTxtFld.bottomAnchor.constraint(equalTo: locationDetailView.bottomAnchor, constant:-5),
            deliveryTxtFld.leadingAnchor.constraint(equalTo: sourceTxtFld.leadingAnchor, constant: 0),
            deliveryTxtFld.widthAnchor.constraint(equalTo: sourceTxtFld.widthAnchor, constant: 0),
            deliveryTxtFld.heightAnchor.constraint(equalTo: sourceTxtFld.heightAnchor, constant: 0)
        ])
        
        
        NSLayoutConstraint.activate([
            deliveryTableView.topAnchor.constraint(equalTo: locationDetailView.bottomAnchor, constant:1),
            deliveryTableView.centerXAnchor.constraint(equalTo: locationDetailView.centerXAnchor, constant:0),
            deliveryTableView.widthAnchor.constraint(equalTo: locationDetailView.widthAnchor, constant:0),
            deliveryTableView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            noDataAvailLbl.centerYAnchor.constraint(equalTo: deliveryTableView.centerYAnchor, constant: 0),
            noDataAvailLbl.centerXAnchor.constraint(equalTo: deliveryTableView.centerXAnchor, constant: 0),
            noDataAvailLbl.widthAnchor.constraint(equalTo: deliveryTableView.widthAnchor, constant: 0),
            noDataAvailLbl.heightAnchor.constraint(equalToConstant:30)
        ])
    }
}
