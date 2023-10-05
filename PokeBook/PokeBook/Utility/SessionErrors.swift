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
            return LocalizationAdapter.getTextFor(string: .connectionError)
        case .invalidURL:
            return LocalizationAdapter.getTextFor(string: .invalidURL)
        case .unknownError:
            return LocalizationAdapter.getTextFor(string: .unknownError)
        }
    }
    
    var title: String {
        switch self {
        case .connectionError, .invalidURL, .unknownError:
            return LocalizationAdapter.getTextFor(string: .errorTitle)
        }
    }
}
