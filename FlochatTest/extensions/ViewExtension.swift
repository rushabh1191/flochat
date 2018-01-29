//
//  ViewExtensions.swift
//  Pneumics
//
//  Created by Rushabh Bhatt on 29/11/17.
//  Copyright © 2017 IPS Group. All rights reserved.
//

import Foundation
import UIKit    
extension UIView{
    
    func hideViewWithAnimation(){
        
    }
    
    func showViewWithAnimation() {
        
    }
    func removeSubViews(){
        for v in self.subviews{
            v.removeFromSuperview()
        }
    }
    
    func animate(){
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        })
    }
    
    static func getClassName()->String{
        return String(describing: self)
    }
    
}


extension UILabel{
    func boldFont(){
        self.font = UIFont.boldSystemFont(ofSize: self.font.pointSize)
    }
    
    func  setFontSize(size:CGFloat) {
        self.font=UIFont(name: self.font.fontName, size: size)
    }
}



extension UITableView{
    func removeSeparator(){
        self.tableFooterView=UIView()
    }
    
    func registerCell<T>(type:T){
        
        // make cell identifier as class name as this wont work
        let name=String(describing: type)
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }

}
