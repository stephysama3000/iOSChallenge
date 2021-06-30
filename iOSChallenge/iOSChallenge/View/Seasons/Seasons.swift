//
//  Seasons.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/28/21.
//

import Foundation

struct Seasons : Decodable{
    let id : Int?
    let number : Int?
}

struct Episodes : Decodable{
    let id : Int?
    let name : String?
    let season : Int?
    let number : Int?
    let image : Image?
    let summary : String?
}

struct Season_Episodes{
    let numberSeason : Int
    let episodesA : [EpisodesA]
    var collapsed : Bool
}

struct EpisodesA {
    let numberEpisode : Int?
    let nameEpisode : String?
    let summary : String?
    let image : Image?
}
