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
         URL, который вызвал сбой загрузки.
         */
        let failingURL: URL?
        
        /**
         Ошибка некорректных метаданных HTTP.
         */
        var invalidHTTPMetadata: URLError {
            let userInfo = [
                NSLocalizedDescriptionKey : "Некорректные метаданные HTTP.",
                NSURLErrorKey : self.failingURL as Any
            ]
            
            return URLError(.badServerResponse, userInfo: userInfo)
        }
        /**
         Ошибка неуспешного статус кода HTTP.
         - Parameter statusCode: Статус код HTTP.
         */
        func unsuccessfulHTTPStatusCode(_ statusCode: Int) -> URLError {
            let statusCodeString = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            let description = "Неуспешный статус код HTTP: \(statusCode) - \(statusCodeString)."
            let userInfo: [String : Any] = [
                NSLocalizedDescriptionKey : description,
                NSURLErrorKey : self.failingURL as Any
            ]
            
            return URLError(.badServerResponse, userInfo: userInfo)
        }
        /**
         Ошибка некорректного ответа сервера.
         */
        var unknownError: URLError {
            let userInfo = [
                NSLocalizedDescriptionKey : "Неизвестная ошибка.",
                NSURLErrorKey : self.failingURL as Any
            ]
            
            return URLError(.badServerResponse, userInfo: userInfo)
        }
        
        
    }
    
    
}
