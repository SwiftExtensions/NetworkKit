//
//  Error.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 19.10.2022.
//

import Foundation

extension Error {
    /**
     Ошибка API загрузки URL.
     */
    var urlError: URLError? {
        self as? URLError
    }
    
    
}
