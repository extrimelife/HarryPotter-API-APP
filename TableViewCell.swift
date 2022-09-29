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
        DispatchQueue.global().async {
            guard let stringUrl = character.image else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.actorImage.image = UIImage(data: imageData)
            }
        }
    }
}


