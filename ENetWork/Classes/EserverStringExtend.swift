//
//  EserverStringExtend.swift
//  EServices
//
//  Created by pxy on 2020/4/23.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation

extension String {
    //获取字符串尺寸
    public func getNormalStringSize(attriString: NSMutableAttributedString? = nil, font: UIFont, width: CGFloat, height: CGFloat) -> CGSize {
        if self.count == 0 {
            return CGSize()
        }

        let strSize = self.boundingRect(with: CGSize(width: width, height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
        return strSize
    }

    //获取获取字符串尺寸高度
    public func getNormalStringHeight(strFont: UIFont, width: CGFloat) -> CGFloat {
        return getNormalStringSize(attriString: nil, font: strFont, width: width, height: CGFloat.greatestFiniteMagnitude).height
    }

    //获取字符串宽度
    public func getNormalStrWidth(strFont: UIFont, height: CGFloat) -> CGFloat {
        return getNormalStringSize(attriString: nil, font: strFont, width: CGFloat.greatestFiniteMagnitude, height: height).width
    }

    // MARK: 截取字符串
    //截取规定下标之后的字符串
    public func subStringFrom(index: Int) -> String {
        let temporaryString: String = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[temporaryIndex...])
    }

    //截取规定下标之前的字符串
    public func subStringTo(index: Int) -> String {
        let temporaryString = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[...temporaryIndex])
    }

    //截取某一范围的字符串
    public func subStringFrom(startIndex: Int, toIndex: Int) -> String {
        let temporaryString = self
        let temporaryStartIndex = temporaryString.index(temporaryString.startIndex, offsetBy: startIndex)
        let temporaryToIndex = temporaryString.index(temporaryString.startIndex, offsetBy: toIndex)
        return String(temporaryString[temporaryStartIndex...temporaryToIndex])
    }

    //截取某一个字符
    public func singleString(index: Int) -> String {
        let temporaryString = self
        let temporaryStartIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[temporaryStartIndex])
    }

}
