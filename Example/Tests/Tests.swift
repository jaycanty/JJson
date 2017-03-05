import UIKit
import XCTest
import JJson

class Tests: XCTestCase {
    
    var json: JJSON!
    
    override func setUp() {
        super.setUp()
        json = loadJson(forFilename: "json")
        print(json)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func loadJson(forFilename fileName: String) -> JJSON? {
        if let url = Bundle(for: self.classForCoder).url(forResource: fileName, withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                return JJSON(data: data)
            }
        }
        return nil
    }
    
}
