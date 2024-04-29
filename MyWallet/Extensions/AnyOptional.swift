//
//  AnyOptional.swift
//  SwiftyUtils
//
//  Created by Tom Baranes on 25/04/2020.
//  Copyright © 2020 Tom Baranes. All rights reserved.
//

import Foundation

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

extension Optional {
    var nonNil: String {
        switch self {
        case .some(let value): return String(describing: value)
        case .none : return ""
        }
    }
}
