//
//  TableViewCell.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 24.09.2022.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var actorImage: UIImageView! {
        didSet {
            actorImage.layer.cornerRadius = actorImage.frame.width / 2
        }
    }
    
    private var imageUrl: URL? {
        didSet {
            actorImage.image = nil
        }
    }
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    
    // MARK: - Public methods
    func configure(with character: Character) {
        fullNameLabel.text = character.name
        imageUrl = URL(string: character.image)
        guard let url = imageUrl else {
            actorImage.image = UIImage(systemName: "pencil")
            return
        }
        NetworkManager.shared.fetchImage(from: url) { data in
            if url == self.imageUrl {
                switch data {
                case .success(let data):
                    self.actorImage.image = UIImage(data: data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}




