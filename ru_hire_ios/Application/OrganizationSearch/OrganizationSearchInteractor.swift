//
//  OrganizationSearchInteractor.swift
//  ru_hire_ios
//
//  Created by Владислав on 11.11.2020.
//

import Foundation
import Alamofire
import UIKit


protocol OrganizationSearchInteractorInput {
    var output:OrganizationSearchInteractorOutput! {get set}
    func loadInformation(requestWord: String, completion: @escaping ([OrganizationShortData]) -> Void)
    
}

protocol OrganizationSearchInteractorOutput {
    
}

class OrganizationSearchInteractor: OrganizationSearchInteractorInput {
    var output: OrganizationSearchInteractorOutput!
    
    
    func loadInformation(requestWord: String, completion: @escaping ([OrganizationShortData]) -> Void) {
        
        let apiKey = "bbacb5ad0f3be67e54eeb5e6fdeb1fa0021e68d9"
        let dadata_url = "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party"
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Token " + apiKey ]
        let  parameters: Parameters = [
            "query": requestWord ]
        
        _ =  AF.request(dadata_url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON
        { response in
            if let objects = try? response.result.get(), let jsonDict = objects as? NSDictionary
            {
                var organizationData: [OrganizationShortData] = []
                
                if let suggestionArray = jsonDict["suggestions"] as? NSArray {
                    for index in 0..<suggestionArray.count {
                        let suggestion = OrganizationShortData(data: suggestionArray[index] as! NSDictionary )
                        organizationData.append(suggestion!)
                    }
                } else {
                    print(jsonDict["message"]!)
                    NotificationCenter.default.post(name: NSNotification.Name("LoadError"), object: nil)
                }
                
                DispatchQueue.main.async {
                    completion(organizationData)
                    NotificationCenter.default.post(name: NSNotification.Name("LoadСompleted"), object: nil)
                }
            }
            if response.error != nil {
                print(response.error?.errorDescription!)
                NotificationCenter.default.post(name: NSNotification.Name("LoadError"), object: nil)
            }
        }        
    }
}
