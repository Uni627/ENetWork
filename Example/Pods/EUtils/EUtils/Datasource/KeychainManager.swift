//
//  KeychainManager.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/11.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import KeychainAccess

public enum KeychainKey:String {
    case userPassword = "KCUserPassword"
    case httpToken = "KCUserToken"
}

let EKeychain = Keychain(service: "com.einyun.bms")
