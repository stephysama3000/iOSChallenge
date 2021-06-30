//
//  APICaller.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/26/21.
//

import Foundation
import Alamofire

class ApiCaller{
    
    /// Function for obtaining all the tv shows per pagination
    /// - Parameters:
    ///   - page: page number
    func fetchTVShowsPag(page: Int, completion: @escaping ((Error?, [Shows]?) -> Void)){
        
        var endpoint = (Endpoint.getShows.rawValue).replacingOccurrences(of: "@a", with: String(page))
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    do {
                        let data = try JSONDecoder().decode([Shows].self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                        completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Function for searching tv shows according to the show´s name typed by the user
    /// - Parameters:
    ///   - name: shows's name
    func searchTVShows(name: String, completion: @escaping ((Error?, [Show]?) -> Void)){
        var endpoint = (Endpoint.searchShows.rawValue).replacingOccurrences(of: "@a", with: name)
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    
                    do {
                        let data = try JSONDecoder().decode([Show].self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                     completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    /// Function for obtaining all the seasons of one show
    /// - Parameters:
    ///   - idShow: tv show's identification
    func fetchTVShowsSeasons(idShow: Int, completion: @escaping ((Error?, [Seasons]?) -> Void)){
        var endpoint = (Endpoint.getSeasons.rawValue).replacingOccurrences(of: "@a", with: String(idShow))
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    do {
                        let data = try JSONDecoder().decode([Seasons].self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                        completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    /// Function for obatining all the episodes of  a certain show
    /// - Parameters:
    ///   - idShow: tv show's identification
    func fetchTVShowsEpisodes(idShow: Int, completion: @escaping ((Error?, [Episodes]?) -> Void)){
        var endpoint = (Endpoint.getEpisodes.rawValue).replacingOccurrences(of: "@a", with: String(idShow))
        let request = AF.request(endpoint).responseJSON{(response) in
            switch response.result{
            case .success:
                if(response.result != nil){
                    let jsonData = response.data
                    do {
                        let data = try JSONDecoder().decode([Episodes].self, from: jsonData!)
                        completion(nil, data)
                    } catch {
                        completion(error, nil)
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}
