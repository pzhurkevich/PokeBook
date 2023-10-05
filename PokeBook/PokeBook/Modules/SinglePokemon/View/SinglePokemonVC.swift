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
    func errorAlert(error: SessionError)
    func showSpinner()
    func removeSpinner()
    func loadPokemonDetail(pokemon: SinglePokemon)
}

class SinglePokemonVC: UIViewController, SinglePokemonVCProtocol {
   
    var pokemon: Pokemon?
    var presenter: SPViewPresenterProtocol?
    var activityIndicator : UIView?
    
    lazy var pokemonImage: UIImageView = {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleAspectFill
        pokedexImage.addSubview(imageView)
        return imageView
    }()
    
    lazy var pokemonImageBig: UIImageView = {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    lazy var pokedexImage: UIImageView = {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "pokedex")
        return imageView
    }()
    
    lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    lazy var pokemonWeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    lazy var pokemonHeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    lazy var pokemonType: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .red
        label.text = ""
        return label
    }()
    
    lazy var infoContainer: UIView = {
        let container = UIView()
        container.addSubview(pokemonName)
        container.addSubview(pokemonImage)
        container.addSubview(pokemonType)
        container.addSubview(pokemonHeight)
        container.addSubview(pokemonWeight)
        container.addSubview(pokemonImageBig)
        container.addSubview(pokedexImage)
        view.addSubview(container)
        return container
    }()
    
// MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Details"
        setupConstraints()
        guard let singlePokemon = pokemon else {
            debugPrint("selected pokemon is nil")
            return
        }
        presenter?.loadData(pokemon: singlePokemon)
    }
    
    func setupConstraints() {
        infoContainer.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        pokedexImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.width.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        pokemonImage.snp.makeConstraints { make in
            make.centerX.equalTo(pokedexImage.snp.centerX).inset(view.frame.size.width).multipliedBy(0.5)
            make.centerY.equalTo(pokedexImage.snp.centerY).offset(-15)
            make.size.equalTo(100)
        }
        pokemonName.snp.makeConstraints { make in
            make.top.equalTo(pokedexImage.snp.bottom).offset(30)
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
        pokemonImageBig.snp.makeConstraints { make in
            make.top.equalTo(pokemonWeight.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
       
    }
    
    func loadPokemonDetail(pokemon: SinglePokemon) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let pokemonType = pokemon.types.first else {return}
            guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let imageFileName = "\(pokemon.name).jpg"
            let imageURL = documentsDirectoryURL.appendingPathComponent(imageFileName)
            if let image = UIImage(contentsOfFile: imageURL.path) {
                self.pokemonImage.image = image
                self.pokemonImageBig.image = image
            } else {
                if let spriteURL = URL(string: pokemon.sprites.frontDefault) {
                    self.pokemonImage.af.setImage(withURL: spriteURL)
                    self.pokemonImageBig.af.setImage(withURL: spriteURL)
                }
            }            
            self.pokemonHeight.text = "Height: \(pokemon.height*10) cm"
            self.pokemonWeight.text = "Weight: \(pokemon.weight/10) kg"
            self.pokemonType.text = "\(LocalizationAdapter.getTextFor(string: .pokemonType)): \(pokemonType.typeInfo.name)"
            self.pokemonName.text = pokemon.name.capitalized
            
        }
    }
    
    func showSpinner() {
        infoContainer.isHidden = true
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.center = view.center
        DispatchQueue.main.async {
            self.view.addSubview(indicator)
        }
        activityIndicator = indicator
    }
    
    func removeSpinner() {
           DispatchQueue.main.async {
               self.activityIndicator?.removeFromSuperview()
               self.activityIndicator = nil
           }
        infoContainer.isHidden = false
       }
    
    func errorAlert(error: SessionError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: error.title, message: error.friendlyMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
                guard let self = self,
                      let singlePokemon = pokemon else { return } 
                self.presenter?.loadData(pokemon: singlePokemon)
                }))
            self.present(alert, animated: true, completion: nil)
        }
        removeSpinner()
    }

}
