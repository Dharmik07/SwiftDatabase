//
//  customecell.swift
//  LatestDatabase
//
//  Created by Mac User5 on 8/30/17.
//  Copyright © 2017 Mac04. All rights reserved.
//

import UIKit

class customecell: UITableViewCell {

    
    @IBOutlet var lblID: UILabel!
    @IBOutlet var lblName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
