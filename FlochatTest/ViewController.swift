//
//  ViewController.swift
//  FlochatTest
//
//  Created by Rushabh Bhatt on 29/01/18.
//  Copyright © 2018 Rushabh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var isLogin:Bool=true
    
    let loginText="LOGIN"
    let signupText="SIGN-UP"
    @IBOutlet weak var btnChangeAction: UIButton!
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginAction()
        btnChangeAction.backgroundColor=AppColor.orangeColor
        btnAction.backgroundColor=AppColor.blueColor
        btnChangeAction.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnAction.setTitleColor(UIColor.white, for: UIControlState.normal)
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.isUserInteractionEnabled=true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }

    @objc func dismissKeyboard(){
        tfUsername.resignFirstResponder()
        tfPassword.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func performAction(_ sender: Any) {
    }
    
    func loginUser(){
        let userInfo=UserInfo()
        let context=getCoreDataContext()
        
        
        let query:NSFetchRequest<UserInfo>=UserInfo.fetchRequest()
//        query.na
        
    }
    
    func reigsterUser(){
        
    }
    @IBAction func changeAction(_ sender: Any) {
        if(isLogin){
            setSignupAction()
        }else{
            setLoginAction()
        }
        
    }
    
    func setLoginAction(){
        isLogin=true
        btnAction.setTitle(loginText, for: UIControlState.normal)
        btnChangeAction.setTitle(signupText, for: UIControlState.normal)
    }
    func setSignupAction(){
        isLogin=false
        btnAction.setTitle(signupText, for: UIControlState.normal)
        btnChangeAction.setTitle(loginText, for: UIControlState.normal)
    }
}


