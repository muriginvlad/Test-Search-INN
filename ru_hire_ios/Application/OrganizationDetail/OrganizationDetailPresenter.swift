//
//  OrganizationDetailPresenter.swift
//  ru_hire_ios
//
//  Created by Владислав on 11.11.2020.
//

import Foundation
import UIKit

protocol OrganizationDetailPresenterInput {
    var output:OrganizationDetailPresenterOutput! {get set}
    func searchData()
}

protocol OrganizationDetailPresenterOutput {
    func fullSearchResults(searchData: OrganizationFullData)
    
}

class OrganizationDetailPresenter: OrganizationDetailPresenterInput {
    
    var output: OrganizationDetailPresenterOutput! 
    var interactor: OrganizationDetailInteractorInput! = OrganizationDetailInteractor()
    var router: OrganizationDetailRouterInput! = OrganizationDetailRouter()
    
    func searchData(){
        interactor.loadInformation(innOrganization: OrganizationSelectInn.share.selectInn) { data in
              self.output.fullSearchResults(searchData: data)
        }
    }
}

extension OrganizationDetailPresenter: OrganizationDetailInteractorOutput, OrganizationDetailRouterOutput {
    
}
