//
//  RealmManager.swift
//  PokeBook
//
//  Created by Pavel on 25.09.23.
//

import Foundation
import RealmSwift
import UIKit
import Alamofire

protocol RealmProtocol {
    func addPokemonListData(data: Pokemon)
    func addSinglePokemonDetail(data: SinglePokemon)
}



class RealmManger : RealmProtocol {
    var realm = try! Realm()
    
    func addPokemonListData(data: Pokemon) {
        
        let savedPokemons = realm.objects(PokemonListData.self)
        
        let listPokemonsDB = PokemonListData(name: data.name, pokemonURL: data.pokemonURL)
        do {
            try realm.write {
                if !savedPokemons.contains(where: { pokemon in
                    pokemon.name == data.name}) {
                    realm.add(listPokemonsDB)
                }
            }
        } catch {
            print("realm error")
        }
        
    }
    
    func addSinglePokemonDetail(data: SinglePokemon) {
        let savedPokemonsDetails = realm.objects(SinglePokemonDetail.self)
        guard let type = data.types.first else { return }
       
        saveImageFromWeb(name: data.name, url: data.sprites.frontDefault) { result in
            switch result {
               case .success(let fileURL):
                   print("Image saved successfully at: \(fileURL)")
                let singlePokemonDB = SinglePokemonDetail(name: data.name, height: data.height, weight: data.weight, type: type.typeInfo.name, imageURL: fileURL.absoluteString)
                do {
                    try self.realm.write {
                        if !savedPokemonsDetails.contains(where: { pokemon in
                            pokemon.name == data.name}) {
                            self.realm.add(singlePokemonDB)
                        }
                    }
                } catch {
                    print("realm error")
                }
                
               case .failure(let error):
                   print("Failed to save image: \(error)")
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

    
//    func saveImageFromWeb(url: String, name: String, completion: @escaping (Result<URL, Error>) -> Void {
//        let downloader = ImageDownloader()
//        let urlRequest = URLRequest(url: URL(string: url)!)
//        downloader.download(urlRequest, completion:  { response in
//
//            if case .success(let image) = response.result {
//               self.saveImageLocally(image: image, name: name)
//            }
//        })
//
//    }
//
//    func saveImageLocally(image: UIImage, name: String) {
//        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            print("Error getting documents directory")
//            return ""
//        }
//
//        let fileURL = documentsDirectory.appendingPathComponent("\(name).jpg")
//        if let data = image.jpegData(compressionQuality: 1.0) {
//            do {
//                try data.write(to: fileURL)
//                print("Image saved successfully. Local URL: \(fileURL)")
//            } catch {
//                print("Error saving image: \(error)")
//            }
//        }
//        return fileURL.absoluteString
//    }

    
}