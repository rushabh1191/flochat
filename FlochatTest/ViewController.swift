//
//  ViewController.swift
//  FlochatTest
//
//  Created by Rushabh Bhatt on 29/01/18.
//  Copyright © 2018 Rushabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isLogin:Bool=true
    
    let loginText="LOGIN"
    let signupText="SIGN-UP"
    @IBOutlet weak var btnChangeAction: UIButton!
    @IBOutlet weak var btnAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginAction()
        btnChangeAction.backgroundColor=AppColor.orangeColor
        btnAction.backgroundColor=AppColor.blueColor
        btnChangeAction.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnAction.setTitleColor(UIColor.white, for: UIControlState.normal)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func performAction(_ sender: Any) {
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


