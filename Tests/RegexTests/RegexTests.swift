//
//  RegexTests.swift
//  Perfect-RegEx
//
//  Created by Rockford Wei on 2017-02-22.
//  Copyright © 2017 PerfectlySoft. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2017 - 2018 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import XCTest
@testable import Regex

class RegexTests: XCTestCase {

  static var allTests : [(String, (RegexTests) -> () throws -> Void)] {
    return [
      ("testRanges", testRanges),
      ("testSlack", testSlack),
      ("testExample", testExample)
    ]
  }

  func testRanges() {
    XCTAssertTrue("I have a dream.".contains(pattern: "d(.*)m"))
    var source = "there is a bloody bad bread on my bed."
    let ranges = source.match(pattern: "b[a-z]+d")
    XCTAssertEqual(ranges.count, 4)
    print("ranges", ranges)
    source.removeSubrange(ranges[0])
    print("remove bloody", source)
  }

  @available(*, deprecated)
  func testExample() {
    let test = "this is a long test. The correct number is 123-456-7890 or 647-237-8888 but please don't deal because it's not my number. 我的电话我可不告诉你是 416-970-8888"

    let outcome = test.matches()
    print(outcome)
    XCTAssertEqual(outcome.count, 3)
    XCTAssertEqual(outcome[0].2, "123-456-7890")
    XCTAssertEqual(outcome[1].2, "647-237-8888")
    XCTAssertEqual(outcome[2].2, "416-970-8888")
  }

  @available(*, deprecated)
  func testSlack() {
    let source = "send you <@U4MNSLWMD>  :cookie: <@hello> <@myboy123>"
    let u = source.matches(pattern: "<@[^>]+>")
    print(u)
    XCTAssertEqual(u.count, 3)
  }
}
