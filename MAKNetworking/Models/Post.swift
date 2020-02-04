//
//  Post.swift
//  MAKNetworking
//
//  Created by Mohammad Ashraful Kabir on 27/01/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import Foundation

struct Post : Codable {
	let id : String?
	let created_at : String?
	let width : Int?
	let height : Int?
	let color : String?
	let likes : Int?
	let liked_by_user : Bool?
	let user : User?
	let current_user_collections : [String]?
	let urls : Urls?
	let categories : [Category]?
	let links : Links?

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case created_at = "created_at"
		case width = "width"
		case height = "height"
		case color = "color"
		case likes = "likes"
		case liked_by_user = "liked_by_user"
		case user = "user"
		case current_user_collections = "current_user_collections"
		case urls = "urls"
		case categories = "categories"
		case links = "links"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		liked_by_user = try values.decodeIfPresent(Bool.self, forKey: .liked_by_user)
		user = try values.decodeIfPresent(User.self, forKey: .user)
		current_user_collections = try values.decodeIfPresent([String].self, forKey: .current_user_collections)
		urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
		categories = try values.decodeIfPresent([Category].self, forKey: .categories)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
	}

}
