//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import ENetWork
import SwiftyJSON

public class ActivitySecondList: NSObject {

	public var page: Int?
	public var pageSize: Int?
	public var rows = [ActivitySecondListRow]()
	public var total: Int?

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!) {
		if json.isEmpty {
			return
		}
		page = json["page"].int
		pageSize = json["pageSize"].int

        let rowsArray = json["rows"].arrayValue
		for rowsJson in rowsArray {
			let value = ActivitySecondListRow(fromJson: rowsJson)
			rows.append(value)
		}
		total = json["total"].int
	}

}

public class ActivitySecondListRow: NSObject {

    public var status: String? //published 已发布  closed 已取消

    public var address: String?
    public var endTime: String?
    public var auditorTime: String?
    public var createdTime: String?
    public var id: String?
    public var imgUrl: String?
    public var partNum: Int?
    public var title: String?
    public var cellID: String?
    public var deadlineTime: String?
    public var imageSureArray = [PictureModel]() //图片集合
    public var isPart: Int?//0 未报名 1 已报名

   public override init() {
        super.init()
    }

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        status = json["status"].string

        deadlineTime = json["deadlineTime"].string
        isPart = json["isPart"].int
        auditorTime = json["auditorTime"].string
        createdTime = json["createdTime"].string
        address = json["address"].string
        endTime = json["endTime"].string
        id = json["id"].string
        imgUrl = json["imgUrl"].string
        partNum = json["partNum"].int
        title = json["title"].string

        let imgUrl = json["imgUrl"].stringValue
        if let jsonData = imgUrl.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    imageSureArray.append(model)
                }
            }
        }

    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if address != nil {
            dictionary["address"] = address
        }
        if endTime != nil {
            dictionary["endTime"] = endTime
        }
        if id != nil {
            dictionary["id"] = id
        }
        if imgUrl != nil {
            dictionary["imgUrl"] = imgUrl
        }
        if partNum != nil {
            dictionary["partNum"] = partNum
        }
        if title != nil {
            dictionary["title"] = title
        }
        return dictionary
    }

}
