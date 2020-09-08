//  创建工单-派工单- 资源分类
//	SendOrderResourceClassification.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

public class SendOrderResourceClassificationModel: NSObject {

    public var children: [SendOrderResourceClassificationChildren]?
    public var id: String?
    public var name: String?
    public var typeKey: String?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        children = [SendOrderResourceClassificationChildren]()
        let childrenArray = json["children"].arrayValue
        for childrenJson in childrenArray {
            let value = SendOrderResourceClassificationChildren(fromJson: childrenJson)
            children?.append(value)
        }
        id = json["id"].string
        name = json["name"].string
        typeKey = json["typeKey"].string
    }

    public override init() {
        super.init()
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if children != nil {
            var dictionaryElements = [[String: Any]]()
            for childrenElement in children! {
                dictionaryElements.append(childrenElement.toDictionary())
            }
            dictionary["children"] = dictionaryElements
        }
        if id != nil {
            dictionary["id"] = id
        }
        if name != nil {
            dictionary["name"] = name
        }
        if typeKey != nil {
            dictionary["typeKey"] = typeKey
        }
        return dictionary
    }
}

public class SendOrderResourceClassificationChildren: NSObject {

    public var basicBrand: AnyObject? //品牌
    public var basicCanopyDiameter: AnyObject? //P蓬径(cm) – key
    public var basicDbh: AnyObject? //φ胸径(cm)-key
    public var basicHeightRange: AnyObject? //H高度(cm)-key
    public var basicImportanceDegree: AnyObject? //重要度
    public var basicMeasurementUnit: AnyObject? //计量单位 - key
    public var basicNumber: AnyObject? //数量
    public var basicRemark: AnyObject? //备注
    public var basicSpecificationType: AnyObject? //规格型号
    public var buildingFloor: AnyObject? //楼栋-楼层
    public var buildingName: AnyObject? //楼栋名称
    public var buildingNumber: AnyObject? //楼栋-楼栋号
    public var buildingUnitNumber: AnyObject? //楼栋-单元号
    public var createdBy: AnyObject?
    public var creationDate: AnyObject? //创建时间
    public var enabledFlag: AnyObject?

    public var isDeleted: AnyObject?
    public var massifID: AnyObject? //分期id
    public var propertyAttribute: AnyObject? //产权属性
    public var purpose: AnyObject? //用途
    public var purposeType: AnyObject? //用途类型

    public var resourceClassificationPath: AnyObject?

    public var resourceLocationType: AnyObject? //位置类型-key

    public var resourceNameKey: AnyObject? //资源KEY
    public var resourceProfessional: AnyObject? //工程专业-key
    public var resourceSequentialCode: AnyObject? //顺序码
    public var resourceStatus: AnyObject? //资源状态
    public var resourceType: AnyObject?
    public var rowTime: AnyObject? //创建时间
    public var rowVersion: AnyObject?
    public var spaceName: AnyObject? //空间名称-key
    public var spaceType: AnyObject? //空间类型-key

    public var tenantID: AnyObject?
    public var unitName: AnyObject? //单元名称
    public var updatedBy: AnyObject?
    public var updationDate: AnyObject?

    public var ID: String?
    public var resourceName: String? //资源名称
    public var specificLocation: String? //具体位置
    public var resourceCode: String? //资源编码
    public var resourceClassification: String? //资源分类ID

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        basicBrand = json["basicBrand"].string as AnyObject?
        basicCanopyDiameter = json["basicCanopyDiameter"].string as AnyObject?
        basicDbh = json["basicDbh"].string as AnyObject?
        basicHeightRange = json["basicHeightRange"].string as AnyObject?
        basicImportanceDegree = json["basicImportanceDegree"].string as AnyObject?
        basicMeasurementUnit = json["basicMeasurementUnit"].string as AnyObject?
        basicNumber = json["basicNumber"].string as AnyObject?
        basicRemark = json["basicRemark"].string as AnyObject?
        basicSpecificationType = json["basicSpecificationType"].string as AnyObject?
        buildingFloor = json["buildingFloor"].string as AnyObject?
        buildingName = json["buildingName"].string as AnyObject?
        buildingNumber = json["buildingNumber"].string as AnyObject?
        buildingUnitNumber = json["buildingUnitNumber"].string as AnyObject?
        createdBy = json["createdBy"].string as AnyObject?
        creationDate = json["creationDate"].string as AnyObject?
        enabledFlag = json["enabledFlag"].string as AnyObject?

        isDeleted = json["isDeleted"].string as AnyObject?
        massifID = json["massifId"].string as AnyObject?
        propertyAttribute = json["propertyAttribute"].string as AnyObject?
        purpose = json["purpose"].string as AnyObject?
        purposeType = json["purposeType"].string as AnyObject?

        resourceClassificationPath = json["resourceClassificationPath"].string as AnyObject?

        resourceLocationType = json["resourceLocationType"].string as AnyObject?

        resourceNameKey = json["resourceNameKey"].string as AnyObject?
        resourceProfessional = json["resourceProfessional"].string as AnyObject?
        resourceSequentialCode = json["resourceSequentialCode"].string as AnyObject?
        resourceStatus = json["resourceStatus"].string as AnyObject?
        resourceType = json["resourceType"].string as AnyObject?
        rowTime = json["rowTime"].string as AnyObject?
        rowVersion = json["rowVersion"].string as AnyObject?
        spaceName = json["spaceName"].string as AnyObject?
        spaceType = json["spaceType"].string as AnyObject?

        tenantID = json["tenantId"].string as AnyObject?
        unitName = json["unitName"].string as AnyObject?
        updatedBy = json["updatedBy"].string as AnyObject?
        updationDate = json["updationDate"].string as AnyObject?

        ID = json["id"].string
        resourceName = json["resourceName"].string
        specificLocation = json["specificLocation"].string
        resourceCode = json["resourceCode"].string
        resourceClassification = json["resourceClassification"].string
    }

    public override init() {
        super.init()
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if basicBrand != nil {
            dictionary["basicBrand"] = basicBrand
        }
        if basicCanopyDiameter != nil {
            dictionary["basicCanopyDiameter"] = basicCanopyDiameter
        }
        if basicDbh != nil {
            dictionary["basicDbh"] = basicDbh
        }
        if basicHeightRange != nil {
            dictionary["basicHeightRange"] = basicHeightRange
        }
        if basicImportanceDegree != nil {
            dictionary["basicImportanceDegree"] = basicImportanceDegree
        }
        if basicMeasurementUnit != nil {
            dictionary["basicMeasurementUnit"] = basicMeasurementUnit
        }
        if basicNumber != nil {
            dictionary["basicNumber"] = basicNumber
        }
        if basicRemark != nil {
            dictionary["basicRemark"] = basicRemark
        }
        if basicSpecificationType != nil {
            dictionary["basicSpecificationType"] = basicSpecificationType
        }
        if buildingFloor != nil {
            dictionary["buildingFloor"] = buildingFloor
        }
        if buildingName != nil {
            dictionary["buildingName"] = buildingName
        }
        if buildingNumber != nil {
            dictionary["buildingNumber"] = buildingNumber
        }
        if buildingUnitNumber != nil {
            dictionary["buildingUnitNumber"] = buildingUnitNumber
        }
        if createdBy != nil {
            dictionary["createdBy"] = createdBy
        }
        if creationDate != nil {
            dictionary["creationDate"] = creationDate
        }
        if enabledFlag != nil {
            dictionary["enabledFlag"] = enabledFlag
        }
        if ID != nil {
            dictionary["id"] = ID
        }
        if isDeleted != nil {
            dictionary["isDeleted"] = isDeleted
        }
        if massifID != nil {
            dictionary["massifId"] = massifID
        }
        if propertyAttribute != nil {
            dictionary["propertyAttribute"] = propertyAttribute
        }
        if purpose != nil {
            dictionary["purpose"] = purpose
        }
        if purposeType != nil {
            dictionary["purposeType"] = purposeType
        }
        if resourceClassification != nil {
            dictionary["resourceClassification"] = resourceClassification
        }
        if resourceClassificationPath != nil {
            dictionary["resourceClassificationPath"] = resourceClassificationPath
        }
        if resourceCode != nil {
            dictionary["resourceCode"] = resourceCode
        }
        if resourceLocationType != nil {
            dictionary["resourceLocationType"] = resourceLocationType
        }
        if resourceName != nil {
            dictionary["resourceName"] = resourceName
        }
        if resourceNameKey != nil {
            dictionary["resourceNameKey"] = resourceNameKey
        }
        if resourceProfessional != nil {
            dictionary["resourceProfessional"] = resourceProfessional
        }
        if resourceSequentialCode != nil {
            dictionary["resourceSequentialCode"] = resourceSequentialCode
        }
        if resourceStatus != nil {
            dictionary["resourceStatus"] = resourceStatus
        }
        if resourceType != nil {
            dictionary["resourceType"] = resourceType
        }
        if rowTime != nil {
            dictionary["rowTime"] = rowTime
        }
        if rowVersion != nil {
            dictionary["rowVersion"] = rowVersion
        }
        if spaceName != nil {
            dictionary["spaceName"] = spaceName
        }
        if spaceType != nil {
            dictionary["spaceType"] = spaceType
        }
        if specificLocation != nil {
            dictionary["specificLocation"] = specificLocation
        }
        if tenantID != nil {
            dictionary["tenantId"] = tenantID
        }
        if unitName != nil {
            dictionary["unitName"] = unitName
        }
        if updatedBy != nil {
            dictionary["updatedBy"] = updatedBy
        }
        if updationDate != nil {
            dictionary["updationDate"] = updationDate
        }
        return dictionary
    }
}
