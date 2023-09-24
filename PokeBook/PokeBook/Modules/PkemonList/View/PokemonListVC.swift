//
//  PokemonListVC.swift
//  PokeBook
//
//  Created by Pavel on 21.09.23.
//

import UIKit
import SnapKit


protocol PokemonListVCProtocol: AnyObject {
    func fillTableWithPokemons(pokemonList: PokemonsList)
    func showSpinner()
    func removeSpinner()
}

class PokemonListVC: UIViewController, PokemonListVCProtocol {

    var pokemonList: PokemonsList?
    private var numberOfRows: Int = 0
    
    var presenter: ViewPresenterProtocol?
    
    var page = 1
    
    var activityIndicator : UIView?
    
    lazy var pokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(PokemonTableCell.self, forCellReuseIdentifier: PokemonTableCell.key)
        view.addSubview(tableView)
        return tableView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        button.isEnabled = false
        view.addSubview(button)
        return button
    }()
    
    lazy var pageNumber: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "1"
        label.layer.cornerRadius = 15
        label.clipsToBounds = true

        
        
        
        view.addSubview(label)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupNavigation()
        guard let presenter = presenter else { return }
        presenter.loadData()
    }
    
    private func setupConstraints() {
        pokemonTableView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(120)
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(16)
        }
        
        previousButton.snp.makeConstraints { make in
            make.top.equalTo(pokemonTableView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
            make.width.equalTo(70)
        }
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(pokemonTableView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
            make.width.equalTo(70)
        }
        pageNumber.snp.makeConstraints { make in
            make.top.equalTo(pokemonTableView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    private func setupNavigation() {
        self.title = "PokeBook"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black

        if #available(iOS 15, *) {
               let appearance = UINavigationBarAppearance()
              // appearance.configureWithOpaqueBackground()
            appearance.configureWithDefaultBackground()
               self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
           }
    }
    
    func fillTableWithPokemons(pokemonList: PokemonsList) {
        self.numberOfRows = pokemonList.pokemons.count
        self.pokemonList = pokemonList
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
    }
    
    @objc func nextButtonAction() {
        
        presenter?.nextPagePokemons()
        
        if Constants.offset > 0 {
            previousButton.isEnabled = true
            previousButton.backgroundColor = .black
        }
        page = page + 1
        pageNumber.text = page.description
    }
    
    @objc func previousButtonAction() {
        
        presenter?.previousPagePokemons()
        
        if Constants.offset == 0 {
            previousButton.isEnabled = false
            previousButton.backgroundColor = .gray
            page = 1
        } else {
            previousButton.backgroundColor = .black
            page = page - 1
        }
        pageNumber.text = page.description
    }
    
    func showSpinner() {
        pokemonTableView.isHidden = true
        previousButton.isEnabled = false
        nextButton.isEnabled = false
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
        pokemonTableView.isHidden = false
        previousButton.isEnabled = true
        nextButton.isEnabled = true
       }
   

}

// MARK: Table View Delegate
extension PokemonListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let singlePokemon = pokemonList?.pokemons[indexPath.row] else {return}
        presenter?.openPokemon(pokemon: singlePokemon)
    }
    
}

// MARK: Table View Data Source
extension PokemonListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableCell.key, for: indexPath) as? PokemonTableCell else { return UITableViewCell() }


        cell.pokemonName.text = pokemonList?.pokemons[indexPath.row].name.capitalized
        return cell
    }
    
  
    
}

