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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.lblDescription.text=nil
    }
    func showData(collection:Collection){
        lblName.text=collection.collectionItem.title
        lblName.boldFont()
        
        ivImage.sd_setImage(with: URL(string: collection.collectionItem.imageUrl!), placeholderImage: nil)

        lblDescription.text=collection.collectionItem.description.trim()
        lblDescription.sizeToFit()
        lblDescription.layoutIfNeeded()
        lblDescription.adjustsFontSizeToFitWidth = true
    }
    
    
}
