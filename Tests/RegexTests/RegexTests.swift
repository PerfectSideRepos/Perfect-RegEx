import XCTest
@testable import Regex

class RegexTests: XCTestCase {
    func testExample() {
        let test = "this is a long test. The correct number is 123-456-7890 or 647-237-8888 but please don't deal because it's not my number. 我的电话我可不告诉你是 416-970-8888"

	let outcome = test.matches()
	print(outcome)
	XCTAssertEqual(outcome.count, 3)
	XCTAssertEqual(outcome[0].2, "123-456-7890")
	XCTAssertEqual(outcome[1].2, "647-237-8888")
	XCTAssertEqual(outcome[2].2, "416-970-8888")
    }


    static var allTests : [(String, (RegexTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
