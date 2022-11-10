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
            if url == self.imageUrl {
                switch data {
                case .success(let data):
                    self.imageView.image = UIImage(data: data)
                    self.navigationItem.title = self.character.name
                    self.descriptionLabel.text = self.character.commonInfo
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
