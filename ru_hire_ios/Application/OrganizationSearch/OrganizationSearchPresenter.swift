//
//  OrganizationSearchPresenter.swift
//  ru_hire_ios
//
//  Created by Владислав on 11.11.2020.
//

import Foundation
import UIKit

protocol OrganizationSearchPresenterInput {
    var output:OrganizationSearchPresenterOutput! {get set}
    func searchData(searchData: String)
    func showDataDetail(inn: String , fromView: UIViewController)
}

protocol OrganizationSearchPresenterOutput {
    func updatingSearchResults(newSearchData: [OrganizationShortData])
}

class OrganizationSearchPresenter: OrganizationSearchPresenterInput {
    
    func showDataDetail(inn: String, fromView: UIViewController) {
        router.pushToSearchDetail(inn: inn, fromView: fromView)
    }
    
    var output:OrganizationSearchPresenterOutput!
    var interactor: OrganizationSearchInteractorInput! = OrganizationSearchInteractor()
    var router: OrganizationSearchRouterInput! = OrganizationSearchRouter()
    
    func searchData(searchData: String) {
        interactor.loadInformation(requestWord: searchData) { data in
            self.output.updatingSearchResults(newSearchData: data)
        }
    }
}

extension OrganizationSearchPresenter:OrganizationSearchInteractorOutput, OrganizationSearchRouterOutput {
    
    
}
