//
//	Row.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

public class ActivityLisrtData: NSObject {

    public var page: Int?
    public var pageSize: Int?
    public var rows = [ActivityLisrtRows]()
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
            let value = ActivityLisrtRows(fromJson: rowsJson)
            rows.append(value)
        }
        total = json["total"].int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if page != nil {
            dictionary["page"] = page
        }
        if pageSize != nil {
            dictionary["pageSize"] = pageSize
        }
        var dictionaryElements = [[String: Any]]()
        for rowsElement in rows {
            dictionaryElements.append(rowsElement.toDictionary())
        }
        dictionary["rows"] = dictionaryElements

        if total != nil {
            dictionary["total"] = total
        }
        return dictionary
    }

}

public class ActivityLisrtRows: NSObject {

	public var releaseTime: String?
	public var id: String?
	public var title: String?
	public var type: String?// 紧急:urgent/通知:notice/提示:tips/重要:important/简报:Briefing/其他:other

    public var compareTime: String?
    public var cellID: String?
    public var isShowYear: Bool?
    public var year: String?

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
		releaseTime = json["releaseTime"].string
		id = json["id"].string
		title = json["title"].string
		type = json["type"].string
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String: Any] {
		var dictionary = [String: Any]()
		if releaseTime != nil {
			dictionary["releaseTime"] = releaseTime
		}
		if id != nil {
			dictionary["id"] = id
		}
		if title != nil {
			dictionary["title"] = title
		}
		if type != nil {
			dictionary["type"] = type
		}
		return dictionary
	}

}
