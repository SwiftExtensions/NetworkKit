//
//  URLSession.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 29.07.2022.
//

import Foundation

extension URLSession {
    /**
     Блок вызваемый при завершении запроса.
     */
    typealias Completion = (_ response: URLSessionResponse<Data>) -> Void
    
    /**
     Создает задачу для получения содержимого URL, указанного в параметрах запроса,
     и вызвает блок обработки при завершини.
     
     - Parameter request: Параметры URL запроса.
     - Parameter completion: Блок вызваемый при завершении запроса.
     - Returns: Новую сетевую задачу.
     */
    func dataTask(
        with request: URLRequest,
        completion: @escaping Completion) -> URLSessionDataTask
    {
        self.dataTask(with: request) { data, response, error in
            let response = URLSessionResponse(
                request: request,
                rawResponse: (data, response, error)
            )
            completion(response)
        }
    }
    
    
}
