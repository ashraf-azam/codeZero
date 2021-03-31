//
//  CardCollectionView.swift
//  CodeZeroTest
//
//  Created by HISB-Ashraf on 28/03/2021.
//

import Foundation
import UIKit
import Kingfisher
import SwiftDate

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var wholeBackgroundView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleImageContainerView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var bigImageView: UIImageView!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descImageContainerView: UIView!
    @IBOutlet weak var descImageView: UIImageView!
    @IBOutlet weak var descNameLabel: UILabel!
    @IBOutlet weak var descOccupationLabel: UILabel!
    @IBOutlet weak var descDateLabel: UILabel!
    @IBOutlet weak var descDescriptionLabel: UILabel!
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var starLabelCount: UILabel!
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var levelLabelCount: UILabel!
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var eyeLabelCount: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        titleImageView.layer.cornerRadius = titleImageView.width/2
        descImageView.layer.cornerRadius = descImageView.width/2
    }
    
    func setupCell(name: String, cardImage: String, profileImage: String, occupation: String, dateTime: String, cardDesc: String, cardColour: APPApi.Enum.EnumCardColour, starCount: String, levelCount: String, eyeCount: String) {
        switch cardColour {
        case .cyan:
            self.wholeBackgroundView.backgroundColor = APPApi.Colors.blue
        case .brown:
            self.wholeBackgroundView.backgroundColor = APPApi.Colors.brown
        case .green:
            self.wholeBackgroundView.backgroundColor = APPApi.Colors.green
        case .yellow:
            self.wholeBackgroundView.backgroundColor = APPApi.Colors.yellow
        case .pink:
            self.wholeBackgroundView.backgroundColor = APPApi.Colors.pink
        case .orange:
            self.wholeBackgroundView.backgroundColor = APPApi.Colors.orange
        }
        self.titleNameLabel.text = name
        self.descNameLabel.text = name
        let profileImg = URL(string: profileImage)
        let cardImg = URL(string: cardImage)
        let placeholder = UIImage(named: "placeholder_01")! as UIImage
        self.titleImageView.kf.setImage(with: profileImg, placeholder: placeholder, options: nil, progressBlock: nil) { (_) in
        }
        self.descImageView.kf.setImage(with: profileImg, placeholder: placeholder, options: nil, progressBlock: nil) { (_) in
        }
        self.bigImageView.kf.setImage(with: cardImg, placeholder: placeholder, options: nil, progressBlock: nil) { (_) in
        }
        self.descOccupationLabel.text = occupation
        self.descDescriptionLabel.text = cardDesc
        self.starLabelCount.text = starCount
        self.levelLabelCount.text = levelCount
        self.eyeLabelCount.text = eyeCount
        
        let timeStamp = Double(dateTime) ?? 0
        self.getDateFromTimeStamp(timeStamp: timeStamp)
    }
    
    func getDateFromTimeStamp(timeStamp : Double) -> String {
        let date = NSDate(timeIntervalSince1970: timeStamp)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MMM YYYY"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        self.descDateLabel.text = dateString
        return dateString
    }
}
