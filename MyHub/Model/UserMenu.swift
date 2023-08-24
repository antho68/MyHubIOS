//
//  UserMenu.swift
//  MyHub
//
//  Created by Anthony Baumle on 28/08/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct UserMenu: Hashable, Codable, Identifiable
{
	var id : Int
	var userId : String
	var menuId : String
}
