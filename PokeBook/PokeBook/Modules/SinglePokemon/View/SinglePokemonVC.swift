//
//  SinglePokemonVC.swift
//  PokeBook
//
//  Created by Pavel on 23.09.23.
//

import UIKit
import SnapKit
import Alamofire

protocol SinglePokemonVCProtocol: AnyObject {

    func loadPokemonDetail(pokemon: SinglePokemon)
}

class SinglePokemonVC: UIViewController, SinglePokemonVCProtocol {
   
    var pokemon: Pokemon?
    var presenter: SPViewPresenterProtocol?
    
    lazy var pokemonImage: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Pokemon Name"
        return label
    }()
    
    lazy var pokemonWeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "7 kg"
        return label
    }()
    
    lazy var pokemonHeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "25 cm"
        return label
    }()
    
    lazy var pokemonType: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Type: "
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(pokemonImage)
        view.addSubview(pokemonName)
        view.addSubview(pokemonType)
        view.addSubview(pokemonWeight)
        view.addSubview(pokemonHeight)
        
        setupConstraints()
        pokemonName.text = pokemon?.name.capitalized
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
            make.width.equalTo(150)
            make.height.equalTo(150)
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
            
            self.pokemonHeight.text = "Height: \(pokemon.height.description) cm"
            self.pokemonWeight.text = "Weight: \(pokemon.weight.description) kg"
            self.pokemonType.text = "Type: \(pokemonType.typeInfo.name)"
           
        }
    }
    


}
