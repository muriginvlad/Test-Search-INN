//
//  OrganizationSearchViewController.swift
//  ru_hire_ios
//
//  Created by Владислав on 10.11.2020.
//

import UIKit


class OrganizationSearchViewController: UIViewController, UISearchBarDelegate {
    
    var presenter: OrganizationSearchPresenterInput! = OrganizationSearchPresenter()
    var organizationData: [OrganizationShortData] = []
    var errorLabelText = ""
    
   public var myTableView: UITableView!
    let notificationCenter = NotificationCenter.default
    let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        presenter.output = self
        
    }
    
    
    func updateUI(){
        //MARK: -Navigation settings UI
        self.navigationItem.title = "Поиск организации"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: -SearchBar settings UI
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите название или ИНН организации"
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
        definesPresentationContext = true

        searchController.searchBar.delegate = self
       // searchController.searchBar.frame = CGRect(x: 0, y: 50, width: searchController.searchBar.frame.width , height: 60)
        self.view.addSubview(searchController.searchBar)
        
        //MARK: -TableView settings UI
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(SearchCell.self, forCellReuseIdentifier: "searchCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    
        //MARK: -Notification
        notificationCenter.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name("LoadСompleted"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(loadError), name: NSNotification.Name("LoadError"), object: nil)
    }
    
}

//MARK: -TableView settings
extension OrganizationSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            var amountCell = 1
            if organizationData.count > 0 {
                amountCell = organizationData.count
            }
            
            return amountCell
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath ) as! SearchCell

                if isFiltering {
                    if organizationData.count == 0 {
                        cell.errorLabel.isHidden = false
                        cell.errorLabel.text = errorLabelText
                    } else {
                        cell.nameOrganizationLabel.text = organizationData[indexPath.row].nameOrganization
                        cell.innOrganizationLabel.text = organizationData[indexPath.row].innOrganization
                    }
                } else {
                    cell.nameOrganizationLabel.isHidden = true
                    cell.innOrganizationLabel.isHidden = true
                }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showDataDetail(inn: organizationData[indexPath.row].innOrganization, fromView: self)
    }
    
    @objc private func reloadTable() {
        myTableView.reloadData()
    }
    
    @objc private func loadError() {
    errorLabelText =  "Ошибка. Повторите попытку позже!"
        myTableView.reloadData()
    }
}

//MARK: -SearchBar settings
extension OrganizationSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("В строку поиска введено \(searchController.searchBar.text!)")
    }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(OrganizationSearchViewController.reload), object: nil)
        self.perform(#selector(OrganizationSearchViewController.reload), with: nil, afterDelay: 0.5)
    }
        
    @objc func reload() {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        print("Начат поиск по параметру \(searchText)")
        if searchController.searchBar.text!.count != 0 {
            presenter.searchData(searchData: searchText)
        }
        myTableView.reloadData()
    }
    
}

extension OrganizationSearchViewController: OrganizationSearchPresenterOutput {
    func updatingSearchResults(newSearchData: [OrganizationShortData]) {
        organizationData = newSearchData
    }
}
