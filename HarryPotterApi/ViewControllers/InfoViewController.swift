//
//  InfoViewController.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 03.10.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
}

    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: character.image) { data in
            self.imageView.image = UIImage(data: data)
        }
    }
}
