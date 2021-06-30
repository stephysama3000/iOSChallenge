//
//  tvMazeSearchModel.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/26/21.
//

import Foundation



class TvMazeSearchModel{
    
    private lazy var API = ApiCaller()
    ///Array where all the shows information will be stored
    var info : [(show: Shows, isFavorite : Bool)] = []
    ///Array where all the shows information, according to the search, will be stored
    var search : [(show: Show, isFavorite : Bool)] = []
    
    /// Function for obtaining all the shows specifing the page
    /// - Parameter page: It will start with number 0 and will be increasing it´s value acording to pagination
    func all(page: Int){
        let shows = API.fetchTVShowsPag(page: page){ [self] (error, show) in
            guard let show = show, show.count > 0 else{
                return
            }
            for infoShow in show{
                info.append((show: infoShow , isFavorite: false))
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        }
        
    }
    
    /// Function for searching shows according to the name
    /// - Parameter name: name of the shows that will be typed by the user
    func search(name : String){
        let searchShows = API.searchTVShows(name: name){ [self] (error, show) in
            guard let show = show, show.count > 0 else{
                search.removeAll()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchNotification"), object: nil)
                return
            }
            search.removeAll()
            for searchShow in show{
                search.append((show: searchShow , isFavorite: false))
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchNotification"), object: nil)
        }
    }
}
