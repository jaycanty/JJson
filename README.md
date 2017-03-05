# JJson

[![CI Status](http://img.shields.io/travis/jay.canty@generalassemb.ly/JJson.svg?style=flat)](https://travis-ci.org/jay.canty@generalassemb.ly/JJson)
[![Version](https://img.shields.io/cocoapods/v/JJson.svg?style=flat)](http://cocoapods.org/pods/JJson)
[![License](https://img.shields.io/cocoapods/l/JJson.svg?style=flat)](http://cocoapods.org/pods/JJson)
[![Platform](https://img.shields.io/cocoapods/p/JJson.svg?style=flat)](http://cocoapods.org/pods/JJson)


## About

This pod parses json and is syntactically similar to SwiftyJson.  It uses an enum to wrap json into a safe type.  This has not been tested enough to use for anything meaningful. 

## Installation

JJson is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JJson"
```

## Usage

Consider the following json

```
[
    {
        "foo_code": 404,
        "foo_rbody": {
            "query": {
                "info": {
                    "acme_no": "444444",
                    "road_runner": "123"
                },
                "error": "no_lunch",
                "message": "runner problem."
            }
        },
        "acme_no": "444444",
        "road_runner": "123",
        "xyzzy_code": 200,
        "xyzzy_rbody": {
            "api": {
                "items": [
                    {
                        "desc": "OK",
                        "id": 198,
                        "acme_no": "789",
                        "road_runner": "123",
                        "params": {
                            "bicycle": "2wheel",
                            "willie": "hungry",
                            "height": "1",
                            "coyote_id": "1511111"
                        },
                        "activity": "TRAP",
                        "state": "active",
                        "status": 200,
                        "type": "chase"
                    },
                    {
                        "desc": "OK",
                        "id": 198,
                        "acme_no": "789",
                        "road_runner": "123",
                        "params": {
                            "bicycle": "2wheel",
                            "willie": "hungry",
                            "height": "1",
                            "coyote_id": "1511111"
                        },
                        "activity": "TRAP",
                        "state": "active",
                        "status": 200,
                        "type": "chase"
                    }
                ]
            }
        }
    },
    {
        "foo_code": 404,
        "foo_rbody": {
            "query": {
                "info": {
                    "acme_no": "444444",
                    "road_runner": "123"
                },
                "error": "no_lunch",
                "message": "runner problem."
            }
        },
        "acme_no": "444444",
        "road_runner": "123",
        "xyzzy_code": 200,
        "xyzzy_rbody": {
            "api": {
                "items": [
                    {
                        "desc": "OK",
                        "id": 198,
                        "acme_no": "789",
                        "road_runner": "123",
                        "params": {
                            "bicycle": "2wheel",
                            "willie": "hungry",
                            "height": "1",
                            "coyote_id": "1511111"
                        },
                        "activity": "TRAP",
                        "state": "active",
                        "status": 200,
                        "type": "chase"
                    }
                ]
            }
        }
    }
]

```

#### Construct
```
let json = JJSON(data: data)
```

Everything is now wrapped into it's Optional(Type).

#### Subscripts

Array and dictionary subscripting allows for access: 

```
json[1]?["foo_code"]?.int)! == 404
```

#### Array iterator

JJSON can be iterated like an array:

```
for item in json {
    let code = item["foo_code"]?.int
}
```

#### Dictionaries

To iterate dictionaries, use the .dict var:

```
if let dict = item.dict {
    for (key, value) in dict {
        if key == "foo_code" {
            XCTAssert(value.int! == 404)
        }
        if key == "road_runner" {
            XCTAssert(value.string! == "123")
        }
    }
}
```

## Author

jayiosdev@gmail.com

## License

JJson is available under the MIT license. See the LICENSE file for more info.
