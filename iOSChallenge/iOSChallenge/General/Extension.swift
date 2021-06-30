//
//  Extension.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/28/21.
//

import Foundation
import UIKit

var spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .white)

//Extension for creating an activity indicator on ViewController
extension UIViewController{
    
    func activityIndicatorBegin() {
        
        //let transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        spinner.frame = CGRect(x: self.view.layer.position.x + (self.view.frame.width / 2) ,y: self.view.layer.position.y + (self.view.frame.height / 2), width: 90, height: 90)
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.startAnimating()

    }
    func activityIndicatorEnd() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
}

//Extension for creating an activity indicator on images
extension UIImageView{
    
    func activityIndicatorBegin() {
        
        spinner.frame = CGRect(x: 0,y: 0, width: 90, height: 90)
        spinner.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        spinner.hidesWhenStopped = true
        self.addSubview(spinner)
        spinner.startAnimating()

    }
    func activityIndicatorEnd() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
}

//Extension from converting string that have html format to an NSAttributed String
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let colorAtt = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
            
            let summaryAtt = NSAttributedString(string: data.base64EncodedString(), attributes: colorAtt)
            
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        
        return htmlToAttributedString?.string ?? ""
    }
}
