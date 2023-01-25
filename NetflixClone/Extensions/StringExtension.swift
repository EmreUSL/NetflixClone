//
//  StringExtension.swift
//  NetflixClone
//
//  Created by emre usul on 25.01.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
