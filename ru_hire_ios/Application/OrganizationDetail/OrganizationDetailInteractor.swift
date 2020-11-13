//
//  OrganizationDetailInteractor.swift
//  ru_hire_ios
//
//  Created by Владислав on 11.11.2020.
//


import Foundation
import Alamofire
import UIKit

protocol OrganizationDetailInteractorInput {
    var output:OrganizationDetailInteractorOutput! {get set}
    func loadInformation(innOrganization: String, completion: @escaping (OrganizationFullData) -> Void)
}

protocol OrganizationDetailInteractorOutput {
}

class OrganizationDetailInteractor: OrganizationDetailInteractorInput {
    
    var output: OrganizationDetailInteractorOutput!
    
    
    func loadInformation(innOrganization: String, completion: @escaping (OrganizationFullData) -> Void) {
        
        let apiKey = "bbacb5ad0f3be67e54eeb5e6fdeb1fa0021e68d9"
        let dadata_url = "https://suggestions.dadata.ru/suggestions/api/4_1/rs/findById/party"
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Token " + apiKey ]
        let  parameters: Parameters = [
            "query": innOrganization,
            "branch_type": "MAIN" ]
        
        _ =  AF.request(dadata_url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON
        { response in
            if let objects = try? response.result.get(), let jsonDict = objects as? NSDictionary
            {
                var organizationData: OrganizationFullData?
                
                if let suggestionsArray = jsonDict["suggestions"] as? NSArray {
                    let suggestions = suggestionsArray[0] as! NSDictionary
                    let data = suggestions["data"] as! NSDictionary
                    organizationData = OrganizationFullData(data: data)!
                    
                    DispatchQueue.main.async {
                        completion(organizationData!)
                        NotificationCenter.default.post(name: NSNotification.Name("LoadDataСompleted"), object: nil)
                    }
                } else {
                    print(jsonDict["message"]!)
                    organizationData?.innOrganization = "D"
                    organizationData?.fullNameOrganization = "D"
                    organizationData?.addressOrganization = "D"
                    NotificationCenter.default.post(name: NSNotification.Name("LoadDataError"), object: nil)
                }
            }
            
            if response.error != nil {
                print(response.error?.errorDescription!)
                NotificationCenter.default.post(name: NSNotification.Name("LoadDataError"), object: nil)
            }
        }
    }
}

