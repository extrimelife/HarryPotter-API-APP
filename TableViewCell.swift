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
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    
    // MARK: - Public methods
    func configure(with character: Character) {
        fullNameLabel.text = character.character
        DispatchQueue.main.async {
            NetworkManager.shared.fetchImage(from: character.image) { data in
                self.actorImage.image = UIImage(data: data)
            }
        }
    }
}


