//
//  Functions.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/28/21.
//

import Foundation
import UIKit


class General{
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    static func downloadImage(from url: URL, _ completion: @escaping (UIImage?) -> Void){
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                let img = UIImage(data: data)
                completion(img)
            }
        }
    }
}

