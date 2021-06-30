//
//  configUrl.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/26/21.
//

import Foundation

public enum Endpoint: String {
    case getShows = "https://api.tvmaze.com/shows?page=@a"
    case searchShows = "https://api.tvmaze.com/search/shows?q=@a"
    case getEpisodes = "https://api.tvmaze.com/shows/@a/episodes"
    case searchPeople = "https://api.tvmaze.com/search/people?q=@a"
    case getInfoEpisodes = "https://api.tvmaze.com/episodes/@a"
    case getSeasons = "https://api.tvmaze.com/shows/@a/seasons"
}
