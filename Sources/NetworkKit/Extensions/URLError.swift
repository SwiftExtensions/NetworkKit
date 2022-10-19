//
//  URLError.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 28.07.2022.
//

import Foundation

extension URLError {
    /**
     Ошибки некорректной ссылки.
     */
    struct BadURL {
        /**
         Пустая строка URL.
         */
        static var emptyURLString: URLError {
            let userInfo = [
                NSLocalizedDescriptionKey : "Пустая строка URL."
            ]
            
            return URLError(.badURL, userInfo: userInfo)
        }
        /**
         Недопустимые символы в строке URL.
         */
        static var illegalCharactersInURLString: URLError {
            let userInfo = [
                NSLocalizedDescriptionKey : "Недопустимые символы в строке URL."
            ]
            
            return URLError(.badURL, userInfo: userInfo)
        }
        
        
    }
    
    /**
     Ошибки некорректной ссылки.
     */
    struct BadServerResponse {
        /**
         Ошибка некорректных метаданных HTTP.
         */
        static var invalidHTTPMetadata: URLError {
            let userInfo = [
                NSLocalizedDescriptionKey : "Некорректные метаданные HTTP."
            ]
            
            return URLError(.badServerResponse, userInfo: userInfo)
        }
        /**
         Ошибка неуспешного статус кода HTTP.
         */
        static func unsuccessfulHTTPStatusCode(_ statusCode: Int) -> URLError {
            let userInfo = [
                NSLocalizedDescriptionKey : "Неуспешный статус код HTTP: \(statusCode) - \(HTTPURLResponse.localizedString(forStatusCode: statusCode))."
            ]
            
            return URLError(.badServerResponse, userInfo: userInfo)
        }
        /**
         Ошибка некорректного ответа сервера.
         */
        static var unknownError: URLError {
            let userInfo = [
                NSLocalizedDescriptionKey : "Неизвестная ошибка."
            ]
            
            return URLError(.badServerResponse, userInfo: userInfo)
        }
        
        
    }
    
    
}
