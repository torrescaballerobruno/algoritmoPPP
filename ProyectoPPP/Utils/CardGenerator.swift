//
//  CardGenerator.swift
//  ProyectoPPP
//
//  Created by Bruno Torres on 07/02/20.
//  Copyright © 2020 Bruno Torres. All rights reserved.
//

import Foundation
import CryptoKit

class CardGenerator{

    var charSet:[String]!

    func createCards(key : String) -> [String] {

        charSet = ["A","E","I","O","U","a","e","i","o","u","1","2","3","4"]
        let charSetSize = charSet.count
        var card : [Character] = []
        var cardSection:String = ""
        let simkey = SymmetricKey(size: .bits256)
        var counter : UInt128 = 0

        for _ in 0...127{
            let dataCounter = Data(bytes: &counter ,count: MemoryLayout.size(ofValue:counter))
            let counterAes = try! AES.GCM.seal(dataCounter, using: simkey).combined!
            let intValueAes = counterAes.withUnsafeBytes { $0.load(as: UInt32.self) }
            let res =  module(aesInt: Int(intValueAes), setSize: charSetSize)
            card.append(mapper(res: res, set: charSet))
            counter = counter + 1
        }
        for i in 0...127{
            cardSection.append(card[i])
        }
        return split(cardSection, by: 4)
    }

    func module(aesInt: Int, setSize: Int) -> Int {
        return aesInt % setSize
    }

    func mapper(res: Int, set: [String]) -> Character{
        return Character(set[res])
    }

    func split(_ text: String ,by length: Int) -> [String] {
        var startIndex = text.startIndex
        var results = [Substring]()
        while startIndex < text.endIndex {
            let endIndex = text.index(startIndex, offsetBy: length, limitedBy: text.endIndex) ?? text.endIndex
            results.append(text[startIndex..<endIndex])
            startIndex = endIndex
        }
        return results.map { String($0) }
    }
}
