//
//  DetailStaticModel.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/12.
//

import Foundation
import HandyJSON


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

struct LBUImHightModel: HandyJSON {
    var height: Int = 0
    var width: Int = 0
}

struct ChapterStaticModel: HandyJSON {
    var chapter_id: Int = 0
    var name: String?
    var image_total: Int = 0
    var type: Int = 0
    var price:String?
    var size: Int32 = 0
    var pass_time: TimeInterval = 0
    var release_time: TimeInterval = 0
    var zip_high_webp: Int = 0
    var is_new: Bool = false
    var has_locked_image: Bool = false
    var imHightArr: [[LBUImHightModel]]?
    var countImHightArr: Int = 0
}

struct OtherWorkModel: HandyJSON {
    var comicId: Int = 0
    var coverUrl: String?
    var name: String?
    var passChapterNum: Int = 0
    
}

struct DetailStaticModel: HandyJSON {
    var comic: ComicStaticModel?
    var chapter_list: [ChapterStaticModel]?
    var otherWorks: [OtherWorkModel]?
}


