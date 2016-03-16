//
//  PositionTableViewCell.swift
//  ISS-Tracker
//
//  Created by Paul McGrath on 16/03/2016.
//  Copyright © 2016 Paul McGrath. All rights reserved.
//

import UIKit

class PositionTableViewCell: UITableViewCell {

    var position:Position? {
        didSet {
            if let position = position {
                
                self.textLabel?.text = "Lat: "+String(format:"%.3f",position.latitude)+", Long: "+String(format:"%.3f",position.longitude)
                //self.showPositionOnMap(position)
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
