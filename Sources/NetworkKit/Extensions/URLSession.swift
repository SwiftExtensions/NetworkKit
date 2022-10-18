//
//  URLSession.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 29.07.2022.
//

import Foundation

extension URLSession {
    /**
     Создает задачу для получения содержимого URL, указанного в параметрах запроса,
     и вызвает блок обработки при завершини.
     
     - Parameter request: Параметры URL запроса.
     - Parameter completionHandler: Блок вызваемый при завершении запроса.
     - Returns: Новую сетевую задачу.
     */
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (URLSessionResponse<Data>) -> Void) -> URLSessionDataTask
    {
        self.dataTask(with: request) { data, response, error in
            let response = URLSessionResponse(rawResponse: (data, response, error))
            completionHandler(response)
        }
    }
    
    
}
