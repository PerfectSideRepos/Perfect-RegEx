# 字符串正则表达式扩展 

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="https://gitter.im/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_2_Git.jpg" alt="Chat on Gitter" />
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
    <a href="https://gitter.im/PerfectlySoft/Perfect?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge" target="_blank">
        <img src="https://img.shields.io/badge/Gitter-Join%20Chat-brightgreen.svg" alt="Join the chat at https://gitter.im/PerfectlySoft/Perfect">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>


该项目实现了 Swift 字符串的一个非常轻量、简单的正则表达式扩展。

该软件使用SPM进行编译和测试，本软件也是[Perfect](https://github.com/PerfectlySoft/Perfect)项目的一部分。本软件包可独立使用，因此使用时可以脱离PerfectLib等其他组件。

请确保您已经安装并激活了最新版本的 Swift 4.0 tool chain 工具链。



## 编译

请在您的Package.swift 文件中增加如下依存关系：

``` swift

.Package(url:"https://github.com/PerfectSideRepos/Perfect-RegEx.git", majorVersion: 3)

```

然后在源代码开头部分引用函数库：

``` swift

import Regex

```

## 快速上手

以下示范代码展示了如何从字符串内提取电话号码：

``` swift
let text = "this is a long test. The correct number is 123-456-7890 or 647-237-8888 but please don't deal because it's not my number. 我的电话我可不告诉你是 416-970-8888 🇨🇳 🇨🇦 "

let found = text.matches()
print(found)
```

## API 参考

本函数库内只有一个函数，名为`matches()`:

``` swift
extension String {
  public func matches(pattern: String = "[0-9]{3}-[0-9]{3}-[0-9]{4}", limitation: Int = 32)
    -> [(rangeBegin: Int, rangeEnd: Int, extraction: String)]
}
```

### 参数:
- pattern: String, 正则表达式，默认为一个电话号码，比如 123-456-7890
- limitation: Int, 允许检索的最大结果数量限制。默认为32，意味着只有前32个结果能够返回

### 返回值：

`[(rangeBegin: Int, rangeEnd: Int, extraction: String)]` - 一个元组数组，每个元素分别有三个单元，依次为检索结果的起点为止、终点位置，以及随后提取的匹配字符串。如果没找到或者出错，返回值为空数组。

### 问题报告、内容贡献和客户支持

我们目前正在过渡到使用JIRA来处理所有源代码资源合并申请、修复漏洞以及其它有关问题。因此，GitHub 的“issues”问题报告功能已经被禁用了。

如果您发现了问题，或者希望为改进本文提供意见和建议，[请在这里指出](http://jira.perfect.org:8080/servicedesk/customer/portal/1).

在您开始之前，请参阅[目前待解决的问题清单](http://jira.perfect.org:8080/projects/ISS/issues).

## 更多信息
关于本项目更多内容，请参考[perfect.org](http://perfect.org).
