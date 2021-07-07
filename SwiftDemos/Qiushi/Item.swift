//
//  Item.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/7.
//

import Foundation
import HandyJSON

struct Item: HandyJSON {
    
    let content: String = ""
    let image: String = ""
    let state: String = ""
    var commentsCount: Int = 0
    var allowComment: Bool = false
    var shareCount: Int = 0
    let user: User! = nil
    
    mutating func mapping(mapper: HelpingMapper) {
        
        mapper <<<
            self.commentsCount <-- "comments_count"
        mapper <<<
            self.allowComment <-- "allow_comment"
        mapper <<<
            self.shareCount <-- "share_count"
    }
}
