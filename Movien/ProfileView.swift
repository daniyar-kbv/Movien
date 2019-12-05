//
//  Profile.swift
//  Movien
//
//  Created by Daniyar on 12/4/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher
import MapKit

class ProfileView: UIViewController, CLLocationManagerDelegate {
    var window: UIWindow?
    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    let distanceSpan: Double = 500
    
    lazy var labelAboutUs: UILabel = {
        var label = UILabel()
        label.text = "About us"
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 40)
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        var label = UILabel()
        label.text = "Address: 221B Baker Street, Almaty, KZ"
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 15)
        return label
    }()
    
    lazy var aboutUsTextView: UITextView = {
        let view = UITextView()
        view.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        view.textColor = .white
        view.backgroundColor = colorPrimary
        view.isSelectable = false
        view.isEditable = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 20)
        view.sizeToFit()
        return view
    }()
    
    lazy var mainView: UIView = {
        var view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markup()
        
    }
    
    func markup(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 450, width: (self.window?.frame.width)!, height: 400))
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 43.229346, longitude: 76.889637)
        self.mapView?.addAnnotation(annotation)
        mapView?.setCenter(CLLocationCoordinate2D(latitude: 43.229346, longitude: 76.889637), animated: false)
        
        view.backgroundColor = colorPrimary
        view.addSubview(mainView)
        mainView.snp.makeConstraints(){
            $0.top.left.equalTo(0)
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(450)
        }
        
        mainView.addSubview(labelAboutUs)
        labelAboutUs.snp.makeConstraints(){
            $0.top.equalTo(view.snp.top).offset(70)
            $0.left.equalTo(20)
        }
        
        mainView.addSubview(aboutUsTextView)
        aboutUsTextView.snp.makeConstraints(){
            $0.top.equalTo(labelAboutUs.snp.bottom).offset(12)
            $0.left.equalTo(0).offset(20)
            $0.right.equalTo(-20)
        }
        
        mainView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints(){
            $0.bottom.equalTo(mainView.snp.bottom).offset(-12)
            $0.left.equalTo(20)
        }
        
        view.addSubview(mapView!)
    }
}
