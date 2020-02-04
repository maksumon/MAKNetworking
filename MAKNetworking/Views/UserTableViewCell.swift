//
//  UserTableViewCell.swift
//  MAKNetworking
//
//  Created by Mohammad Ashraful Kabir on 27/01/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

//    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var imageViewProfile: MAKImageView!
    @IBOutlet weak var lblUsername: UILabel!
    
    var user: User? {
        didSet {
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageViewProfile.layer.cornerRadius = self.imageViewProfile.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK:- Custom Actions
    func setupUI() {
        self.lblUsername.text = user?.name
        self.imageViewProfile.loadImage(fromURL: (user?.profile_image?.medium)!)
    }
}
