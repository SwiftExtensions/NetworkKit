//
//  Decodable.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 29.07.2022.
//

import Foundation

extension Decodable {
    /**
     Декодирует данные в требуемы тип.
     - Parameter data: Декодируемые данные.
     - Parameter decoder: Объект, который позволяет декодировать данные из объекта JSON.
     */
    init(decoding data: Data, decoder: JSONDecoder = JSONDecoder()) throws {
        self = try decoder.decode(Self.self, from: data)
    }
    
    
}
