//
//  tvMazeSearchCTableViewCell.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/26/21.
//

import UIKit

class TvMazeSearchCTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFavorite: UIImageView!
    @IBOutlet weak var imgShow: UIImageView!
    @IBOutlet weak var labelNameShow: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attributes()
    }

    func attributes(){
        labelNameShow.sizeToFit()
        labelNameShow.numberOfLines = 0
        imgShow.layer.masksToBounds = true
        imgShow.layer.cornerRadius = 5.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
