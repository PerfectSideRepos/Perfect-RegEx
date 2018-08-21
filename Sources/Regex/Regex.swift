//
//  Regex.swift
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

#if os(Linux)
import SwiftGlibc
#else
import Darwin
#endif

public class RegEx {
  var reg = regex_t()
  public init?(_ pattern: String) {
    guard 0 == regcomp(&reg, pattern, REG_EXTENDED) else {
      return nil
    }
  }
  deinit {
    regfree(&reg)
  }

  /// test if the current string contains a certain pattern
  /// - parameters:
  ///   - string: string to search
  /// - returns: true if found
  public func exists( _ string: String) -> Bool {
    return match(string).count > 0
  }

  /// using regular expression to extract substrings
  /// - parameters:
  ///   - string: String to search
  ///   - limitation: Int, the maximum number of matches allowed to find
  /// - returns:
  ///   [Range] - an array, each element is a range of match
  public func match(_ string: String) -> [Range<String.Index>] {

     // set up an empty result set
    var found = [Range<String.Index>]()

    // prepare pointers
    guard let me = strdup(string) else {
      return found
    }

    // string length
    let sz = Int(string.count)
    let limitation = sz

    // cursor of the string buffer
    var cursor = me

    // allocate a buffer for the outcomes
    let m = UnsafeMutablePointer<regmatch_t>.allocate(capacity: limitation)
    defer {
      m.deallocate()
      free(me)
    }

    // loop until all matches were found
    while 0 == regexec(&reg, cursor, limitation, m, 0) {

      // retrieve each matches from the pointer buffer
      for i in 0 ... limitation - 1 {

        // if reach the end, the position marker will be -1
        let p = m.advanced(by: i).pointee
        guard p.rm_so > -1 else {
          break
        }//end guard

        // append outcomes to return set
        let offset = me.distance(to: cursor)
        let start = String.Index(encodedOffset: Int(p.rm_so) + offset)
        let end = String.Index(encodedOffset: Int(p.rm_eo) + offset)
        found.append(start ..< end)
      }//next i

      cursor = cursor.advanced(by: Int(m.pointee.rm_eo))
    }

    return found
  }
}

extension String {

  /// test if the string contains certain pattern
  /// - parameters:
  ///   - pattern: string to recognize
  /// - return: true for found
  public func contains(pattern: String) -> Bool {
    guard let reg = RegEx(pattern) else {
      return false
    }
    return reg.exists(self)
  }

  /// find string ranges
  /// - parameters:
  ///   - pattern: string to recognize
  /// - return: a string range array
  public func match(pattern: String) -> [Range<String.Index>] {
    guard let reg = RegEx(pattern) else {
      return []
    }
    return reg.match(self)
  }
  /// using regular expression to extract substrings
  /// - parameters:
  ///   - pattern: String, the regular expression; default value is a typical phone number, like 123-456-7890
  ///   - limitation: Int, the maximum number of matches allowed to find; default is 32, which means the first 32 needles would be found and save from the stack
  /// - returns:
  ///   [(Int, Int, String)] - a turple array, each element is the range begin / end mark, with the extraction value; if nothing found or error happened, the result set will be empty.
  @available(*, deprecated)
  public func matches(pattern: String = "[0-9]{3}-[0-9]{3}-[0-9]{4}", limitation: Int = 32) -> [(rangeBegin: Int, rangeEnd: Int, extraction: String)] {

    // set up an empty result set
    var found = [(rangeBegin: Int, rangeEnd: Int, extraction: String)]()

    // prepare to compile the regular expression
    var reg = regex_t()
    let status = regcomp(&reg, pattern, REG_EXTENDED)
    if status != 0 {
      return found
    }//end if

    // allocate a buffer for the outcomes
    let m = UnsafeMutablePointer<regmatch_t>.allocate(capacity: limitation)

    // preform searching
    var nomatch:Int32 = 1

    // prepare pointers
    let me = strdup(self)
    var cursor = me
    let copy = strdup(self)
    let sz = Int(strlen(me!))

    // loop until all matches were found
    repeat {

      // perform the search
      nomatch = regexec(&reg, cursor, limitation, m, 0)

      // no match was found, jump out
      if nomatch != 0 {
        break
      }//end if


      // retrieve each matches from the pointer buffer
      for i in 0 ... limitation - 1 {

        // if reach the end, the position marker will be -1
        let p = m.advanced(by: i).pointee
        guard p.rm_so > -1 else {
          break
        }//end guard

        // save the result into the duplicated string
        memset(copy!, 0, Int(sz))
        memcpy(copy!, cursor!.advanced(by: Int(p.rm_so)), Int(p.rm_eo) - Int(p.rm_so))

        // turn the pointer into string
        let extraction = String(cString: copy!)

        // append outcomes to return set
        let offset = me?.distance(to: cursor!)
        found.append((Int(p.rm_so) + offset!, Int(p.rm_eo) + offset!, extraction))
      }//next i

      cursor = cursor!.advanced(by: Int(m.pointee.rm_eo))

      // loop until nothing further was found
    }while(nomatch == 0)

    // release temporary allocations
    free(copy)
    free(me)
    // release resources before checking outcomes
    regfree(&reg)
    // release the pointer buffer
    m.deallocate(capacity: limitation)
    return found
  }//end func
}//end extension
