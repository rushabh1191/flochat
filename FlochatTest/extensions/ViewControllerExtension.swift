//
//  ViewControllerExtension.swift
//  retailerapp
//
//  Copyright © 2017 Rushabh Bhatt. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func associatedObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    initialiser: () -> ValueType)
    -> ValueType {
        if let associated = objc_getAssociatedObject(base, key)
            as? ValueType { return associated }
        let associated = initialiser()
        objc_setAssociatedObject(base, key, associated,
                                 .OBJC_ASSOCIATION_RETAIN)
        return associated
}
func associateObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    value: ValueType) {
    objc_setAssociatedObject(base, key, value,
                             .OBJC_ASSOCIATION_RETAIN)
}

private var progressKey: UInt8 = 0
private var sessionObjectKey:UInt8=1
private var apiKey:UInt8=2
private var reachabilityValue:UInt8=3

extension UIViewController{
    
    
   
    func getInternetErrorMessage()->NSAttributedString{
        let attribts=[NSAttributedStringKey.foregroundColor : UIColor.black,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16)]
        
        
        let text="No internet connection\n\n"
        let attributedText=NSMutableAttributedString(string: text, attributes: attribts)
        let attribt2=[NSAttributedStringKey.foregroundColor : UIColor.red,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)]
        attributedText.append(NSAttributedString(string: "Please check your internet settings & try again", attributes: attribt2))
        return attributedText
    }
    
    func call(number:String){
        if let url = URL(string: "tel://\(number)"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            showAlert(message: "Could not dial "+number)
        }

    }
    
    func openUrl(url:String){
        UIApplication.shared.open(URL(string:url)!, options: [:], completionHandler: nil)
    }
    @objc func dismissVC(sender:UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
        var mProgressIndicator: ProgressIndicator? {
        set{
            
           associateObject(base: self, key: &progressKey, value: newValue!)
        }
        get {
        
            return associatedObject(base: self, key: &progressKey, initialiser: { () -> ProgressIndicator in
                return ProgressIndicator(parentView:self.view)
            })
        }
        
    }
    
    var sessionManager : SessionHelper?{
        set{
            associateObject(base: self, key: &sessionObjectKey, value: newValue!)
        }
        get {
            
            return associatedObject(base: self, key: &sessionObjectKey, initialiser: { () -> SessionHelper in
                return SessionHelper()
            })
        }
        
    }
    
    var apiEndPoints : ApiEndPoints!{
        set{
            associateObject(base: self, key: &apiKey, value: newValue)
        }
        get {
            
            return associatedObject(base: self, key: &apiKey, initialiser: { () -> ApiEndPoints in
                return ApiEndPoints()
            })
        }
        
    }
    
    func animate(){
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    func showProgressIndicator(vc:UIViewController? = nil) {
    
        let viewController = vc ?? self
        viewController.mProgressIndicator?.startIndicator()
    }
    
    func hideProgressIndicator(vc:UIViewController? = nil){
        let viewController = vc ?? self
        viewController.mProgressIndicator?.stopIndicator()
    }
    
    func share(message:Array<String>){
        let activityViewController = UIActivityViewController(activityItems: message, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    func showAlert(message:String,alertActions:UIAlertAction...){
        let alert = UIAlertController(title: "Alert", message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        for action in alertActions{
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    

    func getCoreDataContext()->NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func showAlert(message:String,title:String,alertActions:Array<UIAlertAction>){
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        for var action in alertActions {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handlerError(error:Error){
        self.hideProgressIndicator()
        if(type(of: error) == ErrorResponse.self){
            showAlert(message: (error as! ErrorResponse).message!)
        }
        else{
            showAlert(message: error.localizedDescription)
        }
        
    }
    
    func loadVC(vcName:String)->UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: vcName)
    }
    
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
