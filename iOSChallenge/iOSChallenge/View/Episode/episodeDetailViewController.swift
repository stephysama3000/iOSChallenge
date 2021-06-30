//
//  episodeDetailViewController.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/29/21.
//

import UIKit

class episodeDetailViewController: UIViewController {

    @IBOutlet weak var summaryEpisode: UITextView!
    @IBOutlet weak var viewEpisode: UIView!
    @IBOutlet weak var numberEpisode: UILabel!
    @IBOutlet weak var nameEpisode: UILabel!
    @IBOutlet weak var imgEpisode: UIImageView!
    
    var image : String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        if(image != ""){
            setImage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewEpisode.layer.cornerRadius = 10
    }

    func setImage(){
        imgEpisode.activityIndicatorBegin()
        let urlImage = URL(string: image)
        General.downloadImage(from: urlImage!) { [self] image in
            imgEpisode.image = image
            imgEpisode.activityIndicatorEnd()
        }
    }
}
