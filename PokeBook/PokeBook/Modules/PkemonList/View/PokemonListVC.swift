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
}

class PokemonListVC: UIViewController, PokemonListVCProtocol {

    var pokemonList: PokemonsList?
    private var numberOfRows: Int = 0
    
    var presenter: ViewPresenterProtocol?
    
    lazy var pokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PokemonTableCell.self, forCellReuseIdentifier: PokemonTableCell.key)
        view.addSubview(tableView)
        return tableView
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
            make.bottom.equalToSuperview().inset(160)
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
    private func setupNavigation() {
        self.title = "PokeBook"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
        return 60
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

