//
//  TvMazeSeasonsModel.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/28/21.
//

import Foundation

class TvMazeSeasonsModel{
    
    private lazy var API = ApiCaller()
    var seasons : [(Seasons)] = []
    var episodes : [(Episodes)] = []
    var sectionsData : [Season_Episodes] = []
    
    /// Function for storing all the data from the seasons
    /// - Parameter idShow: tv show's identification
    func allSeasons(idShow: Int){
        let shows = API.fetchTVShowsSeasons(idShow: idShow){ [self] (error, season) in
            guard let season = season, season.count > 0 else{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "seasonsDone"), object: nil)
                return
            }
        
            for infoSeason in season{
                seasons.append(infoSeason)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "seasonsDone"), object: nil)

        }
    }
    
    /// Function for storing all the data from the episodes
    /// - Parameter idShow: tv show's identification
    func allEpisodes(idShow : Int){
        let shows = API.fetchTVShowsEpisodes(idShow: idShow){ [self] (error, episode) in
            guard let episode = episode, episode.count > 0 else{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "episodesDone"), object: nil)
                return
            }
            
            for infoEpisode in episode{
                episodes.append(infoEpisode)
            }
            
            for i in 0..<seasons.count{
                var EpPerSeason : [EpisodesA] = []
                for j in 0..<episode.count{
                    if(seasons[i].number == episode[j].season){
                        EpPerSeason.append(EpisodesA(numberEpisode: episode[j].number, nameEpisode: episode[j].name, summary: episode[j].summary, image: Image(medium: episode[j].image?.medium, original: episode[j].image?.original)))
                        }
                    
                    }
                sectionsData.append(Season_Episodes(numberSeason: seasons[i].number!, episodesA: EpPerSeason, collapsed: true))
                }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "episodesDone"), object: nil)
            
            }
    }
}
    

