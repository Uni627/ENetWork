//
//  OrderInfo.swift
//  EServices
//
//  Created by pxy on 2019/11/8.
//

import Foundation
import SwiftyJSON

public class OrderInfo: NSObject {

    public var checkDate: String? //验收日期
    public var createTime: String? //工单创建时间
    public var deadlineTime: String? //完成截止时间
    public var type: String?  //工单类型 （一级）
    public var typeName: String?  //工单名称 （一级）
    public var envirmentType2Code: String?
    public var envirmentType2Name: String?
    public var envirmentType3Code: String?
    public var envirmentType3Name: String?
    public var executorName: String?
    public var originalCode: String?
    public var originalID: String?
    public var originalType: String?
    public var procDate: String? //处理时间
    public var score: String?
    public var actFinishTime: String? //实际完成时间
    public var aftPic: String? //处理后照片
    public var befPic: String? //处理前照片
    public var checkContent: String? //验收意见
    public var checkID: String? //验收人id
    public var checkName: String? //验收人名称
    public var checkResult: String? //验收结果
    public var close: String?
    public var desc: String? //问题描述
    public var divideID: String? //分期id
    public var divideName: String? //分期名称
    public var evaluation: String? //评价
    public var extStatus: Int? //是否延期
    public var hangStatus: Int? //是否挂起
    public var location: String? //位置
    public var orderNo: String? //工单编号
    public var otLevel: Int?  //超时级别 1:普通,2:一般,3:严重
    public var otStatus: Int? ////是否超时 1超时 0未超时
    public var procContent: String? //处理内容
    public var procID: String?  //处理人id
    public var procName: String?  //处理人名称
    public var projectID: String? //项目id
    public var projectName: String? //项目名
    public var resID: String? //资源id
    public var resName: String? //资源名称
    public var returnReason: String? //退回原因
    public var status: String? //1:待响应，2:处理中，3:验收中，4:已完成
    public var titID: String? //岗位id
    public var titName: String? //岗位名称
    public var txCode: String? //条线Code
    public var txID: String? //条线id
    public var txName: String? ////条线名称
    public var ID: String? //工单id
    public var pgdAttachment: String? //创建派工单时的图片
    public var refID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        actFinishTime = json["factFinishTime"].string
        checkDate = json["fcheckDate"].string

        envirmentType2Code = json["fEnvirmentType2Code"].string
        envirmentType2Name = json["fEnvirmentType2Name"].string
        envirmentType3Code = json["fEnvirmentType3Code"].string
        envirmentType3Name = json["fEnvirmentType3Name"].string
        executorName = json["fExecutorName"].string
        originalCode = json["fOriginalCode"].string
        originalID = json["fOriginalId"].string
        originalType = json["fOriginalType"].string
        procDate = json["fProcDate"].string
        score = json["fScore"].string
        aftPic = json["faftPic"].string
        befPic = json["fbefPic"].string
        checkContent = json["fcheckContent"].string
        checkID = json["fcheckId"].string
        checkName = json["fcheckName"].string
        checkResult = json["fcheckResult"].string
        close = json["fclose"].string
        createTime = json["fCreateTime"].string
        deadlineTime = json["fdeadlineTime"].string
        desc = json["fdesc"].string
        divideID = json["fdivideId"].string
        divideName = json["fdivideName"].string
        evaluation = json["fevaluation"].string
        extStatus = json["fextStatus"].int
        hangStatus = json["fhangStatus"].int
        location = json["flocation"].string
        orderNo = json["forderNo"].string
        otLevel = json["fotLevel"].int
        otStatus = json["fotStatus"].int
        procContent = json["fprocContent"].string
        procDate = json["fprocDate"].string
        procID = json["fprocId"].string
        procName = json["fprocName"].string
        projectID = json["fprojectId"].string
        projectName = json["fprojectName"].string
        resID = json["fresId"].string
        resName = json["fresName"].string
        returnReason = json["freturnReason"].string
        status = json["fstatus"].string
        titID = json["ftitId"].string
        titName = json["ftitName"].string
        txCode = json["ftxCode"].string
        txID = json["ftxId"].string
        txName = json["ftxName"].string
        type = json["ftype"].string
        typeName = json["ftypeName"].string
        ID = json["id"].string
        pgdAttachment = json["pgdAttachment"].string
        refID = json["refId"].string
    }
}
