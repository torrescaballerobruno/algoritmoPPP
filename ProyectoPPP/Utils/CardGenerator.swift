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

        charSet = ["A","E","I","O","U","a","e","i","o","u"]
        let charSetSize = charSet.count
        var card : [Character] = []
        var cardSection:String = ""
        
        let simkey = SymmetricKey(size: .bits256)
        
        var alphabetString: String = ""
        alphabetString = charSet.joined(separator: " , ")

        var counter : UInt128 = 0
    
        for _ in 0...127{
            let dataCounter = Data(bytes: &counter ,count: MemoryLayout.size(ofValue:counter))
            let counterAes = try! AES.GCM.seal(dataCounter, using: simkey).combined!
            let intValueAes = counterAes.withUnsafeBytes { $0.load(as: UInt32.self) }
            let res =  divStep(aesInt: Int(intValueAes), setSize: charSetSize)
            let char = mapping(res: res, set: charSet)
            card.append(char)
            counter = counter + 1
        }
        for i in 0...127{
            cardSection.append(card[i])
        }
        return cardSection.split(by: 4)
    }
    
    func divStep(aesInt: Int, setSize: Int) -> Int {
        let module = aesInt % setSize
        return module
    }

    func mapping(res: Int, set: [String]) -> Character{
        
        let mappedChar = Character(set[res])
        return mappedChar
        
    }
}

extension String {
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
}
