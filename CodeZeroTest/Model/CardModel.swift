//
//  CardModel.swift
//  CodeZeroTest
//
//  Created by HISB-Ashraf on 28/03/2021.
//

import Foundation
import Firebase

struct CardList: Codable {
    var cardName: String = ""
    var cardImage: String = ""
    var cardProfileImage: String = ""
    var cardOccupation: String = ""
    var cardDateTime: String = ""
    var cardDescription: String = ""
    var cardStarCount: String = ""
    var cardLevelCount: String = ""
    var cardEyeCount: String = ""
    var cardColour: APPApi.Enum.EnumCardColour = .cyan

    enum CodingKeys:String,CodingKey{
        case cardName = "cardName"
        case cardImage = "cardImage"
        case cardProfileImage = "cardProfileImage"
        case cardOccupation = "cardOccupation"
        case cardDateTime = "voucherprice"
        case cardDescription = "cardDescription"
        case cardStarCount = "cardStarCount"
        case cardLevelCount = "cardLevelCount"
        case cardEyeCount = "cardEyeCount"
        case cardColour
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cardName = try container.decode(String.self, forKey: .cardName)
        self.cardImage = try container.decode(String.self, forKey: .cardImage)
        self.cardProfileImage = try container.decode(String.self, forKey: .cardProfileImage)
        self.cardOccupation = try container.decode(String.self, forKey: .cardOccupation)
        self.cardDateTime = try container.decode(String.self, forKey: .cardDateTime)
        self.cardDescription = try container.decode(String.self, forKey: .cardDescription)
        self.cardStarCount = try container.decode(String.self, forKey: .cardStarCount)
        self.cardLevelCount = try container.decode(String.self, forKey: .cardLevelCount)
        self.cardEyeCount = try container.decode(String.self, forKey: .cardEyeCount)
        if let tempColour = try container.decodeIfPresent(String.self, forKey: .cardColour).map({ (string) -> APPApi.Enum.EnumCardColour in
                return APPApi.Enum.EnumCardColour(rawValue: string.lowercased()) ??  APPApi.Enum.EnumCardColour.cyan}) {
            cardColour = tempColour
        }
    }
    
    init(name: String, image: String, profileImage: String, occupation: String, dateTime: String, desc: String, starCount: String, levelCount: String, eyeCount: String, colour: APPApi.Enum.EnumCardColour) {
        self.cardName = name
        self.cardImage = image
        self.cardProfileImage = profileImage
        self.cardOccupation = occupation
        self.cardDateTime = dateTime
        self.cardDescription = desc
        self.cardStarCount = starCount
        self.cardLevelCount = levelCount
        self.cardEyeCount = eyeCount
        self.cardColour = colour
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let cardName = value["cardName"] as? String,
            let cardImage = value["cardImage"] as? String,
            let cardProfileImage = value["cardProfileImage"] as? String,
            let cardOccupation = value["cardOccupation"] as? String,
            let cardDateTime = value["cardDateTime"] as? String,
            let cardDescription = value["cardDescription"] as? String,
            let cardStarCount = value["cardStarCount"] as? String,
            let cardLevelCount = value["cardLevelCount"] as? String,
            let cardEyeCount = value["cardEyeCount"] as? String,
            let cardColour = value["cardColour"] as? String
        else {
            return nil
        }
        self.cardName = cardName
        self.cardImage = cardImage
        self.cardProfileImage = cardProfileImage
        self.cardOccupation = cardOccupation
        self.cardDateTime = cardDateTime
        self.cardDescription = cardDescription
        self.cardStarCount = cardStarCount
        self.cardLevelCount = cardLevelCount
        self.cardEyeCount = cardEyeCount
        self.cardColour = APPApi.Enum.EnumCardColour(rawValue: cardColour) ?? APPApi.Enum.EnumCardColour(rawValue: "")!
    }
}
