//
//  SessionErrors.swift
//  PokeBook
//
//  Created by Pavel on 24.09.23.
//

import Foundation
import Alamofire

public enum SessionError {
    
    case invalidURL
    case connectionError
    case unknownError
    
    
    var friendlyMessage: String {
        switch self {
        case .connectionError:
            return "No Internet connection was found. Please check your Internet connection and try again. Data that has already been downloaded will be shown."
        case .invalidURL:
            return "Pokemon database error, please try again later. Data that has already been downloaded will be shown."
        case .unknownError:
            return "Uncknown error, please try again later. Data that has already been downloaded will be shown."
        }
    }
    
    var title: String {
        switch self {
        case .connectionError:
            return "Connection Error"
        case .invalidURL:
            return "API Error"
        case .unknownError:
            return "Error"
        }
    }
}
