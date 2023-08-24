//
//  User.swift
//  MyHub
//
//  Created by Anthony Baumle on 24/08/2023.
//

import Foundation
import SwiftUI
import CoreLocation

extension User: Decodable {
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try values.decode(Int.self, forKey: .id)
		userId = try values.decode(String.self, forKey: .userID)
		password = try values.decode(String.self, forKey: .password)
		sex = try values.decode(String.self, forKey: .sex)

		let birthdayString = try values.decode(String.self, forKey: .birthday)
		if (birthdayString != "")
		{
			birthday = formatDate(dateAsString: birthdayString)
		}
		
		firstname = try values.decode(String.self, forKey: .firstname)
		lastname = try values.decode(String.self, forKey: .lastname)
		languageId = try values.decode(String.self, forKey: .languageID)
		privateEmail = try values.decode(String.self, forKey: .privateEmail)
		
		let creationStampString = try values.decode(String.self, forKey: .creationStamp)
		if (creationStampString != "")
		{
			creationStamp = formatDate(dateAsString: creationStampString)
		}
		
		creationUser = try values.decode(String.self, forKey: .creationUser)
		creationFunction = try values.decode(String.self, forKey: .creationFunction)
		
		let mutationStampString = try values.decode(String.self, forKey: .mutationStamp)
		if (mutationStampString != "")
		{
			mutationStamp = formatDate(dateAsString: mutationStampString)
		}
		
		mutationUser = try values.decode(String.self, forKey: .mutationUser)
		mutationFunction = try values.decode(String.self, forKey: .mutationFunction)
	}
}

extension User: Encodable {
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		
		try container.encode(id, forKey: .id)
		try container.encode(userId, forKey: .userID)
		try container.encode(password, forKey: .password)
		try container.encode(sex, forKey: .sex)
		try container.encode(birthday, forKey: .birthday)
		try container.encode(firstname, forKey: .firstname)
		try container.encode(lastname, forKey: .lastname)
		try container.encode(languageId, forKey: .languageID)
		try container.encode(privateEmail, forKey: .privateEmail)
		try container.encode(creationStamp, forKey: .creationStamp)
		try container.encode(creationUser, forKey: .creationUser)
		try container.encode(creationFunction, forKey: .creationFunction)
		try container.encode(mutationStamp, forKey: .mutationStamp)
		try container.encode(mutationUser, forKey: .mutationUser)
		try container.encode(mutationFunction, forKey: .mutationFunction)
	}
}

struct User: Hashable, Identifiable
{
	var id : Int
	var userId : String
	var password : String
	var sex : String
	var birthday : Date?
	var firstname : String
	var lastname : String
	var languageId : String
	var privateEmail : String
	
	var creationStamp : Date?
	var creationUser : String
	var creationFunction : String
	var mutationStamp : Date?
	var mutationUser : String
	var mutationFunction : String
	
	enum CodingKeys: String, CodingKey {
		case id
		case userID = "userId"
		case password, sex, birthday, firstname, lastname
		case languageID = "languageId"
		case privateEmail, creationStamp, creationUser, creationFunction, mutationStamp, mutationUser, mutationFunction
	}
}

func formatDate(dateAsString: String) -> Date?
{
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "YYYY-MM-dd"
	let dateTimeFormatter = DateFormatter()
	dateTimeFormatter.dateFormat = "YYYY-MM-ddTHH:mm:SS"
	
	if (dateAsString.count == 10)
	{
		return dateFormatter.date(from: dateAsString)
	}
	else if (dateAsString.count == 19)
	{
		return dateTimeFormatter.date(from: dateAsString)
	}
	
	return nil;
}
