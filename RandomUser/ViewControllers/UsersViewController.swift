//
//  UsersViewController.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit
import RealmSwift

class UsersViewController: UIViewController {
    @IBOutlet private weak var savedUserSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var userSearchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private var loadingCellid = "loadingcellid"
    private var searchedUsers: [User] = []
    private var localUsers: [User] = []
    private var savedUsers: [User] = []
    private var isLoadingStarted = true
    private var isSavedUsers = false
    private let pageSize = 20
    private var currentPage = 1
    private var users = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureloadingCell()
        self.view.isLoading = true
        self.getUsersData(with: self.currentPage, completion: { [weak self] in
            self?.isLoadingStarted = true
            self?.currentPage += 1
            self?.hideLoader()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getSavedUsers()
    }
    
    
    // MARK: - Private Methods -
    
    private func configureloadingCell() {
        //Register Loading Cell
        let loadingCellNib = UINib(nibName: LoadingCell.typeName, bundle: nil)
        self.tableView.register(loadingCellNib, forCellReuseIdentifier: self.loadingCellid)
    }
    
    private func getUsersData(with page: Int, completion: @escaping (() -> Void)) {
        self.isLoadingStarted = false
        HTTPClient.getRequest(endpoint: "\(Bundle.InfoPlistKeys.BaseURLs.Development.value)/api?seed=renderforest&results=\(self.pageSize)&page=\(page)") { (_ result: Result<RequestResponse, Error>) in
            switch result {
            case .success(let data):
                completion()
                for user in data.results {
                    self.localUsers.append(user)
                }
                self.users = self.localUsers
                self.hideLoader()
            case .failure(let error):
                debugPrint(error)
                self.getUsersData(with: page, completion: completion)
            }
        }
    }
    
    private func getSavedUsers() {
        let data = AppSettings().realm.objects(UserModel.self)
        let jsonData = try! JSONEncoder().encode(data)
        guard let users = try? JSONDecoder().decode([User].self, from: jsonData) else { return }
        
        self.savedUsers.removeAll()
        for user in users {
            self.savedUsers.append(user)
        }
    }
    
    private func hideLoader() {
        DispatchQueue.main.async {
            self.view.isLoading = false
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.userSearchBar.searchTextField.text.notNil,
              self.userSearchBar.searchTextField.text!.isEmpty else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if isLoadingStarted && !self.isSavedUsers {
                self.getUsersData(with: currentPage, completion: { [weak self] in
                    self?.isLoadingStarted = true
                    self?.currentPage += 1
                })
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isLoadingStarted = true
        self.userSearchBar.endEditing(true)
    }
    
    
    // MARK: - IBAction Methods -
    
    @IBAction private func savedUserSegmentedControlAction(_ sender: UISegmentedControl) {
        self.isSavedUsers = sender.selectedSegmentIndex == 1
        self.users = (self.isSavedUsers ? self.savedUsers : self.localUsers)
    }
}



// MARK: - UISearchBarDelegate -

extension UsersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchTextCount = searchText.count
        let searchTextLowercased = searchText.lowercased()
        let users = (self.isSavedUsers ? self.savedUsers : self.localUsers)
        self.searchedUsers = users.filter({$0.name.first.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                        $0.name.title.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                        $0.name.last.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                        $0.phone.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                        $0.cell.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                        $0.email.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                        $0.location.country.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                        $0.location.street.name.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                        "\($0.location.street.number.as(Int()))".lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                        "\($0.name.first.lowercased()) \($0.name.last.lowercased())".prefix(searchTextCount) == searchTextLowercased})
        self.users = (searchText.isEmpty
                        ? (self.isSavedUsers
                            ? self.savedUsers
                            : self.localUsers)
                        : self.searchedUsers)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.userSearchBar.endEditing(true)
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate -

extension UsersViewController: UITableViewDataSource & UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return self.users.count
        case 1: return (self.isSavedUsers || !self.userSearchBar.text!.isEmpty ? 0 : 1)
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: self.loadingCellid, for: indexPath) as! LoadingCell
            loadingCell.loadingActivityIndicator.startAnimating()
            return loadingCell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.typeName) as? UserTableViewCell else { return UITableViewCell() }

        cell.setData(self.users[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saveAndRemoveUserViewController = UIViewController.App.saveAndRemoveUser.asViewController(SaveAndRemoveUserViewController.self)
        saveAndRemoveUserViewController.user = self.users[indexPath.row]
        self.push(saveAndRemoveUserViewController)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (indexPath.section == 0 ? UITableView.automaticDimension : 100)
    }
}
