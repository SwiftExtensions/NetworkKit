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
     Ошибка запроса (_при наличии_).
     */
    public var error: Error? {
        var error: Error?
        if case let .failure(_error) = self.result {
            error = _error
        }
        
        return error
    }
    
    /**
     Проверить успешность запроса.
     - Parameter statusCodes: Список успешных статус кодов HTTP.
     - Returns: Данные, проверенные на успешность запроса.
     */
    public func validating(
        successfulHTTPStatusCodes statusCodes: (any Collection<Int>)?
    ) -> URLSessionResponse where Model == Data {
        guard let statusCodes else { return self }
        guard let statusCode = self.metadata?.statusCode else { return self }
        guard !statusCodes.contains(statusCode) else { return self }
        
        let error = URLError
            .BadServerResponse(failingURL: metadata?.url)
            .unsuccessfulHTTPStatusCode(statusCode)

        return URLSessionResponse(metadata: self.metadata, result: .failure(error))
    }
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

// MARK: - Инициализатор

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
            let error = URLError.BadServerResponse(failingURL: nil).invalidHTTPMetadata
            self.result = .failure(error)
        } else if let body = rawResponse.body {
            self.result = .success(body)
        } else {
            let error = URLError.BadServerResponse(failingURL: self.metadata?.url).unknownError
            self.result = .failure(error)
        }
    }
    
    
}
