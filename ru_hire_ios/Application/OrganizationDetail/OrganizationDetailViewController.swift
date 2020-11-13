//
//  OrganizationDetailViewController.swift
//  ru_hire_ios
//
//  Created by Владислав on 11.11.2020.
//

import UIKit

class OrganizationDetailViewController: UIViewController {
    
    var mainView = UIView()
    var loadLabel = UILabel()
    var fullNameOrganization = UILabel()
    var innOrganizationLabel = UILabel()
    var addressOrganizationLabel = UILabel()
    var spinner = UIActivityIndicatorView(style: .large)
    var reloadButtlon = UIButton()
    
    var organizationData: OrganizationFullData? = nil
    let notificationCenter = NotificationCenter.default
    
    var presenter: OrganizationDetailPresenterInput! = OrganizationDetailPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        presenter.output = self
        presenter.searchData()
    }
    func updateUI(){
        //MARK: - Settings UI
        
        mainView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        mainView.backgroundColor = .white
        
        fullNameOrganization = UILabel(frame: CGRect(x: 20, y: UIScreen.main.bounds.height / 7 , width: view.frame.width - 40 , height: 150))
        fullNameOrganization.textColor = .black
        fullNameOrganization.font = UIFont.systemFont(ofSize: 25)
        fullNameOrganization.numberOfLines = 0
        fullNameOrganization.lineBreakMode = .byWordWrapping
        fullNameOrganization.text = ""
        
        innOrganizationLabel = UILabel(frame: CGRect(x: 20, y: 5 + fullNameOrganization.frame.maxY , width: view.frame.width - 40  , height: 40))
        innOrganizationLabel.textColor = .black
        innOrganizationLabel.font = UIFont.systemFont(ofSize: 20)
        innOrganizationLabel.text = ""

        addressOrganizationLabel = UILabel(frame: CGRect(x: 20, y: 5 + innOrganizationLabel.frame.maxY, width: view.frame.width - 40 , height: 150))
        addressOrganizationLabel.textColor = .black
        addressOrganizationLabel.font = UIFont.systemFont(ofSize: 20)
        addressOrganizationLabel.numberOfLines = 0
        addressOrganizationLabel.lineBreakMode = .byWordWrapping
        
        loadLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height / 3 , width: view.frame.width , height: 150))
        loadLabel.textColor = .black
        loadLabel.font = UIFont.systemFont(ofSize: 30)
        loadLabel.textAlignment = .center
        loadLabel.text = "Загрузка данных"
        
        spinner.isHidden = false
        spinner.color = .black
        spinner.startAnimating()
        spinner.frame = CGRect(x: UIScreen.main.bounds.width / 2  - spinner.frame.height / 2 , y: UIScreen.main.bounds.height / 2, width: 30, height: 20)
        
        reloadButtlon.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 75, y: UIScreen.main.bounds.height / 1.5 , width: 150, height: 50)
        reloadButtlon.isHidden = true
        reloadButtlon.setTitle("Перезагрузить", for: .normal)
        reloadButtlon.backgroundColor = .blue
        reloadButtlon.layer.cornerRadius = 10
        reloadButtlon.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        view.addSubview(mainView)
        mainView.addSubview(fullNameOrganization)
        mainView.addSubview(innOrganizationLabel)
        mainView.addSubview(addressOrganizationLabel)
        mainView.addSubview(spinner)
        mainView.addSubview(loadLabel)
        mainView.addSubview(reloadButtlon)

        notificationCenter.addObserver(self, selector: #selector(loadDataСompleted), name: NSNotification.Name("LoadDataСompleted"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(loadDataError), name: NSNotification.Name("LoadDataError"), object: nil)
    }
    
    @objc func buttonTapped(sender : UIButton) {
        presenter.searchData()
    }
    
    @objc private func loadDataСompleted() {
        
        spinner.isHidden = true
        spinner.stopAnimating()
        loadLabel.isHidden = true
        reloadButtlon.isHidden = true
        
        fullNameOrganization.text = "Название: \(organizationData!.fullNameOrganization)"
        innOrganizationLabel.text = "ИНН: \(organizationData!.innOrganization)"
        addressOrganizationLabel.text = "Адрес: \(organizationData!.addressOrganization)"

    }
    
    @objc private func loadDataError() {
        
        spinner.isHidden = true
        spinner.stopAnimating()
        loadLabel.numberOfLines = 0
        loadLabel.text = "Ошибка. Повторите попытку позже!"
        reloadButtlon.isHidden = false
        view.layoutIfNeeded()
        
    }


}
extension OrganizationDetailViewController: OrganizationDetailPresenterOutput {
    
    func fullSearchResults(searchData: OrganizationFullData) {
        organizationData = searchData
    }
    
}


