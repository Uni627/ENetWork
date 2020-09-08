//
//  UserAPI.swift
//  EServices
//
//  Created by pxy on 2019/11/7.
//


public class UserAPI: EBaseAPI {
    public static let shared = UserAPI()

    // MARK: - - 查看用户上下班状态
    ///Bool 返回 true 是工作中 ，false 是下班状态
    public func getUserHisStatus(success: @escaping ((Bool) -> Void), fail: @escaping (ErrorModel) -> Void) {
        AuthClient.shared.getRequest(with: "/user-center/api/usercenter/v1/ucWorkHistory/getUserHisStatus?userId=\(CurrentUser.userID ?? "")", success: { (json) in
            if let isSuccess = json["state"].bool {
                if json["data"].string == "0" {
                    success(isSuccess)
                } else {
                    success(false)
                }
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }) { (error) in
            fail(error)
        }
    }

    ///更新上下班状态
    ///status 传 status 0是工作中，传 1是下班
    ///Bool 返回 true 是工作中 ，false 是下班状态
    public func updateUserHisStatus(status: String, success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {

        UserService.shared.getRequest(with: "/user-center/api/usercenter/v1/ucWorkHistory/save?userId=\(CurrentUser.userID ?? "")&account=\(CurrentUser.username ?? "")&status=\(status)", success: { (json) in
            if let isSuccess = json["state"].bool {
                if json["data"].string == "0" {
                    success(isSuccess)
                } else {
                    success(false)
                }
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }

    ///获取个人信息
    public func getUserData(success: @escaping ((PersonalModel) -> Void), fail: @escaping (ErrorModel) -> Void) {

        UserService.shared.getRequest(with: "/uc/api/user/v1/user/getUser?account=\(CurrentUser.username ?? "")", success: { (json) in

            let user = PersonalModel(fromJson: json["data"])
            success(user)

        }) { (error) in
            fail(error)
        }
    }

    ///获取个人信息详情
    public func getUserDetail(devideId: String, success: @escaping ((UserDetailModel) -> Void), fail: @escaping (ErrorModel) -> Void) {

        UserService.shared.postRequest(with: "/user-center/api/usercenter/v1/ucUser/userDetails", parameters: ["devideId": devideId, "userId": CurrentUser.userID ?? ""], success: { (json) in

            let user = UserDetailModel(fromJson: json["data"])
            success(user)

        }) { (error) in
            fail(error)
        }
    }

    //TODO: 获取签名接口
    ///返回签名数据
    public func getByUserId(success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {

        BMSServices.shared.getRequest(with: "/appcenter/api/appcenter/v1/userSloganRef/newGetByUserId/\(CurrentUser.userID ?? "")", success: { (json) in

            if let _ = json["state"].bool {
                success(json["data"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }) { (error) in
            fail(error)
        }
    }

    ///更新个人信息
    public func updateUserMessage(personalModel: PersonalModel, success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        UserService.shared.putRequest(with: "/uc/api/user/v1/user/updateUser", parameters: personalModel.toDictionary(), success: { (json) in

            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                 fail(ErrorModel.custom("获取数据异常"))
            }
        }) { (error) in
            fail(error)
        }
    }

    ///查询是否有夜间推送状态
    public func getUserConfig(success: @escaping ((UserConfigModel) -> Void), fail: @escaping (ErrorModel) -> Void) {

        UserService.shared.getRequest(with: "/user-center/api/UcUserConfig/v1/ucUserConfig/get/\(CurrentUser.userID ?? "")", success: { (json) in

            if let config = UserConfigModel(fromJson: json["data"]) {
                success(config)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }) { (error) in
            fail(error)
        }
    }

    ///新增 用户夜间配置
    ///返回添加成功
    public func addUserConfig(success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        UserService.shared.postRequest(with: "/user-center/api/UcUserConfig/v1/ucUserConfig/add", parameters: ["userId": CurrentUser.userID ?? "", "isNightPattern": "0", "isDel": "1", "createBy": CurrentUser.userID ?? ""], success: { (json) in

            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                 fail(ErrorModel.custom("获取数据异常"))
            }
        }) { (error) in
            fail(error)
        }
    }

    ///更新用户夜间配置数据
    public func updateUserConfig(userCofig: UserConfigModel, success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        UserService.shared.putRequest(with: "/user-center/api/UcUserConfig/v1/ucUserConfig/update", parameters: userCofig.toDictionary(), success: { (json) in

            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                 fail(ErrorModel.custom("获取数据异常"))
            }
        }) { (error) in
            fail(error)
        }
    }

    ///意见反馈
    public func addFeedBack(content: String, issueType: String, personalModel: PersonalModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {

        let param: [String: Any] = ["feedbackId": personalModel.id ?? "",
                                     "feedbackName": personalModel.fullname ?? "",
                                     "feedbackAccount": personalModel.account ?? "",
                                     "feedbackPhone": personalModel.mobile ?? "",
                                     "content": content,
                                     "issueType": issueType]

        BMSServices.shared.postRequest(with: "/appcenter/api/appcenter/v1/feedback/add", parameters: param, success: { (json) in

            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                 fail(ErrorModel.custom("获取数据异常"))
            }
        }) { (error) in
            fail(error)
        }
    }

    ///提交签名
    public func submitSlogan(userId: String, slogan: String, success:@escaping (() -> Void), fail:@escaping (ErrorModel) -> Void) {

        BMSServices.shared.postRequest(with: "/appcenter/api/appcenter/v1/userSloganRef/addOrUpdateSlogan", parameters: ["userId": userId, "slogan": slogan], success: { (json) in

            if let _ = json["state"].bool {
                success()
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }

    ///查询用户默认分期
    public func searchDefaultDivide(userId: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {

        BMSServices.shared.getRequest(with: "/uc/api/org/v1/getCurrentOrg/\(userId)", success: { (json) in

            if let divideID = json["data"].string {
                success(divideID)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    public func getUserAuthOrg(userId: String, success:@escaping (([SendAddressListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        BMSServices.shared.getRequest(with: "uc/api/org/v1/org/getUserAuthOrg?userId=\(userId)&isTree=1&demCode=", success: { (json) in

            var resumes: [SendAddressListModel] = []
            if let values = json["data"].array {
                for row in values {
                    let resume = SendAddressListModel(fromJson: row)
                    resumes.append(resume)
                }
            }
            success(resumes)

        }, fail: { (error) in
            fail(error)
        })
    }
    //============= 意见反馈 ===============
    ///新增意见反馈
    public func feedBackAdd(params: [String: Any], success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        BMSServices.shared.postRequest(with: "/appcenter/api/appcenter/v1/feedback/addForApp", parameters: params, success: { (json) in
            if json["state"].boolValue {
                success(json["msg"].stringValue)
            }
        }, fail: {error in
            fail(error)
        })
    }

    ///意见反馈列表
    public func feedBackList(params: [String: Any], success:@escaping (([FeedBackModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var params: [String: Any] = [:]
        var a: [[String: Any]] = []

        var defaultDict = [String: Any]()
        defaultDict["property"] = "feedback_id"
        defaultDict["value"] = CurrentUser.userID
        defaultDict["operation"] = "IN"
        defaultDict["relation"] = "AND"
        a.append(defaultDict)

        params["querys"] = a

        BMSServices.shared.postRequest(with: "/appcenter/api/appcenter/v1/feedback/listForApp", parameters: params, success: { (json) in
            var array: [FeedBackModel] = []

            if json["state"].boolValue {
                let rows = json["data"]["rows"].arrayValue
                for row in rows {
                    if let model = FeedBackModel(fromJson: row) {
                        array.append(model)
                    }
                }
            }
            success(array)
        }, fail: {error in
            fail(error)
        })
    }

    ///意见反馈详情
    public func feedBackDetial(id: String, success:@escaping ((FeedBackModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        BMSServices.shared.getRequest(with: "/appcenter/api/appcenter/v1/feedback/getForApp/\(id)", success: { (json) in
            if json["state"].boolValue {
                if let model = FeedBackModel(fromJson: json["data"]) {
                    success(model)
                }
            }
        }, fail: {error in
            fail(error)
        })
    }
    
    ///图片张数接口
    public func getPicturesCount(success: @escaping (([PictureCountModel]) -> Void), fail: @escaping (ErrorModel) -> Void) {
        let pageBean = ["pageSize": 9999, "page": 1, "showTotal": 1]
        BMSServices.shared.postRequest(with: "/portal/sys/sysProperties/v1/listJson", parameters: ["pageBean": pageBean], success: { (json) in
            
            if json["state"].boolValue == true {
                var resumes: [PictureCountModel] = []
                if let values = json["data"]["rows"].array {
                    for row in values {
                        let model = PictureCountModel(fromJson: row)
                        resumes.append(model)
                    }
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom(json["msg"].stringValue))
            }
        }, fail: {error in
            fail(error)
        })
    }
    
}
