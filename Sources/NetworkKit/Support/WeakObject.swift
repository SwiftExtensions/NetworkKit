//
//  WeakObject.swift
//  NetworkKit
//
//  Created by Algashev Alexander on 29.07.2022.
//

struct WeakObject<Object> where Object : AnyObject {
    weak var object: Object?
    
    init(_ object: Object) {
        self.object = object
    }
    
    
}
