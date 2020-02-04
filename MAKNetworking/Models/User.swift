//
//  User.swift
//  MAKNetworking
//
//  Created by Mohammad Ashraful Kabir on 27/01/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import Foundation

struct User : Codable {
	let id : String?
	let username : String?
	let name : String?
	let profile_image : ProfileImage?
	let links : Links?

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case username = "username"
		case name = "name"
		case profile_image = "profile_image"
		case links = "links"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		username = try values.decodeIfPresent(String.self, forKey: .username)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		profile_image = try values.decodeIfPresent(ProfileImage.self, forKey: .profile_image)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
	}

}
