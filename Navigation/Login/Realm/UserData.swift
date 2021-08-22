//
//  UserData.swift
//  Navigation
//
//  Created by Alexey Kharin on 28.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class UserData: Object {
    
    dynamic var  login: String = String()
    
    dynamic var  password: String = String()
    
}
