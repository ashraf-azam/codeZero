//
//  AppConstant.swift
//  CodeZeroTest
//
//  Created by HISB-Ashraf on 28/03/2021.
//

import Foundation
import UIKit
import SwifterSwift

struct APPApi {
    struct Enum {}
    struct Colors {}
}

extension APPApi.Enum {
    enum EnumCardColour: String, Encodable {
        case cyan = "cyan"
        case yellow = "yellow"
        case brown = "brown"
        case green = "green"
        case pink = "pink"
        case orange = "orange"
    }
    
}

extension APPApi.Colors {
    static let green: UIColor = UIColor(hexString: "a0d6b4")!
    static let blue: UIColor = #colorLiteral(red: 0.6980392157, green: 0.8431372549, blue: 0.9568627451, alpha: 1) // #B2D7F4
    static let yellow: UIColor = UIColor(hexString: "#FCC009")!
    static let pink: UIColor = UIColor(hexString: "bd649e")!
    static let brown: UIColor = UIColor(hexString: "b8975a")!
    static let orange: UIColor = #colorLiteral(red: 1, green: 0.4784313725, blue: 0.09019607843, alpha: 1) // #FF7A17
}
