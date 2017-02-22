#if os(Linux)
import SwiftGlibc
#else
import Darwin
#endif

extension String {

  /// using regular expression to extract substrings
  /// - parameters:
  ///   - pattern: String, the regular expression; default value is a typical phone number, like 123-456-7890
  ///   - limitation: Int, the maximum number of matches allowed to find; default is 32, which means the first 32 needles would be found and save from the stack
  /// - returns:
  ///   [(Int, Int, String)] - a turple array, each element is the range begin / end mark, with the extraction value; if nothing found or error happened, the result set will be empty.
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
        memcpy(copy!, cursor!.advanced(by: Int(p.rm_so)), p.rm_eo - p.rm_so)

        // turn the pointer into string
        let extraction = String(cString: copy!)

        // append outcomes to return set
        found.append((Int(p.rm_so), Int(p.rm_eo), extraction))
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
