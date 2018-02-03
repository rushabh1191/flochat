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
    
    static let USER_LOGGED_IN="user_logged_in"
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
        if(isLogin){
            loginUser()
        }else{
            registerUser()
        }
    }
    
    func loginUser(){
    
        let validityInfo=isValid()
        
        if(validityInfo.isValid){
            let context=getCoreDataContext()
    
            let fetchRequest:NSFetchRequest<UserInfo>=UserInfo.fetchRequest()
    
            print(validityInfo.username)
            
            fetchRequest.predicate=NSPredicate(format: "username==%@", validityInfo.username)
            fetchRequest.fetchLimit=1
            do{
                let result=try context.fetch(fetchRequest)
                if(result.count==0){
                    self.showAlert(message: "User does not exist")
                }else{
                    let user=result[0]
                    if(user.password==validityInfo.password){
                        self.sessionManager?.setUserLoggedIn(isLoggedIn: true)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ViewController.USER_LOGGED_IN), object: nil)
                        self.dismiss(animated: true, completion: nil)
                        
                    }else{
                        self.showAlert(message: "Password is invalid ")
                    }
                }
            }catch let error as NSError{
                print(error)
            }
            
        }
    

        
    }
    
    func isValid()->(isValid:Bool,username:String,password:String){
        var isValid:Bool=true
        if(tfUsername.text!.trim().count==0){
            showAlert(message:"Username can not be blank")
            isValid=false
        }
        
        if(tfPassword.text!.trim().count==0){
            showAlert(message:"Password can not be blank")
            isValid=false
        }
        
        return (isValid:isValid,username:tfUsername.text!.trim(),password:tfPassword.text!.trim())
    }
    
    
    func registerUser(){
    
        
        let validityInfo=isValid()
        if(validityInfo.isValid){
            let context=getCoreDataContext()
            context.mergePolicy=NSErrorMergePolicy
            let userInfo=UserInfo(context: context)
            userInfo.username=validityInfo.username
            userInfo.password=validityInfo.password
        
            do{
                    try context.save()
                showAlert(message: "User registered")
            }catch{
                // assuming error for test
                showAlert(message: "User already exist")
            }
            
            
        }
        
        
        
        
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


