//
//  OrganizationSearchRouter.swift
//  ru_hire_ios
//
//  Created by Владислав on 11.11.2020.
//

import Foundation
import UIKit

protocol OrganizationSearchRouterInput {
    func pushToSearchDetail(inn: String, fromView: UIViewController)
}

protocol OrganizationSearchRouterOutput {
}

class OrganizationSearchRouter: OrganizationSearchRouterInput {
    
    func pushToSearchDetail(inn: String, fromView: UIViewController) {
        let secondViewController:OrganizationDetailViewController = OrganizationDetailViewController()
        OrganizationSelectInn.share.selectInn = inn
        fromView.navigationController?.pushViewController(secondViewController, animated: true)
    }
}


