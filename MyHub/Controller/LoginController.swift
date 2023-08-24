//
//  LoginController.swift
//  MyHub
//
//  Created by Anthony Baumle on 24/08/2023.
//

import Foundation
import Combine

public class LoginController: ObservableObject
{
	@Published var users: [User] = load("User.json");
	
	func tryConnection(userId: String, password : String) async throws -> User?
	{
		if (users.contains{ us in us.userId == userId && us.password == password })
		{
			return users.filter{ us in return us.userId == userId && us.password == password }.first
		}
					
		return nil
	}
		
}

func load<T: Decodable>(_ filename: String) -> T {
	let data: Data

	guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
	else {
		fatalError("Couldn't find \(filename) in main bundle.")
	}

	do {
		data = try Data(contentsOf: file)
	} catch {
		fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
	}

	do {
		let decoder = JSONDecoder()
		return try decoder.decode(T.self, from: data)
	} catch {
		fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
	}
}
