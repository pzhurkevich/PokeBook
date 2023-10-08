//
//  AlamofireManager.swift
//  PokeBook
//
//  Created by Pavel on 6.10.23.
//

import Foundation
import Alamofire

protocol AlamofireManagerProtocol {
    func getPokemonsList(completion: @escaping (Result<PokemonsList, Error>) -> Void)
    func getPokemonDetail(pokemon: Pokemon, completion: @escaping (Result<SinglePokemon, Error>) -> Void)
    func saveImageFromWeb(name: String, url: String, completion: @escaping (Result<URL, Error>) -> Void)
}

class AlamofireManager: AlamofireManagerProtocol {
    
    func getPokemonsList(completion: @escaping (Result<PokemonsList, Error>) -> Void) {
        AF.request(Constants.endpoint, method: .get, parameters: nil).responseDecodable(of: PokemonsList.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPokemonDetail(pokemon: Pokemon, completion: @escaping (Result<SinglePokemon, Error>) -> Void) {
        AF.request(pokemon.pokemonURL, method: .get, parameters: nil).responseDecodable(of: SinglePokemon.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveImageFromWeb(name: String, url: String, completion: @escaping (Result<URL, Error>) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let imageData):
                let fileManager = FileManager.default
                do {
                    let documentsURL = try fileManager.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: false)
                    let fileURL = documentsURL.appendingPathComponent("\(name).jpg")
                    try imageData.write(to: fileURL)
                    completion(.success(fileURL))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
