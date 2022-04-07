//
//  ForecastCell.swift
//  port
//
//  Created by Андрей Orlov on 3/28/22.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    
    
   
    @IBOutlet weak var DateLabel: UILabel!
    
    
    @IBOutlet weak var nightDayLabel: UILabel!
    
    @IBOutlet weak var DayTempLabel: UIStackView!
    
    
    @IBOutlet weak var WindLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
