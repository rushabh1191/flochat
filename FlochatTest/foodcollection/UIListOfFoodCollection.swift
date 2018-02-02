//
//  UIListOfFoodCollection.swift
//  FlochatTest
//
//  Created by Rushabh Bhatt on 31/01/18.
//  Copyright © 2018 Rushabh. All rights reserved.
//

import UIKit

class UIListOfFoodCollection: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tblFoodColllection: UITableView!
    var listOfFoodModel:Array<Collection>=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblFoodColllection.registerCell(type: UICellFoodCollectionItem.self)
        
        tblFoodColllection.dataSource=self
        tblFoodColllection.delegate=self
self.tblFoodColllection.estimatedRowHeight = UICellFoodCollectionItem.height;
        self.fetchItems()
        // Do any additional setup after loading the view.
    }


    func fetchItems(){
        self.showProgressIndicator()
        apiEndPoints.fetchFoodItems().subscribe(onNext: { (foodCollection) in
            self.hideProgressIndicator()
            self.listOfFoodModel.append(contentsOf: foodCollection.collection)
            self.tblFoodColllection.reloadData()
        }, onError: { (error) in
            self.handlerError(error: error)
        }, onCompleted: {
            
        }) {
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfFoodModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: UICellFoodCollectionItem.getClassName(), for: indexPath) as! UICellFoodCollectionItem
        
        cell.showData(collection: listOfFoodModel[indexPath.item])
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
