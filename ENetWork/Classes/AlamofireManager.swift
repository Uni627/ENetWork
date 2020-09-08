//
//  AlamofireManager.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/8.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Alamofire
import SwiftyJSON
@_exported import EUtils

open class AlamofireManager: SessionManager {
    public var baseURL = ""
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "changeEnvironment"), object: nil)
    }

    @objc func changeEnvironment() {
        baseURL = EServicesConfig.BMSURL
    }
    
    public init (baseURL: String) {
        self.baseURL = baseURL
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = EServicesConfig.requestTimeout
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.urlCredentialStorage = nil
        super.init(configuration: configuration, serverTrustPolicyManager: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeEnvironment), name: Notification.Name("changeEnvironment"), object: nil)
    }
    
    public func putRequest(with path: String, needToken: Bool = true, header: [String: String]? = nil, parameters: [String: Any], success: successBlock?, fail: failBlock?) {
        var m_header: [String: String]?
        if header == nil {
            m_header = defaultHeader(need: needToken)
            if m_header == nil {
                fail?(ErrorModel.noAuth)
                return
            }
        } else {
            m_header = header
        }
        #if DEBUG
        print("RequsetURL:\(baseURL + path)")
        print("RequsetData:\(JSON(parameters))")
        #endif
        self.request(baseURL + path, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: m_header).response { (response) in
            let result = self.handler(response)

            if let error = result.1 {
                fail?(error)
            } else if let data = result.0 {
                guard let responseJson = try? JSON(data: data) else {
                    return fail!(ErrorModel.custom("接口返回出错"))
                }
                success?(responseJson)
            }
        }
    }

    public func postRequest(with path: String, needToken: Bool = true, parameters: [String: Any], header: [String: String]? = nil, queue: DispatchQueue? = nil, success: successBlock?, fail: failBlock?) {
        var m_header: [String: String]?
        if header == nil {
            m_header = defaultHeader(need: needToken)
            if m_header == nil {
                fail?(ErrorModel.noAuth)
                return
            }
        } else {
            m_header = header
        }
        #if DEBUG
        print("RequsetURL:\(baseURL + path)")
        print("RequsetData:\(JSON(parameters))")
        #endif
        self.request(baseURL + path, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: m_header).response(queue: queue) { (response) in
            let result = self.handler(response)

            if let error = result.1 {
                fail?(error)
            } else if let data = result.0 {
                guard let responseJson = try? JSON(data: data) else {
                    return fail!(ErrorModel.custom("接口返回出错"))
                }
                success?(responseJson)
            }
        }
    }

    public func getRequest(with path: String, needToken: Bool = true, header: [String: String]? = nil, success: successBlock?, fail: failBlock?) {
        var m_header: [String: String]?
        if header == nil {
            m_header = defaultHeader(need: needToken)
            if m_header == nil {
                fail?(ErrorModel.noAuth)
                return
            }
        } else {
            m_header = header
        }
        #if DEBUG
        print("RequsetURL:\(baseURL + path)")
        #endif
        self.request(baseURL + path, method: .get, headers: m_header).response { (response) in
            let result = self.handler(response)

            if let error = result.1 {
                fail?(error)
            } else if let data = result.0 {
                guard let responseJson = try? JSON(data: data) else {
                    return fail!(ErrorModel.custom("接口返回出错"))
                }
                success?(responseJson)
            }
         }
    }

    public func getRequest(with path: String, needToken: Bool = true, header: [String: String]? = nil, successImage: successImageBlock?, fail: failBlock?) {
        var m_header: [String: String]?
        if header == nil {
            m_header = defaultHeader(need: needToken)
            if m_header == nil {
                fail?(ErrorModel.noAuth)
                return
            }
        } else {
            m_header = header
        }
        #if DEBUG
        print("RequsetURL:\(baseURL + path)")
        #endif
        self.request(baseURL + path, method: .get, headers: m_header).response { (response) in
            let result = self.handler(response)

            if let error = result.1 {
                fail?(error)
            } else if result.0 != nil {
                if let image = UIImage.init(data: response.data!) {
                    successImage?(image)
                    return
                }
                successImage?(UIImage())
            }
         }
    }

    public func upload(with path: String, needToken: Bool = true, header: [String: String]? = nil, uploadData: Data, success: successBlock?, fail: failBlock?) {
        var m_header: [String: String]?
        if header == nil {
            m_header = defaultHeader(need: needToken)
            if m_header == nil {
                fail?(ErrorModel.noAuth)
                return
            }
        } else {
            m_header = header
        }
        #if DEBUG
        print("RequsetURL:\(baseURL + path)")
        #endif
        self.upload(multipartFormData: { (multipartFormData) in

            multipartFormData.append(uploadData, withName: "file", fileName: "file.jpg", mimeType: "image/jpeg")

        }, to: baseURL + path, headers: m_header) { (encodingResult) in
            switch encodingResult {
            case .success(request: let upload, _, _):
                upload.response { (response) in
                    let result = self.handler(response)

                    if let error = result.1 {
                        fail?(error)
                    } else if let data = result.0 {
                        guard let responseJson = try? JSON(data: data) else {
                            return fail!(ErrorModel.custom("接口返回出错"))
                        }
                        success?(responseJson)
                    }
                }
            case .failure: break

            }
        }
    }

    private func defaultHeader(need auth: Bool) -> [String: String]? {
        var header = ["Content-Type": "application/json;charset=UTF-8"]
        header["api-response-handler"] = "true"
        
        if let tenantID = CurrentUser.tenantID {
            header["tenant-id"] = tenantID
        }

        if auth {
            guard let token = CurrentUser.token else {
                return nil
            }
            header["Authorization"] = "Bearer " + token

            #if DEBUG
            print("Authorization==" + "Bearer " + token)
            print("tenant-id======" + (CurrentUser.tenantID ?? ""))
            #endif
        }
        return header
    }

    func handler(_ response: DefaultDataResponse) -> (Data?, ErrorModel?) {
        var error: ErrorModel?

        if let resError = response.error {
            error = ErrorModel.custom(resError.localizedDescription)
            #if DEBUG
            print("request fail:" + resError.localizedDescription)
            #endif
        } else {
            #if DEBUG
            print("ResponseData:\(JSON(response.data!))")
            #endif
            if let code = response.response?.statusCode {
                if code > 300 {
                    if let errMessage = JSON(response.data!)["message"].string {
                        error = ErrorModel.custom(errMessage)
                    } else if code == 401 || code == 6001 {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TOKEN_ENABLED"), object: nil)
                    } else if code == 32516 {
                        error = ErrorModel.isReplay
                    } else {
                        error = ErrorModel.custom(self.getErrorDescription(by: code))
                    }
                } else { //200
                    let json = JSON(response.data!)
                    if  json["code"] == 34516 { //派工单批复专用
                        error = ErrorModel.isReplay
                    } else {
                        if let state = json["state"].bool {
                             if !state {
                                error = ErrorModel.custom(json["msg"].string ?? "未知错误")
                             }
                         }
                    }
                }
            } else {
                error = ErrorModel.custom(self.getErrorDescription(by: 500))
            }
        }
        return (response.data, error)
    }
    
    // MARK: 暂时只支持中文
    func getErrorDescription(by errorCode: Int) -> String {
        switch errorCode {
        case 400:
            return "请求无效：url出错"
        case 401, 403:
            return "鉴权出错"
        case 404:
            return "找不到指定页面"
        case 409:
            return "系统忙"
        case 500:
            return "获取数据异常（500）"
        default:
            return "未知错误"
        }
    }
}
