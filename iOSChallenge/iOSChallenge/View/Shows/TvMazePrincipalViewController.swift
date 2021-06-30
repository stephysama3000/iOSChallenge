//
//  tvMazePrincipalViewController.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/26/21.
//

import UIKit

class TvMazePrincipalViewController: UIViewController {
    
    @IBOutlet weak var leftItem: UIBarButtonItem!
    @IBOutlet weak var noSearch: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tablePrincipalShows: UITableView!
    
    let cellIdentifier = "cellTVShow"
    var favorites: [FavoriteShows] = []
    var modelMaze = TvMazeSearchModel()
    var apiCaller = ApiCaller()
    
    ///Int variable for pagination
    var page = 0
    ///Boolean variable for identify if we are searching
    var isSearching : Bool = false
    ///Boolean variable for identify if we are in the favorite shows view
    var isFavoriteView : Bool = false
    
    /**
        Action function for left bar item so we can switch from principal view controller
         to favorite view controller
    */
    @IBAction func leftItemAction(_ sender: Any) {
        if(isFavoriteView == false){
            noSearch.text = "No favorites added"
            isFavoriteView = true
            setImageInNavBar(image: "tv.fill")
            searchBar.isHidden = true
            self.navigationItem.title = "TV Maze Favorites"
            self.tablePrincipalShows.reloadData()
        }else{
            noSearch.text = "No match found"
            isFavoriteView = false
            searchBar.isHidden = false
            setImageInNavBar(image: "heart.fill")
            searchBar.placeholder = "Search Tv Shows"
            self.navigationItem.title = "TV Maze"
            self.tablePrincipalShows.reloadData()
        }
        
    }
    
    /**
        Function for setting the image in the left bar item from navigation bar
    */
    func setImageInNavBar(image : String){
        var image = UIImage(systemName: image)?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        leftItem.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modelMaze.all(page: page)
        actions()
        self.activityIndicatorBegin()
    }
    
    /**
        Function for diferents actions like notifications,
    */
    func actions(){
        NotificationCenter.default.addObserver(self, selector: #selector(shouldReload),name:NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shouldSearchReload),name:NSNotification.Name(rawValue: "searchNotification"), object: nil)
        searchBar.placeholder = "Search Tv Shows"
    }

    
}

extension TvMazePrincipalViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //It is necessary to know is we are in the favorite view or the principal, and also
        //if the search action is active
        if(isFavoriteView == false){
            if(isSearching == false){
                noSearch.isHidden = true
                return modelMaze.info.count
            }else{
                if modelMaze.search.count == 0{
                    tableView.isHidden = true
                    noSearch.isHidden = false
                }else{
                    tableView.isHidden = false
                    noSearch.isHidden = true
                }
                return modelMaze.search.count
            }
        }else{
            if(favorites.count == 0){
                noSearch.isHidden = false
            }else{
                noSearch.isHidden = true
            }
            return favorites.count
            
        }
        return 0
    }
    
    
    /// Function that allows to reload the table view when the search is over
    @objc func shouldReload() {
        isSearching = false
      self.tablePrincipalShows.reloadData()
    }
    
    /// Function that allows to reload the table view when the search begins
    @objc func shouldSearchReload() {
        isSearching = true
      self.tablePrincipalShows.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedShow = 0
        var title = ""
        var imgString = ""
        var summary = ""
        var genresArray : [String?] = []
        var genresText = ""
        var hourSchedule = ""
        var daysArraySche : [String?] = []
        var daysText = ""
        
        if(isFavoriteView == false){
            if(isSearching == false){
                var shows = modelMaze.info[indexPath.row].show
                
                selectedShow = shows.id!
                title = shows.name != "" ? shows.name! : "No title"
                imgString = (shows.image?.original)!
                summary = shows.summary != nil ? shows.summary! : "No summary avaliable"
                genresArray = shows.genres
                hourSchedule = shows.schedule!.time!
                daysArraySche = shows.schedule!.days
                
            }else{
                var shows = modelMaze.search[indexPath.row].show.show!
                selectedShow = shows.id!
                title = shows.name != "" ? shows.name! : "No title"
                imgString = (shows.image?.original) ?? ""
                summary = shows.summary != nil ? shows.summary! : "No summary avaliable"
                genresArray = shows.genres
                hourSchedule = shows.schedule!.time!
                daysArraySche = shows.schedule!.days
            }
        }else{
            var showsFav = favorites[indexPath.row]
            selectedShow = showsFav.id!
            title = showsFav.name != "" ? showsFav.name! : "No title"
            imgString = (showsFav.image?.original)!
            summary = showsFav.summary != nil ? showsFav.summary! : "No summary avaliable"
            genresArray = showsFav.genres
            hourSchedule = showsFav.schedule!.time!
            daysArraySche = showsFav.schedule!.days
        }
        
        //Initialize the detail view controller so the information is already loaded.
        if let viewController = storyboard?.instantiateViewController(identifier: "TvMazeDetailViewController") as? TvMazeDetailViewController {
            _ = viewController.view
            
            viewController.idShow = selectedShow
            if(imgString != nil && imgString != ""){
                viewController.image = imgString
            }else{
                viewController.imgShow.image = UIImage(named: "default")
            }
            
            viewController.titleShow.text = title
            viewController.summary.attributedText = summary.htmlToAttributedString
            viewController.summary.font = UIFont.systemFont(ofSize: 17.0)
            viewController.summary.textColor = UIColor.white
            
            if(genresArray.count == 0){
                genresText = "No genres available"
            }else{
                for genre in genresArray{
                    genresText = genresText + genre! + " | "
                }
                
            }
            viewController.genres.text = genresText
            
            
            if(hourSchedule == ""){
                viewController.hour.isHidden = true
            }else{
                viewController.hour.text = "Hour : " + hourSchedule
            }
            
            if(daysArraySche.count == 0){
                viewController.days.isHidden = true
            }else{
                for days in daysArraySche{
                    var comma = ","
                    if(daysArraySche.count == 1){
                        daysText = daysText + " " + days!
                    }else{
                        if(days == daysArraySche.last){
                            comma = ""
                        }
                        daysText = daysText + " " + days! + comma
                    }
                }
                viewController.days.text = "Days : " + daysText
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TvMazeSearchCTableViewCell
        
        if(isSearching == false){
            if(isFavoriteView == true){
                var shows = favorites[indexPath.row]
                cell.labelNameShow.text = shows.name
                var imgString = shows.image?.medium!
                cell.imgFavorite.image = UIImage(systemName: "heart.fill")
                cell.imgFavorite.tintColor = .white
                if(imgString != nil){
                    cell.imgShow.activityIndicatorBegin()
                    let urlImage = URL(string: imgString!)
                    General.downloadImage(from: urlImage!) { image in
                        cell.imgShow.image = image
                        cell.imgShow.activityIndicatorEnd()
                    }
                }else{
                    cell.imgShow.image = UIImage(named: "default")
                }
            }else{
                var shows = modelMaze.info[indexPath.row].show
                cell.labelNameShow.text = shows.name
                var imgString = shows.image?.medium!
                if(imgString != nil){
                    cell.imgShow.activityIndicatorBegin()
                    let urlImage = URL(string: imgString!)
                    General.downloadImage(from: urlImage!) { image in
                        cell.imgShow.image = image
                        cell.imgShow.activityIndicatorEnd()
                    }
                }else{
                    cell.imgShow.image = UIImage(named: "default")
                }
                
                if(favorites.contains(where: { $0.id ==  shows.id!}) == false){
                    cell.imgFavorite.image = UIImage(systemName: "heart")
                    cell.imgFavorite.tintColor = .white
                }else{
                    cell.imgFavorite.image = UIImage(systemName: "heart.fill")
                    cell.imgFavorite.tintColor = .white
                }
            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
            cell.imgFavorite.tag = indexPath.row
            cell.imgFavorite?.isUserInteractionEnabled = true
            cell.imgFavorite?.addGestureRecognizer(tapGestureRecognizer)
            
            if(tablePrincipalShows.contentOffset.y >= (tablePrincipalShows.contentSize.height - tablePrincipalShows.frame.size.height)) {
                page += 1
                activityIndicatorBegin()
                modelMaze.all(page: page)
            }
            activityIndicatorEnd()
            return cell
        }else{
            let shows = modelMaze.search[indexPath.row].show
            cell.labelNameShow.text = shows.show?.name
            //cell.imgShow.image = downloadImage(from: )
            let imgString = shows.show?.image?.medium!
            if(imgString != nil){
                activityIndicatorBegin()
                let urlImage = URL(string: imgString!)
                General.downloadImage(from: urlImage!) { image in
                    self.activityIndicatorEnd()
                    cell.imgShow.image = image
                }
            }else{
                cell.imgShow.image = UIImage(named: "default")
            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
            cell.imgFavorite.tag = indexPath.row
            cell.imgFavorite?.isUserInteractionEnabled = true
            cell.imgFavorite?.addGestureRecognizer(tapGestureRecognizer)
            
            return cell
        }
        
    }
    
    /// Gesture so when the heart image from tableView is tapped, it can change image and put/remove from favorite list
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let imgView = tapGestureRecognizer.view as! UIImageView
        imgView.image = UIImage(systemName: "heart.fill")
        imgView.tintColor = .white
        
        if(isSearching == false){
            if(isFavoriteView == true){
                var shows = favorites[imgView.tag]
                if(favorites.contains(where: { $0.id ==  shows.id!}) == false){
                    imgView.image = UIImage(systemName: "heart.fill")
                    imgView.tintColor = .white
                    favorites.append(FavoriteShows(id: shows.id!, name: shows.name!,genres: shows.genres, schedule: shows.schedule ,image: (shows.image)!, summary: shows.summary))
                }else{
                    imgView.image = UIImage(systemName: "heart")
                    imgView.tintColor = .white
                    var index = favorites.index(where: { $0.id ==  shows.id!})
                    favorites.remove(at: index!)
                }
            }else{
                var shows = modelMaze.info[imgView.tag]
                if(favorites.contains(where: { $0.id ==  shows.show.id!}) == false){
                    imgView.image = UIImage(systemName: "heart.fill")
                    imgView.tintColor = .white
                    favorites.append(FavoriteShows(id: shows.show.id!, name: shows.show.name!,genres: shows.show.genres, schedule: shows.show.schedule ,image: (shows.show.image)!, summary: shows.show.summary))
                }else{
                    imgView.image = UIImage(systemName: "heart")
                    imgView.tintColor = .white
                    var index = favorites.index(where: { $0.id ==  shows.show.id!})
                    favorites.remove(at: index!)
                }
            }
        }else{
            var shows = modelMaze.search[imgView.tag].show
            if(favorites.contains(where: { $0.id ==  shows.show?.id!}) == false){
                imgView.image = UIImage(systemName: "heart.fill")
                imgView.tintColor = .white
                favorites.append(FavoriteShows(id: shows.show?.id!, name: shows.show?.name!,genres: shows.show!.genres, schedule: shows.show?.schedule ,image: (shows.show?.image)!, summary: shows.show?.summary))
            }else{
                imgView.image = UIImage(systemName: "heart")
                imgView.tintColor = .white
                var index = favorites.index(where: { $0.id ==  shows.show?.id!})
                favorites.remove(at: index!)
            }
        }
        tablePrincipalShows.reloadData()
    }
}


extension TvMazePrincipalViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            modelMaze.search(name: searchText)
        }else{
            isSearching = false
          self.tablePrincipalShows.reloadData()
        }
    }
}

