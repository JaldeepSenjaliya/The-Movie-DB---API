//
//  MovieSearchTableViewCell.swift
//  CodingChallangeLows
//
//  Created by Divyeshkumar Patel on 2022-01-07.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {
    
   
    @IBOutlet var movieName: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
