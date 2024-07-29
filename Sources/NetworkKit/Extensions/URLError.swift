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
            let userInfo = self.userInfo(description: "Некорректные метаданные HTTP.")
            return URLError(.badServerResponse, userInfo: userInfo)
        }
        
        /**
         Информация об ошибке.
         - Parameter description: Описание ошибки.
         - Returns: Информацию об ошибке.
         */
        func userInfo(description: String) -> [String : Any] {
            [
               NSLocalizedDescriptionKey : description,
               NSURLErrorFailingURLErrorKey : self.failingURL as Any,
               NSURLErrorFailingURLStringErrorKey : self.failingURL?.absoluteString as Any,
           ]
        }
        /**
         Ошибка неуспешного статус кода HTTP.
         - Parameter statusCode: Статус код HTTP.
         */
        func unsuccessfulHTTPStatusCode(_ statusCode: Int) -> URLError {
            let statusCodeString = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            let userInfo = self.userInfo(
                description: "Неуспешный статус код HTTP: \(statusCode) - \(statusCodeString)."
            )
            
            return URLError(.badServerResponse, userInfo: userInfo)
        }
        /**
         Ошибка некорректного ответа сервера.
         */
        var unknownError: URLError {
            let userInfo = self.userInfo(description: "Неизвестная ошибка.")
            return URLError(.badServerResponse, userInfo: userInfo)
        }
        
        
    }
    
    
}
