//
//  pruebaViewController.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/26/21.
//

import UIKit

class pruebaViewController: UIViewController {

    var model = TvMazeSearchModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.all()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
