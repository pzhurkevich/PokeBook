//
//  SinglePokemonVC.swift
//  PokeBook
//
//  Created by Pavel on 23.09.23.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage

protocol SinglePokemonVCProtocol: AnyObject {

    func loadPokemonDetail(pokemon: SinglePokemon)
}

class SinglePokemonVC: UIViewController, SinglePokemonVCProtocol {
   
    var pokemon: Pokemon?
    var presenter: SPViewPresenterProtocol?
    
    lazy var pokemonImage: UIImageView = {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleToFill
        view.addSubview(imageView)
        return imageView
    }()
    
    lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        view.addSubview(label)
        return label
    }()
    
    lazy var pokemonWeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        view.addSubview(label)
        return label
    }()
    
    lazy var pokemonHeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        view.addSubview(label)
        return label
    }()
    
    lazy var pokemonType: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Type: "
        view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        //pokemonName.text = pokemon?.name.capitalized
        guard let singlePokemon = pokemon else {
            print("selected pokemon is nil")
            return
        }
        presenter?.loadData(pokemon: singlePokemon)
        
    }
    
    func setupConstraints() {
        pokemonImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        pokemonName.snp.makeConstraints { make in
            make.top.equalTo(pokemonImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        pokemonType.snp.makeConstraints { make in
            make.top.equalTo(pokemonName.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        pokemonHeight.snp.makeConstraints { make in
            make.top.equalTo(pokemonType.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(40)
        }
        pokemonWeight.snp.makeConstraints { make in
            make.top.equalTo(pokemonType.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(40)
        }
       
    }
    
    func loadPokemonDetail(pokemon: SinglePokemon) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let pokemonType = pokemon.types.first else {return}
            
            self.pokemonHeight.text = "Height: \(pokemon.height*10) cm"
            self.pokemonWeight.text = "Weight: \(pokemon.weight/10) kg"
            self.pokemonType.text = "Type: \(pokemonType.typeInfo.name)"
            self.pokemonName.text = pokemon.name.capitalized
            if let spriteURL = URL(string: pokemon.sprites.frontDefault) {
                self.pokemonImage.af.setImage(withURL: spriteURL)
            }
        }
    }
    


}
