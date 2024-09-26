//
//  FlagManager.swift
//  ArkitDoushiQi
//
//  Created by Louis DUFOUR on 12/06/2024.
//

import SwiftUI

func flag(country: String) -> String {
    let base = 127397
    var usv = String.UnicodeScalarView()
    for i in country.utf16 {
        usv.append(UnicodeScalar(base + Int(i))!)
    }
    return String(usv)
}
