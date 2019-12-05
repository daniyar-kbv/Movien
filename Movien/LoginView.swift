//
//  LoginView.swift
//  Movien
//
//  Created by Daniyar on 12/4/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class LoginView: UIViewController {
    lazy var mainView: UIView = {
        view = UIView()
        view.backgroundColor = colorPrimary
        return view
    }()
    
    lazy var labelMovien: UILabel = {
        var label = UILabel()
        label.text = "Movien"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "GillSans-UltraBold" , size: 50)
        return label
    }()
    
    lazy var loginTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 35
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.placeholder = "Enter login"
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 35
        textField.placeholder = "Enter password"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = colorAccentYellow
        button.layer.cornerRadius = 20
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    @objc func buttonAction(sender: UIButton!) {
        sender.pulsate()
        var requestToken = ""
        createRequestToken(){
            reqTok in
            requestToken = reqTok
            createSessionWithlogin(username: self.loginTextField.text!, password: self.passwordTextField.text!, requsetToken: requestToken){
                response in
                if response == "error"{
                    let alert = UIAlertController(title: "Login error", message: "Username or password you entered are not correct.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                requestToken = response
                createSession(requestToken: requestToken){
                    sessionId in
                    var dict = Dictionary<String,AnyObject>()
                    dict["session_id"] = sessionId as AnyObject
                    MySession.sharedInstance.myData = dict
                    self.toMainScreen()
                    return
                }
            }
        }
    }
    
    func toMainScreen(){
        let vc = MovieListView()
        let navController = UINavigationController(rootViewController: vc)
        
        let tabBarCnt = UITabBarController()
        tabBarCnt.tabBar.tintColor = colorAccentYellow
        tabBarCnt.tabBar.unselectedItemTintColor = .white
        tabBarCnt.tabBar.barTintColor = .black
        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0)]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
        
        let profileView = ProfileView()
        navController.title = "Movies"
        profileView.title = "AboutUs"
        tabBarCnt.viewControllers = [navController, profileView]
        tabBarCnt.modalPresentationStyle = .overFullScreen
        present(tabBarCnt, animated: true, completion: nil)
    }
    
    lazy var formStackView: UIStackView = {
        var view = UIStackView(arrangedSubviews: [labelMovien ,loginTextField, passwordTextField, submitButton])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 20
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markup()
    }
    
    func markup(){
        view.addSubview(mainView)
        
        view.addSubview(formStackView)
        formStackView.snp.makeConstraints(){
            $0.height.equalTo(350)
            $0.width.equalTo(350)
            $0.center.equalTo(mainView)
        }
        
        labelMovien.snp.makeConstraints(){
            $0.centerX.equalTo(formStackView.snp.centerX)
            $0.width.equalTo(formStackView.snp.width)
        }
        
        loginTextField.snp.makeConstraints(){
            $0.height.equalTo(70)
            $0.width.equalTo(formStackView.snp.width)
        }
        
        passwordTextField.snp.makeConstraints(){
            $0.height.equalTo(70)
            $0.width.equalTo(formStackView.snp.width)
        }
        
        submitButton.snp.makeConstraints(){
            $0.height.equalTo(40)
            $0.width.equalTo(100)
        }
    }
}

extension UIButton{
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 4
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
