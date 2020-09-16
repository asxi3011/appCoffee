//
//  DONGTableViewCell.swift
//  appCoffe
//
//  Created by Say Dau on 7/23/20.
//  Copyright © 2020 Say Dau. All rights reserved.
//

import UIKit

class DONGTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHinh: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
