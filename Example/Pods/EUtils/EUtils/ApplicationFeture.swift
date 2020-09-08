//
//  ApplicationFeture.swift
//  EUtils
//
//  Created by LynnCheng on 2019/10/23.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Foundation

public class ApplicationFeature: NSObject {
    static public let shared = ApplicationFeature()
    
    ///是否为新安装应用
    public var isNewborn = false
    ///是否为版本更新
    public var isNewVersion = false
    ///本应用在应用市场上的最新版本
    public var appstoreVersion:String? = nil
    ///本应用当前安装的版本
    public var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    public var uuid:UUID {
        if let uuid = Defaults[.UUID] as? UUID{
            return uuid
        } else {
            let uuid = UUID()
            Defaults[.UUID] = UUID()
            return uuid
        }
    }
    
    override init() {
        super.init()
        
        let savedVersion = Defaults[.version] as? String
        if savedVersion == nil {
            isNewborn = true
            Defaults[.version] = appVersion
        } else if appVersion.compare(savedVersion!).rawValue > 0 {
            isNewVersion = true
            Defaults[.version] = appVersion
        }
    }
    
    /// 同步检查是否正在审核：这种情况下，需要使用者自己提前调用getAppstoreVersion接口
    public func isInReview() -> Bool {
        if appstoreVersion == nil {
            return false
        } else {
            return appstoreVersion!.compare(appVersion).rawValue > 0
        }
    }
    
    /// 异步检查是否正在审核
    public func checkReviewStatus(appID:String, completionHandler: @escaping (Bool) -> Void) {
        getAppstoreVersion(appID: appID) { version in
            let isInReview = version.compare(self.appVersion).rawValue > 0
            completionHandler(isInReview)
        }
    }
    
    ///异步：获取本应用当前的版本号
    public func getAppstoreVersion(appID:String, completionHandler: @escaping (String) -> Void) {
        if appstoreVersion != nil {
            completionHandler(appstoreVersion!)
        }
        
        let session: URLSession = URLSession.shared
        var request = URLRequest(url: URL(string: "https://itunes.apple.com/lookup?id=\(appID)")!)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                return
            }
            
            do {
                let dict  = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                guard let responseArray = dict as? Dictionary<String, AnyObject> else {
                    return
                }
                
                guard let result = responseArray["results"] as? [AnyObject] else {
                    return
                }
                
                guard let versionDict = result.last as? Dictionary<String, AnyObject> else {
                    return
                }
                
                guard let version = versionDict["version"] as? String else {
                    return
                }
                
                self.appstoreVersion = version
                completionHandler(self.appstoreVersion!)
            } catch {
            }
        }
        
        task.resume()
    }
}
