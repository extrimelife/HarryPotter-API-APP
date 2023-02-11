//
//  InfoViewController.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 03.10.2022.
//

import UIKit

final class InfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.width / 2
            
        }
    }
    
    private var imageUrl: URL? {
        didSet {
            imageView.image = nil
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
      
    }
    
    private func fetchImage() {
        imageUrl = URL(string: character.image)
        guard let url = imageUrl else { return }
        NetworkManager.shared.fetchImage(from: url) { [unowned self] data in
            if url == imageUrl {
                switch data {
                case .success(let data):
                    imageView.image = UIImage(data: data)
                    navigationItem.title = character.name
                    descriptionLabel.text = character.commonInfo
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
