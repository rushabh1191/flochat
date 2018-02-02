//
//  UICellFoodCollectionItem.swift
//  FlochatTest
//
//  Created by Rushabh Bhatt on 31/01/18.
//  Copyright © 2018 Rushabh. All rights reserved.
//

import UIKit
import SDWebImage

class UICellFoodCollectionItem: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    static let height:CGFloat=110
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.greaterThanOrEqual, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 110))
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    func showData(collection:Collection){
        
        lblName.text=collection.collectionItem.title
        lblName.boldFont()
//        lblName.sizeToFit()
    lblDescription.backgroundColor=AppColor.blueColor
        lblName.backgroundColor=AppColor.orangeColor
        ivImage.sd_setImage(with: URL(string: collection.collectionItem.imageUrl!), placeholderImage: nil)

        lblDescription.text=collection.collectionItem.description.trim()
     
    }
    
    
}
