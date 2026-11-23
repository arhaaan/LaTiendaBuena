//
//  String + Validations.swift
//  LaTiendaBuena
//
//  Created by Arhan on 06/09/26.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let regex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        return NSPredicate(format: "Self matches %@", regex).evaluate(with: self)
    }
}
