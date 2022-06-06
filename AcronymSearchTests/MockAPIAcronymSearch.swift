//
//  MockAPIAcronymSearch.swift
//  AcronymSearchTests
//
//  Created by Rajesh Sammita on 06/06/22.
//

import Foundation
@testable import AcronymSearch

class MockAPIAcronymSearch:  APIServiceProtocol {
    
    let moviesListModel: AcronymObserver<AcronymListResponse?> = AcronymObserver(nil)  //no data  initially
    
    func startNetworkTask(urlStr:String, params:[String:Any]?, resultHandler: @escaping (Result<Data?, Error>) -> Void)  {
        
        let jsonData = SwiftUtility.loadJson(filename: "AcronymList")
        let decoderObject = JSONDecoder()
        do {
            let response = try decoderObject.decode([AcronymListResponse].self, from: jsonData)
            self.moviesListModel.value = response.first
            resultHandler(.success(jsonData))
        } catch {}
    }
  
}
