//
//  TvMazeDetailViewController.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/27/21.
//

import UIKit

class TvMazeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var noEpisodes: UIView!
    @IBOutlet weak var expandableSeasonTable: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var stackViewInfo: UIStackView!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var titleShow: UILabel!
    @IBOutlet weak var imgShow: UIImageView!
    
    ///String variable for url image
    var image : String = ""
    var modelSeasons = TvMazeSeasonsModel()
    ///Int variable for the id of the show, so we can obtain more information of it
    var idShow : Int = 0
    ///Int variable for number of seasons of an specific show
    var numSeasons = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if(image != ""){
            //Only if the image is not empty i will set it.
            setImage()
        }
        self.activityIndicatorBegin()
        //Get all the seasons with their episodes
        modelSeasons.allSeasons(idShow: idShow)
        modelSeasons.allEpisodes(idShow: idShow)
        
        expandableSeasonTable.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackScroll()
        actions()
    }
    
    /// Differents actions of components, for example notifications or tableview
    func actions(){
        self.expandableSeasonTable.delegate = self
        self.expandableSeasonTable.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(shouldReload),name:NSNotification.Name(rawValue: "seasonsDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shouldReloadEpisodes),name:NSNotification.Name(rawValue: "episodesDone"), object: nil)
        expandableSeasonTable.register(HeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: "HeaderTableViewCell")
    }
    
    @objc func shouldReload(){
        numSeasons = modelSeasons.seasons.count
        var sections = modelSeasons.sectionsData
        if(sections.count == 0){
            self.activityIndicatorEnd()
        }
    }
    
    
    /// Function for obtaining the number of seasons and episodes, once i´ve obtained the response from the API. Then i´ll reload the tableView
    @objc func shouldReloadEpisodes() {
      numSeasons = modelSeasons.seasons.count
      var sections = modelSeasons.sectionsData
      self.expandableSeasonTable.reloadData()
    }
    
    /// Function for obtaining the UIImage from the url
    func setImage(){
        imgShow.activityIndicatorBegin()
        let urlImage = URL(string: image)
        General.downloadImage(from: urlImage!) { [self] image in
            imgShow.image = image
            imgShow.activityIndicatorEnd()
        }
    }
    
    /// Function for adding the stackview to the scrollView
    func stackScroll(){
        self.scrollView.addSubview(stackViewInfo)
        self.stackViewInfo.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewInfo.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackViewInfo.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackViewInfo.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackViewInfo.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackViewInfo.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numSeasons
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(modelSeasons.sectionsData.count > 0){
            return modelSeasons.sectionsData[section].collapsed ? 0 : modelSeasons.sectionsData[section].episodesA.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ContentTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as? ContentTableViewCell)!
        if(modelSeasons.sectionsData.count > 0){
            let episode : EpisodesA = modelSeasons.sectionsData[indexPath.section].episodesA[indexPath.row]
            cell.lblEpisodes.text = "Episode " + String(episode.numberEpisode!)
            
        }else{
            cell.lblEpisodes.text = "No episodes"
        }
        self.activityIndicatorEnd()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell
        if(modelSeasons.sectionsData.count > 0){
            customFooterView?.lblTitle.text = "Season " + String(modelSeasons.sectionsData[section].numberSeason)
            customFooterView?.lblArrow.text = ">"
            customFooterView?.delegate = self
            customFooterView?.section = section
        }else{
            customFooterView?.lblTitle.text = "No Episodes"
        }
        
            return customFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var seasonEpisode = ""
        var nameEpisode = modelSeasons.sectionsData[indexPath.section].episodesA[indexPath.row].nameEpisode
        var imgString = modelSeasons.sectionsData[indexPath.section].episodesA[indexPath.row].image?.medium
        var numberEpisode = modelSeasons.sectionsData[indexPath.section].episodesA[indexPath.row].numberEpisode
        var season = indexPath.section + 1
        var summaryEpisode = modelSeasons.sectionsData[indexPath.section].episodesA[indexPath.row].summary
        
        if let viewController = storyboard?.instantiateViewController(identifier: "episodeDetailViewController") as? episodeDetailViewController {
            
            _ = viewController.view
            
            if(imgString != nil){
                viewController.image = imgString!
            }else{
                viewController.imgEpisode.image = UIImage(named: "default")
            }
            
            if (nameEpisode == nil){
                nameEpisode = "No name available"
            }
            viewController.nameEpisode.text = nameEpisode
            viewController.numberEpisode.text = "Season " + String(season) + " - Episode " + String(numberEpisode!)
            viewController.summaryEpisode.attributedText = summaryEpisode?.htmlToAttributedString
            viewController.summaryEpisode.font = UIFont.systemFont(ofSize: 17.0)
            viewController.summaryEpisode.textColor = UIColor.black
            self.present(viewController, animated:true, completion:nil)
            
        }
        
    }
}

extension TvMazeDetailViewController: HeaderTableViewCellDelegate {
    
    func toggleSection(_ header: HeaderTableViewCell, section: Int) {
        let collapsed = !modelSeasons.sectionsData[section].collapsed
        modelSeasons.sectionsData[section].collapsed = collapsed
        expandableSeasonTable.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}

