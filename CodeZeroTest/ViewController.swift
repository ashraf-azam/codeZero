//
//  ViewController.swift
//  CodeZeroTest
//
//  Created by HISB-Ashraf on 28/03/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    private let cardCollectionViewIdentifier: String = "CardCollectionViewCell"
    
    var cardBehaviourRelay = BehaviorRelay<[CardList]>(value: [])
    let usersRef = Database.database().reference(withPath: "cardList")
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollectionView .register(self.cardCollectionViewCellNib(), forCellWithReuseIdentifier: cardCollectionViewIdentifier)
        cardCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        callApi()
    }
    
    func callApi() {
        usersRef.observe(.value, with: { snapshot in
            var cardsArray: [CardList] = []
            
            for child in snapshot.children {
              if let snapshot = child as? DataSnapshot,
                let cardList = CardList(snapshot: snapshot) {
                cardsArray.append(cardList)
              }
            }
            self.cardBehaviourRelay.accept(cardsArray)
        })
        cardSubscribe()
    }
    
    func cardCollectionViewCell() -> UICollectionViewCell {
        return cardCollectionViewCellNib().instantiate(withOwner: nil, options: nil).first as! UICollectionViewCell
    }
    
    func cardCollectionViewCellNib() -> UINib {
        return UINib(nibName: cardCollectionViewIdentifier, bundle: Bundle.main)
    }
    
    func cardSubscribe() {
        let cardCollectionBinding = cardBehaviourRelay
            .bind(to: cardCollectionView.rx.items(cellIdentifier: cardCollectionViewIdentifier)) {
                _, card, cell in
                if let cardCell = cell as? CardCollectionViewCell {
                    cardCell.setupCell(name: card.cardName, cardImage: card.cardImage, profileImage: card.cardProfileImage, occupation: card.cardOccupation, dateTime: card.cardDateTime, cardDesc: card.cardDescription, cardColour: card.cardColour, starCount: card.cardStarCount, levelCount: card.cardLevelCount, eyeCount: card.cardEyeCount)
                }
        }
        disposeBag.insert(cardCollectionBinding)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth = CGFloat()
        var cellHeight = CGFloat()
        
        cellWidth = (UIScreen.main.bounds.width - 30) / 2
        cellHeight = 500
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
