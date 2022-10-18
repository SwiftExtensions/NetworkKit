//
//  Result.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 29.07.2022.
//

public extension Result {
    /**
     Значение успешного результата.
     */
    var success: Success? { self.output.success }
    /**
     Значение неудачного результата.
     */
    var failure: Failure? { self.output.failure }
    
    /**
     Кортеж значений результата.
     */
    private var output: (success: Success?, failure: Failure?) {
        let output: (Success?, Failure?)
        switch self {
        case let .success(value):
            output = (value, nil)
        case let .failure(error):
            output = (nil, error)
        }
        
        return output
    }
    
    
}
