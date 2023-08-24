//
//  HubError.swift
//  MyHub
//
//  Created by Anthony Baumle on 24/08/2023.
//

import Foundation

public class HubError
{
	enum WebMyHubRestError: Error
	{
		case invalidURL
		case invalidResponse
		case invalidData
		case notAuthorized
		case noDatas
	}
}
