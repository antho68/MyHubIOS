//
//  Menu.swift
//  MyHub
//
//  Created by Anthony Baumle on 28/08/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct Menu: Hashable, Codable, Identifiable
{
	var id : Int
	var menuId : String
	var parentMenuId : String?
	var sequence : Int
}
