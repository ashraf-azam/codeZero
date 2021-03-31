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
    
    var cardBehaviourRelay2 = BehaviorRelay<[CardList]>(value: [])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollectionView .register(self.cardCollectionViewCellNib(), forCellWithReuseIdentifier: cardCollectionViewIdentifier)
        cardCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        getData(url: "https://dev.codezero.app/api/v2/posts")
    }
    
    func getData(url: String) {
        let session = URLSession.shared
        let urlString = NSURL(string: url)!
        let request = NSMutableURLRequest(url: urlString as URL)
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjI2MGU2NTRiZmJkNDc4MjE4ZDM2YzczYjNmNGViMzM4MzQ3YjQ5OWFkMTcxOGQxMjNiN2VmNWY4MThlNTg1MDQxY2JkYTVjZmYwMzRjYjNhIn0.eyJhdWQiOiIyIiwianRpIjoiMjYwZTY1NGJmYmQ0NzgyMThkMzZjNzNiM2Y0ZWIzMzgzNDdiNDk5YWQxNzE4ZDEyM2I3ZWY1ZjgxOGU1ODUwNDFjYmRhNWNmZjAzNGNiM2EiLCJpYXQiOjE2MTM0NTE5NjgsIm5iZiI6MTYxMzQ1MTk2OCwiZXhwIjoxNjQ0OTg3OTY4LCJzdWIiOiI5OSIsInNjb3BlcyI6WyIqIl19.ZgV1FETxKbdkEWibBmhDf9JtRiA5y5gXMD8LmDG6bNhsT38SlWl1RjtKb4RRHmfpdViZ1JqAkqQVvUhXgrXabjeVIWOo81haolpwnNpbOiEXxOKusW9nfKJdEvEyyLHJnNW2fhYPF4Y2prQL2QHsPg4O-YlK8nn7hJesVsQ3M4M2KQv-4nLfv4QhPBt6_M4nNRIGklIAouUvb5GFnrVmGHjvoVyxIgSUYqbFePtYyP3d3rRuCWh_Vn9WBIURKTPJBnC2vQkQmQ5ULswCm0IZApGaQ6kKR6SgK2XWA54RYZcHDZw9UDqO6n8AwE4EZhZPUaHqe4wfPR2BOzcYB3uufbhQz-_VmDyIXStVKvlbYUNkfPFUOEKooiipwOuArbEx479uVQ__1rdM-BE9qEynw1fACDXgXoLX8qSQwgwXNnmHwjDP_AmaLsrk3F4RAB7lgBsm8ajBTsMMCXctXulJ6USYj_jGfe9xyQcj-LNhcRSWgCsN-0goGHHUkmjVT5JBAnJwOSViatDYNFLQcOCpmBSRzvFTIi8t7RnIbtqI21AOvU_RZ2AtMHQTT5Kkk6O7KqyhXV2sLvpFeP8RR5y26fWFrZZNhLI5_yJGleSk83XwXjM-LUIH5J-w6CFDeqgFaJ3Op6MBfJZRqpoVEc9MqcmwAHC720iLze_1X2TChgI"

        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Invalid URL")
                return
            }
            var result: ResponseData?
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                print(json)
                result = try JSONDecoder().decode(ResponseData.self, from: data)
                self.cardBehaviourRelay2.accept(result?.response_data ?? [])
                
            }catch{
                print("Could not serialize")
            }
        }).resume()
        self.cardSubscribe()
    }
    
    func cardCollectionViewCell() -> UICollectionViewCell {
        return cardCollectionViewCellNib().instantiate(withOwner: nil, options: nil).first as! UICollectionViewCell
    }
    
    func cardCollectionViewCellNib() -> UINib {
        return UINib(nibName: cardCollectionViewIdentifier, bundle: Bundle.main)
    }
    
    func cardSubscribe() {
        let cardCollectionBinding = cardBehaviourRelay2
            .bind(to: cardCollectionView.rx.items(cellIdentifier: cardCollectionViewIdentifier)) {
                _, card, cell in
                if let cardCell = cell as? CardCollectionViewCell {
                    cardCell.setupCell(name: card.name, cardImage: card.background_url, profileImage: card.co_icon ?? "", occupation: card.description, dateTime: card.timestamp, cardDesc: card.body, cardColour: .brown, starCount: card.view_count.string, levelCount: card.like_count.string, eyeCount: card.share_count.string)
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
