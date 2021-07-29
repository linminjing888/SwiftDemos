//
//  DetailStaticModel.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/12.
//

import Foundation
import HandyJSON

// 图书详情
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

// 图书章节
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

// 图书评论
struct CommentListMode: HandyJSON {
    
    var commentCount: Int = 0
    var commentList: [CommentModel]?
    var hasMore: Bool = false
    var objectId: Int = 0
    var objectType: String?
    var page: Int = 0
    var pageCount: Int = 0
    var serverNextPage: Int = 0
}

struct CommentModel: HandyJSON {
    var cate: Int = 0
    var color: String?
    var comic_author: Int = 0
    var comment_from: String?
    var comment_id: Int = 0
    var content: String?
    var content_filter: String?
    var create_time: TimeInterval = 0
    var create_time_str: String?
    var exp: Float = 0
    var face: String?
    var face_type: Int = 0
    var floor: Int = 0
    var gift_img: String?
    var gift_num: Int = 0
    var group_admin: Bool = false
    var group_author: Bool = false
    var group_custom: Bool = false
    var group_user: Bool = false
    var id: Int = 0
    var imageList: [Any]?
    var ip: String?
    var is_choice: Bool = false
    var is_delete: Bool = false
    var is_lock: Bool = false
    var is_up: Bool = false
//    var level: LBULevelModel?
    var likeCount: Int = 0
    var likeState: Int = 0
    var nickname: String?
    var online_time: TimeInterval = 0
    var sex: String?
    var ticketNum: Int = 0
    var title: String?
    var total_reply: Int = 0
    var user_id: Int = 0
    var vip_exp: Int = 0
}

struct GuessLikeModel: HandyJSON {
    
    var normal: Bool = false
    var last_modified: Int = 0
    var comics: [BookModel]?
}

struct BookModel: HandyJSON {
    
    var comic_id: Int = 0
    var name: String?
    var cover: String?
    var short_description: String?
    var ori_cover: String?
    var new_comic: Bool = false
}


struct ImageModel: HandyJSON {
    var location: String?
    var image_id: Int = 0
    var width: Int = 0
    var height: Int = 0
    var total_tucao: Int = 0
    var webp: Int = 0
    var type: Int = 0
    var img05: String?
    var img50: String?
}

struct ChapterModel: HandyJSON {
    var status: Int = 0
    var chapter_id: Int = 0
    var type: Int = 0
    var image_list: [ImageModel]?
}
