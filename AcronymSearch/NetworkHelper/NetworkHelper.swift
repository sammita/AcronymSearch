//
//  NetworkHelper.swift
//  MoviesList
//
//  Created by Janesh Suthar on 27/05/22.
//

import UIKit
import Foundation

struct NetworkHelperConstants {
    static let baseURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    
    static func getAcronymSearchURL(searchText: String) -> String {
        return baseURL + "?sf=\(searchText)"
    }
}

protocol APIServiceProtocol {
    func startNetworkTask(urlStr:String, params:[String:Any]?, resultHandler: @escaping (Result<Data?, Error>) -> Void)
}

class NetworkHelper:APIServiceProtocol {
    static let shared = NetworkHelper()
    
    func startNetworkTask(urlStr:String, params:[String:Any]? = nil, resultHandler: @escaping (Result<Data?, Error>) -> Void)  {
        
        guard let urlObject = URL(string:urlStr) else {
            let errorTemp = CustomError(title: "url error", description: "", code: 500)
            
            print("issue in url object")
            resultHandler(.failure(errorTemp))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: urlObject)) { dataObject, responseObj, errorObject in
            
            if let error = errorObject {
                resultHandler(.failure(error))
            } else {
                resultHandler(.success(dataObject))
            }
        }.resume()
    }
}

protocol AcronymErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

struct CustomError: AcronymErrorProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}

