//
//  Links.swift
//  MAKNetworking
//
//  Created by Mohammad Ashraful Kabir on 27/01/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import Foundation

struct Links : Codable {
	let selfLink : String?
	let html : String?
	let download : String?

	enum CodingKeys: String, CodingKey {
		case selfLink = "self"
		case html = "html"
		case download = "download"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		selfLink = try values.decodeIfPresent(String.self, forKey: .selfLink)
		html = try values.decodeIfPresent(String.self, forKey: .html)
		download = try values.decodeIfPresent(String.self, forKey: .download)
	}

}
