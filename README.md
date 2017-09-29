# String Extension of Regular Expression  [简体中文](README.zh_CN.md)

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="http://stackoverflow.com/questions/tagged/perfect" target="_blank">
        <img src="http://www.perfect.org/github/perfect_gh_button_2_SO.jpg" alt="Stack Overflow" />
    </a>  
    <a href="https://twitter.com/perfectlysoft" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
    </a>  
    <a href="http://perfect.ly" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
    </a>
</p>

<p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat" alt="Swift 4.0">
    </a>
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
    </a>
    <a href="http://perfect.org/licensing.html" target="_blank">
        <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
    </a>
    <a href="http://twitter.com/PerfectlySoft" target="_blank">
        <img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>



This project provides a light weight / simple regular expression extension for Swift String.

This package builds with Swift Package Manager and is part of the [Perfect](https://github.com/PerfectlySoft/Perfect) project. It was written to be stand-alone and so does not require PerfectLib or any other components.

Ensure you have installed and activated the latest Swift 4.0 tool chain.


## Building
Add this project as a dependency in your Package.swift file.

``` swift
.Package(url:"https://github.com/PerfectSideRepos/Perfect-RegEx.git", majorVersion: 3)
```

Then please add the following line to the beginning part of swift sources:
``` swift
import Regex
```

## Quick Start

The following demo shows how to extract substrings with a pattern, for example, phone numbers:

``` swift
let text = "this is a long test. The correct number is 123-456-7890 or 647-237-8888 but please don't deal because it's not my number. 我的电话我可不告诉你是 416-970-8888 🇨🇳 🇨🇦 "

let found = text.matches()
print(found)
```

## API Info

There is only one function in this library, called `matches()`:

``` swift
extension String {
  public func matches(pattern: String = "[0-9]{3}-[0-9]{3}-[0-9]{4}", limitation: Int = 32)
    -> [(rangeBegin: Int, rangeEnd: Int, extraction: String)]
}
```

### Parameters:
- pattern: String, the regular expression; default value is a typical phone number, like 123-456-7890
- limitation: Int, the maximum number of matches allowed to find; default is 32, which means the first 32 needles would be found and save from the stack

### Returns:

`[(rangeBegin: Int, rangeEnd: Int, extraction: String)]` - a tuple array, each element is the range begin / end mark, with the extraction value; if nothing found or error happened, the result set will be empty.

## Issues

We are transitioning to using JIRA for all bugs and support related issues, therefore the GitHub issues has been disabled.

If you find a mistake, bug, or any other helpful suggestion you'd like to make on the docs please head over to [http://jira.perfect.org:8080/servicedesk/customer/portal/1](http://jira.perfect.org:8080/servicedesk/customer/portal/1) and raise it.

A comprehensive list of open issues can be found at [http://jira.perfect.org:8080/projects/ISS/issues](http://jira.perfect.org:8080/projects/ISS/issues)

## Further Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).
