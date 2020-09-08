//
//  PersonalAPI.swift
//  EServices
//
//  Created by pxy on 2020/3/10.
//  Copyright © 2020 EinYun. All rights reserved.
//

import SwiftyJSON
import EUtils

public class PersonalAPI: NSObject {
    public static let shared = PersonalAPI()

    /// 获取消息列表
    /// - Parameters:
    ///   - pageBean: 页数
    ///   - success:
    ///   - fail:
    public func getMessageList(pageBean: PageBean, success:@escaping (([MessageListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic = [String: Any]()
        let param = pageParameter(pageBean, showBool: true)
        dic["pageBean"] = param

        PersonalServices.shared.postRequest(with: "/portal/innermsg/messageReceiver/v1/list", parameters: dic, success: { (json) in

            var list = [MessageListModel]()
            if let jsonArray = json["data"]["rows"].array {
                for subJson in jsonArray {
                    let model = MessageListModel(fromJson: subJson)
                    list.append(model)
                }
            }
            success(list)

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 返回用户是否有未读消息
    /// - Parameters:
    ///   - success:
    ///   - fail:
    public func getIsReadMessage(success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {
        PersonalServices.shared.getRequest(with: "/portal/innermsg/messageReceiver/v1/getIsReadMsg", success: { (json) in

            if let isRead = json["data"]["msgFlag"].bool {
                success(isRead)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 更新消息状态接口-未读到已读
    /// - Parameters:
    ///   - messageID: 消息ID
    ///   - success:
    ///   - fail:
    public func changeMessageStatus(messageID: String, success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {
        PersonalServices.shared.getRequest(with: "/portal/innermsg/messageReceiver/v1/get?id=\(messageID)", success: { (json) in

            if let isRead = json["state"].bool {
                success(isRead)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 标记用户消息全部已读接口
    /// - Parameters:
    ///   - success:
    ///   - fail:
    public func signMessagesRead(success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {
        PersonalServices.shared.getRequest(with: "/portal/innermsg/messageReceiver/v1/signAllReadMsg", success: { (json) in

            if let isRead = json["state"].bool {
                success(isRead)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }
    
    
    /// 判断报修抢单状态
    /// - Parameters:
    ///   - taskID: 任务ID
    ///   - success:
    ///   - fail:
    public func getRepairGrabStatus(taskID: String, success: @escaping ((Bool) -> Void), fail: @escaping (ErrorModel) -> Void) {
        PersonalServices.shared.getRequest(with: "/bpm-runtime/runtime/task/v1/taskDetailMini?taskId=\(taskID)&reqParams=", success: { (json) in

            if let isRead = json["state"].bool {
                success(isRead)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }
    
    
    /// 消息中心判断是否可处理
    /// - Parameters:
    ///   - taskID: 任务ID
    ///   - success:
    ///   - fail:
    public func getMsgAction(taskID: String, success: @escaping ((MessageOrderModel) -> Void), fail: @escaping (ErrorModel) -> Void) {
        PersonalServices.shared.getRequest(with: "/workOrder/workOrder/task/v1/getMsgAction?taskId=\(taskID)", success: { (json) in

            if let _ = json["state"].bool {
                let model = MessageOrderModel(fromJson: json["data"])
                success(model)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }
    
    
    public func modifyPassword(oldPassword: String, newPassword: String, success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {
        PersonalServices.shared.postRequest(with: "/uc/api/user/v1/user/changUserPsd", parameters: ["account": CurrentUser.userID ?? "","oldPwd": oldPassword, "newPwd": newPassword], success: { (json) in
            if let _ = json["state"].bool {
                let msg = json["data"]["msg"].stringValue
                success(msg)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
}
