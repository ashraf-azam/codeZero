//
//  StringBoolTransformer.swift
//  CodeZeroTest
//
//  Created by HISB-Ashraf on 28/03/2021.
//

import Foundation
import CodableExtensions

class StringBoolTransformer: CodingContainerTransformer {
    static let shared = StringBoolTransformer()
    typealias Input = String
    typealias Output = Bool
    func transform(_ decoded: Input) throws -> Output {
        if decoded.lowercased() == "true" {
            return true
        } else {
            return false
        }
    }
    func transform(_ encoded: Output) throws -> Input {
        return encoded ? "true" : "false"
    }
}
