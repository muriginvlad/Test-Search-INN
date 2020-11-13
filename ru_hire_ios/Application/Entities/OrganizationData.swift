//
//  OrganizationData.swift
//  ru_hire_ios
//
//  Created by Владислав on 11.11.2020.
//

import Foundation

class OrganizationShortData {
    
    var nameOrganization = ""
    var innOrganization = ""
    
    init?(data: NSDictionary) {
        
        guard
            let nameOrganization = data["value"] as? String,
            let fullData = data["data"] as? NSDictionary,
            let innOrganization = fullData["inn"] as? String
            else {
                return nil
        }
        
        self.nameOrganization = nameOrganization
        self.innOrganization = innOrganization
    }
    
}

class OrganizationSelectInn {
    
    static let share = OrganizationSelectInn()
    public var selectInn = ""
    
}

class OrganizationFullData {
    
    
    var fullNameOrganization = ""
    var innOrganization = ""
    var addressOrganization = ""
    
    init?(data: NSDictionary) {
        
        guard
            let name = data["name"] as? NSDictionary,
            let fullNameOrganization = name["full_with_opf"] as? String,
            let innOrganization = data["inn"] as? String,
            let address = data["address"] as? NSDictionary,
            let addressOrganization = address["value"] as? String

            else {
                return nil
        }
        
        self.fullNameOrganization = fullNameOrganization
        self.innOrganization = innOrganization
        self.addressOrganization = addressOrganization
        
    }
    
    init?(fullNameOrganization: String, innOrganization: String, addressOrganization: String) {
        self.fullNameOrganization = fullNameOrganization
        self.innOrganization = innOrganization
        self.addressOrganization = addressOrganization
    }
   
}
