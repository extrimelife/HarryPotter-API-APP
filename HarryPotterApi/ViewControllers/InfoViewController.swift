//
//  InfoViewController.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 03.10.2022.
//

import UIKit

final class InfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
      
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: character.image) { [unowned self] data in
            self.imageView.image = UIImage(data: data)
            self.navigationItem.title = self.character.name
            self.descriptionLabel.text = self.character.commonInfo
        }
    }
}
