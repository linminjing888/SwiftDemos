//
//  WidgetTest.swift
//  WidgetTest
//
//  Created by minjing.lin on 2022/3/1.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    /// 占位视图 placeholder：提供一个默认的视图，例如网络请求失败、发生未知错误、第一次展示小组件都会展示这个view
    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
        
        let poster = Poster(author: "Lin", content: "一段文字")
        return SimpleEntry(date: Date(), poster: poster)

    }

    /// 编辑屏幕在左上角选择添加Widget、第一次展示时会调用该方法
    /// getSnapshot：为了在小部件库中显示小部件，WidgetKit要求提供者提供预览快照，在组件的添加页面可以看到效果
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration)
        
        let poster = Poster(author: "Lin", content: "一段文字")
        let entry = SimpleEntry(date: Date(), poster: poster)
        completion(entry)
    }

    /// 进行数据的预处理，转化成Entry
    /// getTimeline：在这个方法内可以进行网络请求，拿到的数据保存在对应的entry中，调用completion之后会到刷新小组件
    /** 参数policy：刷新的时机
     .never：不刷新
     .atEnd：Timeline 中最后一个 Entry 显示完毕之后自动刷新。Timeline 方法会重新调用
     .after(date)：到达某个特定时间后自动刷新
     !!!Widget 刷新的时间由系统统一决定，如果需要强制刷新Widget，可以在 App 中使用 WidgetCenter 来重新加载所有时间线：WidgetCenter.shared.reloadAllTimelines()
    */
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
        
        let currentDate = Date()
        // 设定1小时更新一次数据
        let updateDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        PosterData.getTodayPoster { result in
            let poster: Poster
            if case .success(let testData) = result {
                poster = testData
            }else{
                poster = Poster(author: "Lin", content: "一段文字")
            }
            
            let entry = Entry(date: currentDate, poster: poster)
            let timeLine = Timeline(entries: [entry], policy: .after(updateDate))
            completion(timeLine)
            
        }
        
        let userDefaults = UserDefaults(suiteName: "group.ydq.widget.test")
        let appContent = userDefaults?.object(forKey: "widget") as? String
        print(appContent ?? "--")
    }
}

/// 渲染 Widget 所需的数据模型，需要遵守TimelineEntry协议。
struct SimpleEntry: TimelineEntry {
    let date: Date
//    let configuration: ConfigurationIntent
    let poster: Poster
}

/// 屏幕上 Widget 显示的内容，可以针对不同尺寸的 Widget 设置不同的 View。
struct WidgetTestEntryView : View {
    var entry: Provider.Entry

//    //针对不同尺寸的 Widget 设置不同的 View
//    @Environment(\.widgetFamily) var family
//
//    @ViewBuilder
//    var body: some View {
//        switch family {
//        case .systemSmall:
//            // 小尺寸
//            Text(entry.date, style: .time)
//        case .systemMedium:
//            // 中尺寸
//            Text(entry.date, style: .time)
//            Text("123")
//        default:
//            // 大尺寸
//            Text(entry.date, style: .time)
//            Text("456")
//        }
//    }
    
    /// widgetURL：点击区域是Widget的所有区域，适合元素、逻辑简单的小部件  systemSmall只能用widgetURL实现URL传递接收
    /// Link：通过Link修饰，允许让界面上不同元素产生点击响应  systemMedium、systemLarge可以用Link或者widgetUrl处理
    
    var body: some View {
        ZStack{
            Image(uiImage: entry.poster.posterImage!)
                .resizable()
                .frame(minWidth: 169, maxWidth: .infinity, minHeight: 169, maxHeight: .infinity, alignment: .center)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
            Text(entry.poster.content)
                .foregroundColor(Color.white)
                .lineLimit(4)
                .font(.system(size: 14))
                .padding(.horizontal)
        }.widgetURL(URL(string: "widget.url"))
    }
    
//    @Environment(\.colorScheme) var colorScheme  // 适配暗黑模式
//    var bgColor : some View {
//        colorScheme == .dark ? Color.black : Color.red
////        `Color.red`
//    }
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                bgColor
//
//                VStack{
//
//                    Spacer().frame(height: 10)
//
//                    HStack{
//                        Spacer().frame(width: 20)
//                        Text("这是一个标题").foregroundColor(.white)
//                        Link(destination: URL(string: "widget.image.url")!) {
//                            Image("bg_default").frame(width: 25, height: 25).clipped()
//                        }
//                        Spacer()
//                    }
//                    Spacer()
//
//                    VStack(alignment: .leading, spacing: 10) {
//                        Item()
//                        Item()
//                        Item()
//                        Item()
//                    }
//                    Spacer()
//                }
//
//            }.widgetURL(URL(string: "widget.url"))
//        }
//    }
    
}

struct Item: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            
            Spacer().frame(width: 10)
            Text("第1个Text")
                .font(.system(size: 14))
                .foregroundColor(.white)
            Text("第2个Text")
                .font(.system(size: 14))
                .foregroundColor(.white)
            Spacer()
            Text("第3个Text")
                .font(.system(size: 14))
                .foregroundColor(.white)
            Spacer().frame(width: 10)
        }
    }

}

/// @main 主入口
@main
struct WidgetTest: Widget {
    let kind: String = "WidgetTest"

    /// kind：是Widget的唯一标识
    /** WidgetConfiguration：初始化配置代码
     StaticConfiguration : 可以在不需要用户任何输入的情况下自行解析，可以在 Widget 的 App 中获 取相关数据并发送给 Widget
     IntentConfiguration： 主要针对于具有用户可配置属性的Widget，依赖于 App 的 Siri Intent，会自动接收这些 Intent 并用于更新 Widget，用于构建动态 Widget
     */
    /// configurationDisplayName：添加编辑界面展示的标题
    /// description：添加编辑界面展示的描述内容
    /// supportedFamilies：设置Widget支持的控件大小，不设置则默认三个样式都实现
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetTestEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
//        .supportedFamilies([.systemMedium])
    }
}

struct WidgetTest_Previews: PreviewProvider {
    static var previews: some View {
        
        let poster = Poster(author: "Lin", content: "一段文字")
        WidgetTestEntryView(entry: SimpleEntry(date: Date(), poster: poster))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

// Widget数据请求及网络图片加载
struct Poster {
    let author: String
    let content: String
    var posterImage: UIImage? = UIImage(named: "bg_default")
}

struct PosterData {
    static func getTodayPoster(completion: @escaping (Result<Poster, Error>) -> Void) {
        let url = URL(string: "https://nowapi.navoinfo.cn/get/now/today")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error==nil else{
                completion(.failure(error!))
                return
            }
            let poster=posterFromJson(fromData: data!)
            completion(.success(poster))
        }
        task.resume()
    }
    
    static func posterFromJson(fromData data:Data) -> Poster {
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        guard let result = json["result"] as? [String: Any] else{
            return Poster(author: "Now", content: "加载失败")
        }
        
        let author = result["author"] as! String
        let content = result["celebrated"] as! String
        let posterImage = result["poster_image"] as! String
        
        //图片同步请求
        var image: UIImage? = nil
        if let imageData = try? Data(contentsOf: URL(string: posterImage)!) {
            image = UIImage(data: imageData)
        }
        
        return Poster(author: author, content: content, posterImage: image)
    }
}
