//
//  DetailStaticModel.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/12.
//

import Foundation
import HandyJSON

struct DetailStaticModel: HandyJSON {
    var comic: ComicStaticModel?
    
}

struct ComicStaticModel: HandyJSON {
    var name: String?
    var comic_id: Int = 0
    var short_description: String?
    var accredit: Int = 0
    var cover: String?
    var is_vip: Int = 0
    var type: Int = 0
    var ori: String?
    var theme_ids: [String]?
    var series_status: Int = 0
    var last_update_time: TimeInterval = 0
    var description: String?
    var cate_id: String?
    var status: Int = 0
    var thread_id: Int = 0
    var last_update_week: String?
    var wideCover: String?
//    var classifyTags: [LBUClassifyTagModel]?
    var is_week: Bool = false
    var comic_color: String?
//    var author: LBUAuthorModel?
    var is_dub: Bool = false
    
}
