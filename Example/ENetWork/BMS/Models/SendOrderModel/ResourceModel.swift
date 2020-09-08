//
//  ResourceModel.swift
//  EServices
//
//  Created by pxy on 2019/11/13.
//
import Foundation
import SwiftyJSON

public enum ResourceSignType: Int {
    case code       = 1
    case nfc        = 2
    case none       = 3
    case bluetooth  = 4

    public var description: String {
        switch self {
        case .code:
            return "二维码"
        case .nfc:
            return "NFC"
        case .none:
            return "不签到"
        case .bluetooth:
            return "蓝牙"
        }
    }
}

public enum ResourceType: String {
    case engineering        = "engineering_resources"       //工程
    case environmental      = "environmental_resources"     //环境
    case order              = "order_resources"             //秩序

    public var description: String {
        switch self {
        case .engineering:
            return "工程"
        case .environmental:
            return "环境"
        case .order:
            return "秩序"
        }
    }
}

public class ResourceModel: NSObject {

    public var basicBrand: String?                 //品牌
    public var basicImportanceDegree: String?      //重要都
    public var basicRemark: String?                //备注
    public var basicSpecificationType: String?     //规格型号
    public var categoryID: String?
    public var categoryName: String?
    public var createdBy: String?
    public var creationDate: Int?
    public var enabledFlag: Bool?
    public var ID: String?
    public var isDeleted: Bool?
    public var massifID: String?
    public var massifName: String?

    public var buildingFloor: Int?                 //楼层
    public var buildingUnitNumber: String?         //单元号
    public var buildingNumber: String?             //楼栋号

    public var basicNumber: Int?                //数量

    public var patrolPointName: String?
    public var projectID: String?
    public var projectName: String?
    public var massID: String?
    public var massName: String?
    public var patrolPointCode: String?
    public var location: String?
    public var isPhoto: Int?
    public var picUrl: String?
    public var picArray: [PictureModel] = []
    public var remark: String?
    public var createTime: String?
    public var updateTime: String?
    public var signType: ResourceSignType?   //签到方式（1.二维码、2NFC、3不签到、4蓝牙）
    public var line: Int?

    public var resourceProfessional: String?               //专业
    public var resourceClassificationPath: String?         //环境类别
    public var resourceClassificationPathValue: String?    //环境类别

    public var latin: String?                              //拉丁文
    public var branch: String?                             //科
    public var genus: String?                              //属
    public var placeOfOrigin: String?                      //原产地
    public var habit: String?                              //习性
    public var basicMeasurementUnit: String?               //计量单位
    public var basicMeasurementUnitValue: String?               //计量单位

    public var basicHeightRangeValue: String?                   //H高度(cm)
    public var basicDbhValue: String?                           //φ胸径(cm)
    public var basicCanopyDiameterValue: String?                //P蓬径(cm)

    public var resourceClassification: String? //资源分类ID
    public var resourceClassificationValue: String?
    public var resourceCode: String?
    public var resourceLocationType: String?       //位置类型
    public var resourceLocationTypeValue: String?
    public var resourceName: String?               //资源名称
    public var resourceProfessionalValue: String?
    public var resourceSequentialCode: String?
    public var resourceType: ResourceType?
    public var rowTime: Int?
    public var rowVersion: Int?
    public var spaceName: String?                  //空间
    public var spaceNameValue: String?
    public var spaceType: String?
    public var spaceTypeValue: String?
    public var specificLocation: String?           //具体位置
    public var subsystemID: String?
    public var subsystemName: String?              //子系统
    public var systemId: String?
    public var systemName: String?
    public var tenantID: String?
    public var updatedBy: String?
    public var updationDate: Int?

    public var messageModelArr: [Any] = []
    public var propertyModelArr: [Any] = []
    public var spaceModelArr: [Any] = []

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        basicBrand = json["basicBrand"].string
        basicImportanceDegree = json["basicImportanceDegree"].string
        basicRemark = json["basicRemark"].string
        basicSpecificationType = json["basicSpecificationType"].string
        categoryID = json["categoryId"].string
        categoryName = json["categoryName"].string
        createdBy = json["createdBy"].string
        creationDate = json["creationDate"].int
        enabledFlag = json["enabledFlag"].bool
        ID = json["id"].string
        isDeleted = json["isDeleted"].bool
        massifID = json["massifId"].string
        massifName = json["massifName"].string
        resourceClassification = json["resourceClassification"].string
        resourceClassificationPath = json["resourceClassificationPath"].string

        resourceClassificationPathValue = json["resourceClassificationPathValue"].string
        resourceClassificationValue = json["resourceClassificationValue"].string
        resourceCode = json["resourceCode"].string
        resourceLocationType = json["resourceLocationType"].string
        resourceLocationTypeValue = json["resourceLocationTypeValue"].string
        resourceName = json["resourceName"].string
        resourceProfessional = json["resourceProfessional"].string
        resourceProfessionalValue = json["resourceProfessionalValue"].string
        resourceSequentialCode = json["resourceSequentialCode"].string
        if let m_resourceType = json["resourceType"].string {
            resourceType = ResourceType.init(rawValue: m_resourceType)
        }
        rowTime = json["rowTime"].int
        rowVersion = json["rowVersion"].int
        spaceName = json["spaceName"].string
        spaceNameValue = json["spaceNameValue"].string
        spaceType = json["spaceType"].string
        spaceTypeValue = json["spaceTypeValue"].string
        specificLocation = json["specificLocation"].string
        subsystemID = json["subsystemId"].string
        subsystemName = json["subsystemName"].string
        systemId = json["systemId"].string
        systemName = json["systemName"].string
        tenantID = json["tenant_id"].string
        updatedBy = json["updatedBy"].string
        updationDate = json["updationDate"].int
        buildingFloor = json["buildingFloor"].int
        buildingUnitNumber = json["buildingUnitNumber"].string
        buildingNumber = json["buildingNumber"].string

        latin = json["latin"].string
        branch = json["branch"].string
        genus = json["genus"].string
        placeOfOrigin = json["placeOfOrigin"].string
        habit = json["habit"].string
        basicMeasurementUnit = json["basicMeasurementUnit"].string
        basicMeasurementUnitValue = json["basicMeasurementUnitValue"].string
        basicHeightRangeValue = json["basicHeightRangeValue"].string
        basicDbhValue = json["basicDbhValue"].string
        basicCanopyDiameterValue = json["basicCanopyDiameterValue"].string

        patrolPointName = json["patrolPointName"].string
        projectID = json["projectId"].string
        projectName = json["projectName"].string
        massID = json["massId"].string
        massName = json["massName"].string
        patrolPointCode = json["patrolPointCode"].string
        location = json["location"].string
        isPhoto = json["isPhoto"].int

        picUrl = json["picExampleUrl"].string

        if let jsonData = picUrl?.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    picArray.append(model)
                }
            }
        }

        remark = json["remark"].string
        createTime = json["createTime"].string
        updateTime = json["updateTime"].string
        signType = ResourceSignType.init(rawValue: json["signType"].int ?? 0)
        line = json["line"].int
        basicNumber = json["basicNumber"].int

    }

    public override init() {
        super.init()
    }
}
