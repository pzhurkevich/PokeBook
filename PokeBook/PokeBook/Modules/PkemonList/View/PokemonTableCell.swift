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
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Pokemon"
        contentView.addSubview(label)
        return label
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
    }

}
