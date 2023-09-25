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
        view.addSubview(imageView)
        return imageView
    }()
    
    lazy var pokedexImage: UIImageView = {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "pokedex")
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
        label.textColor = .red
        label.text = ""
        view.addSubview(label)
        return label
    }()
    
// MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        guard let singlePokemon = pokemon else {
            print("selected pokemon is nil")
            return
        }
        presenter?.loadData(pokemon: singlePokemon)
        
    }
    
    func setupConstraints() {
        pokedexImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.width.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
        pokemonImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(35)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        pokemonName.snp.makeConstraints { make in
            make.top.equalTo(pokedexImage.snp.bottom).offset(40)
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
            make.height.equalTo(200)
        }
       
    }
    
    func loadPokemonDetail(pokemon: SinglePokemon) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let pokemonType = pokemon.types.first else {return}
            
            
            guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return
            }

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
            self.pokemonType.text = "Type: \(pokemonType.typeInfo.name)"
            self.pokemonName.text = pokemon.name.capitalized
            
        }
    }
    
    func showSpinner() {
        pokemonName.isHidden = true
        pokemonImage.isHidden = true
        pokemonType.isHidden = true
        pokemonHeight.isHidden = true
        pokemonWeight.isHidden = true
        pokemonImageBig.isHidden = true
        pokedexImage.isHidden = true
        
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
        pokemonName.isHidden = false
        pokemonImage.isHidden = false
        pokemonType.isHidden = false
        pokemonHeight.isHidden = false
        pokemonWeight.isHidden = false
        pokemonImageBig.isHidden = false
        pokedexImage.isHidden = false
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
