//
//  URLSessionResponse.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 28.07.2022.
//

import Foundation

/**
 Синтактический сахар для обработки результата запросов.
 */
public struct URLSessionResponse<Model> {
    /**
     Метаданные ответа.
     */
    public let metadata: HTTPURLResponse?
    /**
     Результат запроса.
     */
    public let result: Result<Model, Error>
    
    /**
     Декодировать полученные от сервера данные к нужному типу.
     - Parameter type: Запрашиваемый тип данных.
     - Parameter decoder: Объект для декодирования данных.
     - Returns: Данные  декодированные к нужному типу.
     */
    public func decoding<DecodableModel: Decodable>(
        type: DecodableModel.Type,
        decoder: JSONDecoder = JSONDecoder()) -> URLSessionResponse<DecodableModel> where Model == Data
    {
        let result: Result<DecodableModel, Error> = Result {
            let data = try self.result.get()
            return try DecodableModel(decoding: data, decoder: decoder)
        }
        
        return URLSessionResponse<DecodableModel>(metadata: self.metadata, result: result)
    }
    
    
}

// MARK: Инициализатор

public extension URLSessionResponse where Model == Data {
    /**
     Создает экземпляр с параметрами ответа сервера.
     - Parameter rawResponse: Кортеж с ответом сервера.
     */
    init(rawResponse: (body: Data?, metadata: URLResponse?, error: Error?)) {
        self.metadata = rawResponse.metadata as? HTTPURLResponse
        if let error = rawResponse.error {
            self.result = .failure(error)
        } else if self.metadata == nil {
            self.result = .failure(URLError.BadServerResponse.invalidHTTPMetadata)
        } else if let body = rawResponse.body {
            self.result = .success(body)
        } else {
            self.result = .failure(URLError.BadServerResponse.unknownError)
        }
    }
    
    
}
