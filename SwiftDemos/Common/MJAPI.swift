//
//  MJAPI.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/12.
//

import Foundation
import Moya
import HandyJSON
import MBProgressHUD

let LoadingPlugin = NetworkActivityPlugin {(type, target) in
    
    DispatchQueue.main.async { // 主线程刷新
        guard let vc = topVC else { return }
        switch type {
        case .began:
            MBProgressHUD.hide(for: vc.view, animated: false)
            MBProgressHUD.showAdded(to: vc.view, animated: true)
        case .ended:
            MBProgressHUD.hide(for: vc.view, animated: true)
        }
    }

}


let ApiProvider = MoyaProvider<MJApi>(requestClosure: timeoutClosure)
let ApiLoadingProvider = MoyaProvider<MJApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

let timeoutClosure = {(endpoint: Endpoint ,closure: MoyaProvider.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    }else{
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

enum MJApi {
   
    //详情(基本)
    case detailStatic(comicid: Int)
    //评论
    case commentList(object_id: Int, thread_id: Int, page: Int)
    //猜你喜欢
    case guessLike
    //详情(实时)
    case detailRealtime(comicid: Int)
    //搜索结果
    case searchResult(argCon: Int, q: String)
}

extension MJApi: TargetType {
    var baseURL: URL {
        return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")!
    }
    
    var path: String {
        switch self {
        
        case .detailStatic: return "comic/detail_static_new"
        case .commentList: return "comment/list"
        case .guessLike: return "comic/guessLike"
            
        case .detailRealtime: return "comic/detail_realtime"
        case .searchResult: return "search/searchResult"
     
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var parmeters: [String : Any] = [:]
        switch self {
  
        case .detailStatic(let comicid),.detailRealtime(comicid: let comicid):
            parmeters["comicid"] = comicid
        case .commentList(let object_id, let thread_id, let page):
            parmeters["object_id"] = object_id
            parmeters["thread_id"] = thread_id
            parmeters["page"] = page
            
        case .searchResult(let argCon, let q):
            parmeters["argCon"] = argCon
            parmeters["q"] = q
        default:
            break
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString as Any)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider {
    
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {

        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            switch result {
            case .success(let value):
                guard let returnData = try? value.mapModel(MJResponseData<T>.self) else {
                    completion(nil)
                    return
                }
                completion(returnData.data?.returnData)
            
            case .failure(let error):
                print(error)
                completion(nil)
            }
        })
    }
}

struct MJReturnData<T: HandyJSON>: HandyJSON {
    var message: String?
    var returnData: T?
    var stateCode: Int = 0
    
}
struct MJResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: MJReturnData<T>?
    
}
