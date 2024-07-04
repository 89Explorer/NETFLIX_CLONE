//
//  Extensions.swift
//  NETFLIX_CLONE
//
//  Created by 권정근 on 7/4/24.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
