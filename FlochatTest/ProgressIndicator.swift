//
//  ProgressIndicator.swift
//  retailerapp
//
// 
//  Copyright © 2017 Rushabh Bhatt. All rights reserved.
//

import Foundation

import UIKit

class ProgressIndicator:UIView{
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    var pView:UIView?
    
    var isVisible:Bool=false
    init(parentView:UIView) {
        super.init(frame:CGRect(x:0,y:0,width:80,height:80))
        self.pView=parentView
        actInd.frame = CGRect(x:0.0, y:0.0,width:40.0, height:40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        self.backgroundColor=UIColor.black
        actInd.center = CGPoint(x:self.frame.size.width / 2,
                                y:self.frame.size.height / 2);
        
        self.layer.cornerRadius=10
        self.backgroundColor=UIColor.black
        self.center=parentView.center
        self.addSubview(actInd)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startIndicator(){
        if(!isVisible){
        
            isVisible=true
        pView?.isUserInteractionEnabled=false
        pView?.addSubview(self)
        actInd.startAnimating()
        }
    }
    func stopIndicator(){
        isVisible=false
        pView?.isUserInteractionEnabled=true
        actInd.stopAnimating()
        self.removeFromSuperview()
        
    }
    
}
