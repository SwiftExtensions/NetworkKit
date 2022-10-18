//
//  Networker.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 29.07.2022.
//

import Foundation

/**
 Менеджер сетевых запросов.
 */
public struct Networker {
    /**
     Создать менеджера сетевых запросов.
     */
    public init() { }
    /**
     Активные сетевые запросы.
     */
    private var tasks = [WeakObject<URLSessionDataTask>]()
    
    /**
     Загрузить данные из сети с помощью
     [URLRequest](https://developer.apple.com/documentation/foundation/urlrequest).
     
     - Note: В случае вызова метода
     [cancel()](https://developer.apple.com/documentation/foundation/urlsessiontask/1411591-cancel)
     блок завершения не вызывается.
     
     - Parameter request: Параметры URL запроса.
     - Parameter completionHandler: Блок вызваемый при завершении запроса.
     - Returns: Задача URL сессии.
     */
    @discardableResult
    public mutating func loadData(
        with request: URLRequest,
        completionHandler: @escaping (URLSessionResponse<Data>) -> Void) -> URLSessionDataTask
    {
        let task = URLSession.shared.dataTask(with: request) { response in
            if let error = response.result.failure as? URLError, error.code == .cancelled {
                return
            }
            
            completionHandler(response)
        }
        task.resume()
        self.tasks.append(WeakObject(task))
        
        return task
    }
    /**
     Сетевая задача на загрузку и парсинг данных.
     - Parameter request: Параметры URL запроса.
     - Parameter decoder: Объект для декодирования данных.
     - Parameter completion: Блок вызываемый при завершение запроса.
     Принимает объект ошибки, в случае неудачи.
     - Returns: Задача URL сессии.
     */
    @discardableResult
    public mutating func loadDecodable<Model>(
        with request: URLRequest,
        decoder: JSONDecoder = JSONDecoder(),
        completionHandler: @escaping (URLSessionResponse<Model>) -> Void)  -> URLSessionDataTask where Model : Decodable
    {
        self.loadData(with: request) { response in
            let response = response.decoding(type: Model.self, decoder: decoder)
            completionHandler(response)
        }
    }
    /**
     Отменить активные сетевые запросы.
     */
    public mutating func cancelRunningTasks() {
        self.tasks.forEach {
            if $0.object?.state == .running {
                $0.object?.cancel()
            }
        }
        self.tasks = []
    }
    
    
}
