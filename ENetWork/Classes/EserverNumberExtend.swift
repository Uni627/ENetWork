//
//  EserverNumberExtend.swift
//  EServices
//
//  Created by pxy on 2020/4/23.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation

extension Double {
   public func dateString(outputFormatter: String) -> String {
        let timeStamp = Int(self)
        let timeString = String(timeStamp)
        let timeSta: TimeInterval
        if timeString.count == 10 {
            timeSta = TimeInterval(timeStamp)
        } else {
            let timeStaInt = Int(timeStamp / 1000)
            timeSta = TimeInterval(timeStaInt)
        }
        let date = Date(timeIntervalSince1970: timeSta)
        let dfmateer = DateFormatter()
        dfmateer.dateFormat = outputFormatter
        return dfmateer.string(from: date)
    }

   public func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor

    }
}
