//
//  ProfileImage.swift
//  MAKNetworking
//
//  Created by Mohammad Ashraful Kabir on 27/01/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import Foundation

struct ProfileImage : Codable {
	let small : String?
	let medium : String?
	let large : String?

	enum CodingKeys: String, CodingKey {
		case small = "small"
		case medium = "medium"
		case large = "large"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		small = try values.decodeIfPresent(String.self, forKey: .small)
		medium = try values.decodeIfPresent(String.self, forKey: .medium)
		large = try values.decodeIfPresent(String.self, forKey: .large)
	}

}
