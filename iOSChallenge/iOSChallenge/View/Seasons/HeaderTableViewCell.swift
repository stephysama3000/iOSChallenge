//
//  HeaderTableViewCell.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/28/21.
//

import UIKit

protocol HeaderTableViewCellDelegate {
    func toggleSection(_ header: HeaderTableViewCell, section: Int)
}

class HeaderTableViewCell: UITableViewHeaderFooterView {

    var delegate: HeaderTableViewCellDelegate?
    var section: Int = 0
    let lblTitle = UILabel()
    let lblArrow = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        labelEpisode()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HeaderTableViewCell.tapHeader(_:))))
    }
    
    func labelEpisode(){
        let marginGuide = contentView.layoutMarginsGuide
        contentView.backgroundColor = UIColor.white
        
        contentView.addSubview(lblArrow)
        lblArrow.textColor = UIColor.black
        lblArrow.translatesAutoresizingMaskIntoConstraints = false
        lblArrow.widthAnchor.constraint(equalToConstant: 12).isActive = true
        lblArrow.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        lblArrow.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        lblArrow.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
        contentView.addSubview(lblTitle)
        lblTitle.textColor = UIColor.black
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        lblTitle.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? HeaderTableViewCell else {
            return
        }
        
        delegate?.toggleSection(self, section: cell.section)
    }
}
