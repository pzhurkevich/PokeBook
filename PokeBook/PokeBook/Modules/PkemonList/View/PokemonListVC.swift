//
//  PokemonListVC.swift
//  PokeBook
//
//  Created by Pavel on 21.09.23.
//

import UIKit
import SnapKit

class PokemonListVC: UIViewController {

    var pokemonList: PokemonsList?
    private var numberOfRows: Int = 0
    
    lazy var pokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.register(PokemonTableCell.self, forCellReuseIdentifier: PokemonTableCell.key)
        view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupNavigation()
       
    }
    
    private func setupConstraints() {
        pokemonTableView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(160)
            make.top.equalToSuperview().inset(60)
            make.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
    private func setupNavigation() {
        self.title = "PokeBook"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 15, *) {
               let appearance = UINavigationBarAppearance()
               appearance.configureWithOpaqueBackground()
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
//        guard let pokemon = pokemonList?.pokemons[indexPath.row] else { return }
//        presenter?.showSelectedPokemon(with: pokemon, from: self)
    }
    
}

// MARK: Table View Data Source
extension PokemonListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableCell.key, for: indexPath) as? PokemonTableCell else { return UITableViewCell() }


        //cell.nameLabel.text = pokemonList?.pokemons[indexPath.row].name.capitalized
        return cell
    }
    
}

