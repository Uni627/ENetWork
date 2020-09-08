//
//  ActivityAPI.swift
//  EServices
//
//  Created by apple on 2020/4/15.
//  Copyright © 2020 uni. All rights reserved.
//

import SwiftyJSON
import ENetWork

public class ActivityAPI: NSObject {

    public static let shared = ActivityAPI()

    ///公告列表
    public func listForCApp(type: Int = 0, orgCodes: [String], chooseTime: String? = nil, pageBean: PageBean, success: @escaping ((ActivityLisrtData) -> Void), fail: @escaping (ErrorModel) -> Void) {

        var params = self.pageBeanParameter(pageBean)

        var querysList: [Any] = []
        let dic = self.queryParameters(property: "org_id", operation: "IN", value: orgCodes, relation: "AND")
        querysList.append(dic)

        if type == 1 { //重要
            let dic1 = self.queryParameters(property: "is_important", operation: "IN", value: "1", relation: "AND")

            let current = timeStamp()
            let endtime = timeStampToString(timeStamp: current)
            let dic2 = self.queryParameters(property: "end_time", operation: "GREAT", value: endtime, relation: "AND")

            querysList.append(dic1)
            querysList.append(dic2)
        }

        if type == 0 {
            if let chooseTime = chooseTime {
                //创建一个日期格式器
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let array = chooseTime.components(separatedBy: "-")
                //当月第一天日期
                if let start = array.first, let end = array.last {
                    if let a = Int(start), let b = Int(end) {
                        let startDate = startOfMonth(year: a, month: b)
                        let endDate1 = endOfMonth(year: a, month: b)

                        let dic1 = self.queryParameters(property: "release_time", operation: "GREAT", value: dateFormatter.string(from: startDate), relation: "AND")
                        let dic2 = self.queryParameters(property: "release_time", operation: "LESS", value: dateFormatter.string(from: endDate1), relation: "AND")
                        querysList.append(dic1)
                        querysList.append(dic2)
                    }
                }
            }
        }
        params["querys"] = querysList
        
        BMSServices.shared.postRequest(with: "/noticeAndActivite/api/Announcement/v1/communityAnnouncement/listForBApp", parameters: params, success: { (json) in

            let container = ActivityLisrtData(fromJson: json["data"])
            success(container)

        }, fail: {error in
            fail(error)
        })

    }

    ///活动列表
    public func queryListForApp(pageBean: PageBean, success: @escaping ((ActivitySecondList) -> Void), fail: @escaping (ErrorModel) -> Void) {

        var params = self.pageBeanParameter(pageBean)

        var querysList: [Any] = []
        let dic = self.queryParameters(property: "org_id", operation: "IN", value: "CurrentUser.divideId", relation: "AND")
        let dic1 = self.queryParameters(property: "memberId", operation: "IN", value: CurrentUser.userID ?? "", relation: "AND")
        querysList.append(dic)
        querysList.append(dic1)

        params["querys"] = querysList

        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/queryListForApp", parameters: params, success: { (json) in

            let container = ActivitySecondList(fromJson: json["data"])
            success(container)

        }, fail: {error in
            fail(error)
        })
    }

    ///我的活动列表
    public func queryMyActivityList(pageBean: PageBean, success: @escaping ((ActivitySecondList) -> Void), fail: @escaping (ErrorModel) -> Void) {

        var params = self.pageBeanParameter(pageBean)

        var querysList: [Any] = []
        let dic = self.queryParameters(property: "member_id", operation: "IN", value: CurrentUser.userID ?? "", relation: "AND")
        querysList.append(dic)

        params["querys"] = querysList

        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/queryMyActivityList", parameters: params, success: { (json) in

            let container = ActivitySecondList(fromJson: json["data"])
            success(container)

        }, fail: {error in
            fail(error)
        })

    }

    ///添加报名人
    public func activityRegistration(models: [ActivityPeople], success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        var applicantList = [Any]()
        for item in models {
            applicantList.append(item.toDictionary())
        }
        let params = ["applicantList": applicantList]
        
        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/activityRegistration", parameters: params, success: { (json) in

            if json["data"]["state"].boolValue {
                success(json["data"]["state"].stringValue)
            }
        }, fail: {error in
            fail(error)
        })

    }

    ///查看活动是否已经参与
    public func queryIsPart(activityId: String, success: @escaping ((Bool) -> Void), fail: @escaping (ErrorModel) -> Void) {

        var params = ["": ""]
        params["memberId"] = CurrentUser.userID
        params["activityId"] = activityId

        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/queryIsPart", parameters: params, success: { (json) in

            success(json["data"]["state"].boolValue)

        }, fail: {error in
            fail(error)
        })

    }

    //通用传值字典
    private func queryParameters(property: String, operation: String, value: Any, relation: String) -> [String: Any] {
        let query = ["property": property,
                     "operation": operation,
                     "value": value,
                     "relation": relation]
        return query
    }

    //页码字典 有pageBean 字段
    private func pageBeanParameter(_ page: PageBean) -> [String: Any] {
        let bean = ["pageSize": page.size, "page": page.page, "showTotal": page.showAll ? 1 : 0]
        return ["pageBean": bean]
    }

    ///公告详情
    public func gainNoticeDetial(id: String, success: @escaping ((NoticeDetialModel) -> Void), fail: @escaping (ErrorModel) -> Void) {

        BMSServices.shared.getRequest(with: "/noticeAndActivite/api/Announcement/v1/communityAnnouncement/get/\(id)", success: { (json) in
            if json["state"].boolValue {
                let model = NoticeDetialModel(fromJson: json["data"])
                success(model)
            } else {
                fail(ErrorModel.custom("加载失败"))
            }
        }, fail: {error in
            fail(error)
        })
    }

    ///点赞或差评
    public func GoodAndBadForNotice(params: [String: Any], success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        BMSServices.shared.postRequest(with: "/noticeAndActivite/api/Announcement/v1/communityAnnouncement/updateByMemberId", parameters: params, success: { (json) in
            if json["state"].boolValue {
                success(json["msg"].stringValue)
            }
        }, fail: {error in
            fail(error)
        })

    }

    ///公告新增阅读量
    public func readNumber(params: [String: Any], success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        BMSServices.shared.postRequest(with: "/noticeAndActivite/api/Announcement/v1/communityAnnouncement/addReading", parameters: params, success: { (_) in

        }, fail: {_ in

        })
    }

    ///判断公告是否点赞或者差评
    public func gainNoticeIsGood(params: [String: Any], success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        BMSServices.shared.postRequest(with: "/noticeAndActivite/api/Announcement/v1/communityAnnouncement/queryThumbUpDownByCondition", parameters: params, success: { (json) in
            if json["state"].boolValue {
                success(json["data"].stringValue)
            }
        }, fail: {error in
            fail(error)
        })
    }

    ///活动详情
    public func gainActivityDetial(id: String, success: @escaping ((ActivityDetial) -> Void), fail: @escaping (ErrorModel) -> Void) {
        BMSServices.shared.getRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/getForApp/\(id)", success: { (json) in
            if json["state"].boolValue {
                let model = ActivityDetial(fromJson: json["data"])
                success(model)
            } else {
                fail(ErrorModel.custom("加载失败"))
            }
        }, fail: {error in
            fail(error)
        })
    }

    ///活动新增阅读量
    public func readNumberActivity(params: [String: Any], success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/addReading", parameters: params, success: { (json) in
            if json["state"].boolValue {
                success(json["data"]["message"].stringValue)
            }
        }, fail: {error in
            fail(error)
        })
    }

    ///线上分享
    public func onlineShare(params: [String: Any], success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/updateActivityEnroll", parameters: params, success: { (json) in
            if json["state"].boolValue {
                if json["data"]["state"].boolValue {
                    success(json["data"]["message"].stringValue)
                }
            } else {
                fail(ErrorModel.custom("发布失败"))
            }
        }, fail: {error in
            fail(error)
        })
    }

    ///获取活动是否报名 0 未参与  否则 已参与    
    public func gainIsenter(params: [String: Any], success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/queryIsPart", parameters: params, success: { (json) in
            if json["state"].boolValue {
                if json["data"]["state"].boolValue {
                    success(json["data"]["value"].stringValue)
                }
            }
        }, fail: {error in
            fail(error)
        })
    }

    ///首页活动列表
    public func listForHomePage(pageBean: PageBean, success: @escaping (([ActivitySecondListRow]) -> Void), fail: @escaping (ErrorModel) -> Void) {

        var params = self.pageBeanParameter(pageBean)

        var querysList: [Any] = []
        let dic = self.queryParameters(property: "org_id", operation: "IN", value: "CurrentUser.divideId", relation: "AND")
        let dic1 = self.queryParameters(property: "memberId", operation: "IN", value: CurrentUser.userID ?? "", relation: "AND")
        querysList.append(dic1)
        querysList.append(dic)

        params["querys"] = querysList

        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/listForHomePage", parameters: params, success: { (json) in

            let array = json["data"]["value"].arrayValue

            var dataArray: [ActivitySecondListRow] = []

            for unit in array {
                let model = ActivitySecondListRow(fromJson: unit)
                dataArray.append(model)
            }
            success(dataArray)
        }, fail: {error in
            fail(error)
        })
    }

    ///查看当前活动详情点赞状态 0-未评价 1-好评 2-差评
    public func gainActivityDetailIsGood(activityId: String, success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {
        var params: [String: Any] = [:]
        params["activityId"] = activityId
        params["memberId"] = CurrentUser.userID

        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/queryThumbUpDownByCondition", parameters: params, success: { (json) in
            if json["data"]["state"].boolValue {
                success(json["data"]["value"].stringValue)
            }
        }, fail: {error in
            fail(error)
        })
    }

    ///点赞或差评
    public func GoodAndBadForActivity(params: [String: Any], success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {

        BMSServices.shared.postRequest(with: "/member/noticeAndActivite/api/noticeAndActivite/v1/communityActivity/updateByMemberId", parameters: params, success: { (json) in
            if json["state"].boolValue {
                success(json["msg"].stringValue)
            }
        }, fail: {error in
            fail(error)
        })
    }

    /// 时间戳转时间
    /// - Parameter timeStamp: 时间戳
    func timeStampToString(timeStamp: Int, outputFormatter: String? = "yyyy-MM-dd HH:mm:ss") -> String {

        let timeString = String(timeStamp)
        let timeSta: TimeInterval
        if timeString.count == 10 {
            timeSta = TimeInterval(timeStamp)
        } else {
            timeSta = TimeInterval(timeStamp / 1000)
        }
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmateer = DateFormatter()
        dfmateer.dateFormat = outputFormatter
        return dfmateer.string(from: date as Date)
    }

    /// 获取当前时间戳
    func timeStamp() -> Int {
        let now = NSDate()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }

    //指定年月的开始日期
    func startOfMonth(year: Int, month: Int) -> Date {
        let calendar = NSCalendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps)!
        return startDate
    }

    //指定年月的结束日期
    func endOfMonth(year: Int, month: Int, returnEndTime: Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }

        let endOfYear = calendar.date(byAdding: components,
                                      to: startOfMonth(year: year, month: month))!
        return endOfYear
    }

    ///系统公告
    public func gainSystemNotice(success: @escaping (([NoticeDetialModel]) -> Void), fail: @escaping (ErrorModel) -> Void) {
        let params: [String: Any] = [:]
        BMSServices.shared.postRequest(with: "/noticeAndActivite/api/noticeAndActivity/v1/platformNotification/queryListForBAPP", parameters: params, success: { (json) in
            var dataArray: [NoticeDetialModel] = []
            for unit in json["data"]["rows"].arrayValue {
                let model = NoticeDetialModel(fromJson: unit)
                dataArray.append(model)
            }
            success(dataArray)
        }, fail: {error in
            fail(error)
        })
    }

    ///系统公告详情
    public func gainSystemNoticeDetial(id: String, success: @escaping ((NoticeDetialModel) -> Void), fail: @escaping (ErrorModel) -> Void) {
        BMSServices.shared.getRequest(with: "/noticeAndActivite/api/noticeAndActivity/v1/platformNotification/get/\(id)", success: { (json) in
            if json["state"].boolValue {
                let model = NoticeDetialModel(fromJson: json["data"])
                success(model)
            } else {
                fail(ErrorModel.custom("加载失败"))
            }
        }, fail: {error in
            fail(error)
        })
    }

}
