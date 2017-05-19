//
//  ArtistsTableViewCell.swift
//  FirebaseDemo
//
//  Created by mineachem on 5/8/17.
//  Copyright © 2017 mineachem. All rights reserved.
//

import UIKit

class ArtistsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
