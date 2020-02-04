//
//  MAKImageView.swift
//  MAKNetworking
//
//  Created by Mohammad Ashraful Kabir on 04/02/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import UIKit

class MAKImageView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnAction: UIButton!
    
    var task = URLSessionDataTask()
    
    // MARK:- Override Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView()
    }
    
    // MARK:- IBAction
    @IBAction func action(sender: UIButton) {
        if task.state != .running {
            // Make your API call here
            task.resume()
        } else {
            // Dont perform API call
            task.cancel()
        }
        
        sender.isSelected = !sender.isSelected
    }

    // MARK:- Custom Actions
    private func initView() {
        Bundle.main.loadNibNamed("MAKImageView", owner: self, options: nil)
        addSubview(viewContent)
        
        viewContent.frame = self.bounds
        viewContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        viewContent.layer.cornerRadius = viewContent.frame.size.width / 2
    }
    
}

extension MAKImageView {
    
    func loadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let request = URLRequest(url: imageURL)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = MAKDataCache.instance.read(forRequest: request), let image = UIImage(data: data) {
                self.transition(toImage: image)
            } else {
                self.task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data,
                        let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                        let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        MAKDataCache.instance.write(data: cachedData, forRequest: request)
                        
                        self.transition(toImage: image)
                    }
                })
                
                self.task.resume()
            }
        }
    }
    
    private func transition(toImage image: UIImage?) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                self.imageView.image = image
            }) { finished in
                if (finished) {
                    self.btnAction.isHidden = true
                }
            }
        }
    }
    
}
