//
//  AcronymListViewModel.swift
//  AcronymSearch
//
//  Created by Rajesh Sammita on 05/06/22.
//

import UIKit
class AcronymListViewModel {
    
    internal let acronymListModel: AcronymObserver<AcronymListResponse?> = AcronymObserver(nil)  //no data  initially
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = NetworkHelper()) {
        self.apiService = apiService
    }
    
    internal func fetchLongFormList(searchText: String, complete: @escaping (AcronymObserver<AcronymListResponse?>)->() ) {
        
        self.apiService.startNetworkTask(urlStr: NetworkHelperConstants.getAcronymSearchURL(searchText: searchText), params: [:]) { result in
            switch result {
                
            case .success(let dataObject):
                do {
                    let decoderObject = JSONDecoder()
                    let response = try decoderObject.decode([AcronymListResponse].self, from: dataObject!)
                    self.acronymListModel.value = response.first
                }
                catch {
                    //print("error--->", errorObject)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            complete(self.acronymListModel)
        }
        
    }
}
