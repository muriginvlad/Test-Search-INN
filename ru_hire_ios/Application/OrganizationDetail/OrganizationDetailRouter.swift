//
//  OrganizationDetailRouter.swift
//  ru_hire_ios
//
//  Created by Владислав on 11.11.2020.
//

import Foundation
import UIKit

protocol OrganizationDetailRouterInput {
    var output:OrganizationDetailRouterInput! {get set}
    func backToPreviousPage(currentView: UIViewController)
    func gettingData(_ data: OrganizationShortData)
}

protocol OrganizationDetailRouterOutput {
}

class OrganizationDetailRouter: OrganizationDetailRouterInput {
    var output: OrganizationDetailRouterInput!
    
    func backToPreviousPage(currentView: UIViewController) {
        currentView.navigationController?.popViewController(animated: true)
    }
    
    func gettingData(_ data: OrganizationShortData) {
        print(data.innOrganization)
    }
    
}
