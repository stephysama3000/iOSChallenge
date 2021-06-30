//
//  shows.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/26/21.
//

import Foundation

struct Show : Decodable{
    let show : Shows?
}

struct Shows : Decodable {
    let id : Int?
    let name : String?
    let genres : [String?]
    let schedule : Schedule?
    let image : Image?
    let summary : String?
    
}

struct Image : Decodable{
    let medium : String?
    let original : String?
}

struct Schedule : Decodable{
    let time : String?
    let days : [String?]
}

