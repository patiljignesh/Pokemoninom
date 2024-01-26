//
//  Utils.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/26.
//

import Foundation

func getDeviceID() -> String {
    if let retrievedID = UserDefaults.standard.string(forKey: "deviceID") {
        return retrievedID
    } else {
        let newID = UUID().uuidString
        UserDefaults.standard.set(newID, forKey: "deviceID")
        return newID
    }
}
