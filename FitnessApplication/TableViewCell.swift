//
//  TableViewCell.swift
//  FitnessApplication
//
//  Created by Doğa Bayram on 12.11.2018.
//  Copyright © 2018 Doğa Bayram. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseRepOutlet: UILabel!
    @IBOutlet weak var exerciseWeightOutlet: UILabel!
    @IBOutlet weak var exerciseSetsOutlet: UILabel!
    
    @IBOutlet weak var exerciseImage: UIImageView!
    
    
    
    @IBOutlet weak var exerciseRep: UILabel!
    @IBOutlet weak var exerciseWeight: UILabel!
    @IBOutlet weak var exerciseSets: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
