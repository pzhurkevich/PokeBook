//
//  SinglePokemonViewController.swift
//  PokeBook
//
//  Created by Pavel on 23.09.23.
//

import UIKit
import SnapKit

class SinglePokemonViewController: UIViewController {
    
    lazy var pokemonImage: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Name"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(pokemonImage)
        view.addSubview(pokemonName)
        setupConstraints()

    }
    
    func setupConstraints() {
        pokemonImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        pokemonName.snp.makeConstraints { make in
            make.top.equalTo(pokemonImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
       
    }


}
