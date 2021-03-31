//
//  CardModel.swift
//  CodeZeroTest
//
//  Created by HISB-Ashraf on 28/03/2021.
//

import Foundation
import Firebase

struct ResponseData: Decodable {
    var response_data: [CardList]
    
    enum CodingKeys:String,CodingKey{
        case response_data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response_data = try container.decode([CardList].self, forKey: .response_data)
    }
}

struct CardList: Codable {
    var id: Int64
    var card_id: Int64
    var user_id: Int64
    var timestamp: String = ""
    var type: String = ""
    var name: String = ""
    var icon: String = ""
    var description: String = ""
    var color: Color
    var email: String?
    var background_url: String = ""
    var background_type: Int
    var background_width: Int?
    var background_height: Int?
    var co_name: String?
    var co_icon: String?
    var liked: Bool
    var viewed: Bool
    var shared: Bool
    var like_count: Int
    var view_count: Int
    var share_count: Int
    var body: String = ""
    var branch_address: String?
    var branch_contact: String?
    var updated_at: UpdatedAt

    enum CodingKeys:String,CodingKey{
        case id = "id"
        case card_id = "card_id"
        case user_id = "user_id"
        case timestamp = "timestamp"
        case type = "type"
        case name = "name"
        case icon = "icon"
        case description = "description"
        case color = "color"
        case email = "email"
        case background_url = "background_url"
        case background_type = "background_type"
        case background_width = "background_width"
        case background_height = "background_height"
        case co_name = "co_name"
        case co_icon = "co_icon"
        case liked = "liked"
        case viewed = "viewed"
        case shared = "shared"
        case like_count = "like_count"
        case view_count = "view_count"
        case share_count = "share_count"
        case body = "body"
        case branch_address = "branch_address"
        case branch_contact = "branch_contact"
        case updated_at = "updated_at"
    }
    
    init(name: String, image: String, profileImage: String, occupation: String, starCount: String, levelCount: String, eyeCount: String, coName: String, color: Color, updatedAt: UpdatedAt) {
        self.name = name
        self.co_icon = image
        self.icon = profileImage
        self.description = occupation
        self.id = 1
        self.card_id = 1
        self.user_id = 1
        self.timestamp = name
        self.type = name
        self.color = color
        self.email = name
        self.background_url = name
        self.background_type = 1
        self.background_width = 1
        self.background_height = 1
        self.co_name = coName
        self.liked = true
        self.viewed = true
        self.shared = true
        self.like_count = 1
        self.view_count = 2
        self.share_count = 3
        self.updated_at = updatedAt
    }
}

struct Color: Codable {
    var bar: Bar
    
    enum CodingKeys:String,CodingKey{
        case bar = "bar"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bar = try container.decode(Bar.self, forKey: .bar)
    }
}

struct Bar: Codable {
    var bottom: String = ""
    
    enum CodingKeys:String,CodingKey{
        case bottom = "bottom"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bottom = try container.decode(String.self, forKey: .bottom)
    }
}

struct UpdatedAt: Codable {
    var date: String = ""
    var timezone: String = ""
    var timezone_type: Int
    
    enum CodingKeys:String,CodingKey{
        case date =  "date"
        case timezone = "timezone"
        case timezone_type = "timezone_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.timezone_type = try container.decode(Int.self, forKey: .timezone_type)
    }
}
