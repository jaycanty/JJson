import UIKit
import XCTest
import JJson

class Tests: XCTestCase {
    
    var json: JJSON!
    
    override func setUp() {
        super.setUp()
        let data = loadData(forFilename: "json")!
        json = JJSON(data: data)
        print(json)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSubscripts() {
        XCTAssert((json[1]?["foo_code"]?.int)! == 404)
        XCTAssert((json[1]?["foo_rbody"]?["query"]?["info"]?["acme_no"]?.string)! == "444444")
    }
    
    func testIterator() {
        for item in json {
            XCTAssert((item["foo_code"]?.int)! == 404)
            XCTAssert((item["foo_rbody"]?["query"]?["info"]?["acme_no"]?.string)! == "444444")
        }
    }
    
    func testDict() {
        for item in json {
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
        }
    }
    
    func loadData(forFilename fileName: String) -> Data? {
        if let url = Bundle(for: self.classForCoder).url(forResource: fileName, withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                return data
            }
        }
        return nil
    }
}
