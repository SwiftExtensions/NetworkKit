//
//  URL.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 10.10.2022.
//

import Foundation

extension URL {
    /**
     Создать URL.
     - Parameter string: Текстовое представление URL.
     - Returns: URL в соответствии с текстовыми данными.
     - Throws: Выбрасывает исключение в случае пустой строки
     или наличии некорретных символов в строке.
     */
    static func build(string: String) throws -> URL {
        if let url = URL(string: string) {
            return url
        } else if string.isEmpty {
            throw URLError.BadURL.emptyURLString
        } else {
            throw URLError.BadURL.illegalCharactersInURLString
        }
    }
    
    
}
