//
//  PokemonTableCell.swift
//  PokeBook
//
//  Created by Pavel on 22.09.23.
//

import UIKit
import SnapKit

class PokemonTableCell: UITableViewCell {
    
    static let key = "PokemonTableCell"
    
    lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Pokemon"
        contentView.addSubview(label)
        return label
    }()
    
    lazy var pokeball: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named: "pokeball")
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        pokemonName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(35)
            make.centerY.equalToSuperview()
        }
        pokeball.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }

}
