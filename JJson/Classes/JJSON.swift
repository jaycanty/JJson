//
//  JJSON.swift
//  Pods
//
//  Created by jay on 3/5/17.
//
//

import Foundation

public indirect enum JJSON: Sequence, IteratorProtocol {
    
    case none
    case number(NSNumber)
    case string(String)
    
    case dictionary([String:JJSON])
    case array([JJSON], IndexingIterator<Array<JJSON>>)
    // iterator stored as associated type to loop on JSON directly
    
    public var bool: Bool? {
        switch self {
        case let .number(value):
            return value.boolValue
        default:
            return nil
        }
    }
    
    public var int: Int? {
        switch self {
        case let .number(value):
            return value.intValue
        default:
            return nil
        }
    }
    
    public var double: Double? {
        switch self {
        case let .number(value):
            return value.doubleValue
        default:
            return nil
        }
    }
    
    public var string: String? {
        switch self {
        case let .string(value):
            return value
        default:
            return nil
        }
    }
    
    public var dict: [String: JJSON]? {
        switch self {
        case let .dictionary(dict):
            return dict
        default:
            return nil
        }
    }
    
    public init(_ any: Any) {
        switch any {
        case is NSNumber:
            self = .number(any as! NSNumber)
        case is NSString:
            self = .string(any as! String)
        case is NSArray:
            let inArray = any as! NSArray
            let outArray = inArray.map() { JJSON($0) }
            self = .array(outArray, outArray.makeIterator())
        case is NSDictionary:
            let dictionary = any as! NSDictionary
            var result = [String: JJSON]()
            for (key, value) in dictionary {
                if let key = key as? String {
                    result[key] = JJSON(value)
                }
            }
            self = .dictionary(result)
        default:
            self = .none
        }
    }
    
    public init?(data: Data) {
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            self.init(parsedData)
        } catch {
            return nil
        }
    }
    
    public subscript(key: String) -> JJSON? {
        switch self {
        case let .dictionary(dict):
            return dict[key]
        default:
            return nil
        }
    }
    
    public subscript(index: Int) -> JJSON? {
        switch self {
        case let .array(array, _):
            return array[index]
        default:
            return nil
        }
    }
    
    // only for case .array(_:_)
    // to iterate dictionary, use dict var
    public mutating func next() -> JJSON? {
        switch self {
        case let .array(array, iterator):
            var iterator = iterator
            if let json = iterator.next() {
                self = .array(array, iterator)
                return json
            } else {
                self = .array(array, array.makeIterator())
                return nil
            }
        default:
            return nil
        }
    }
}
