//
//  ViewController.swift
//  RESTfulService
//
//  Created by Mert Ziya on 7.01.2025.
//

import UIKit

class SearchVC: UIViewController{
    
    
    // MARK: - UI Components:
    let tableView = UITableView()
    
    // MARK: - Properties:
    let searchVM = SearchVM()
    var songs : [Song] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // for searching with the 1 seconds delay to improve performance. Sending too many requests is not a good idea.
    var isSearching = false
    
    
    // MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()

        searchVM.delegate = self
        
        setupUI()
        
        searchVM.loginUser(email: "tester@gmail.com", password: "123456789")
                
        setupNav()
        
    }
    
}




// MARK: - Acts like bindings
extension SearchVC: ExerciseDelegate{
    func didSearchSongs(songs: [Song]) {
        self.songs = songs
    }
    
    func didReturnJWTToken(token: String) {
        UserDefaults.standard.set(token, forKey: "Token")
    }
    
    func didFailWithError(error: any Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}




// MARK: - UI Configurations:
extension SearchVC : UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
    
    // MARK: - Table Cell:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongTableCell else{
            print("DEBUG: Song Cell Error")
            return UITableViewCell()
        }
        
        cell.artistName.text  = songs[indexPath.row].mainArtistName
        cell.songName.text = songs[indexPath.row].songName
        
        ImageLoadService.loadImage(urlString: songs[indexPath.row].albumImg) { albumImage in
            DispatchQueue.main.async {
                cell.albumImage.image = albumImage
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SongDetailsVC()
        vc.selectedSong = songs[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table Header:
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let searchBar = tableView.dequeueReusableHeaderFooterView(withIdentifier: "searchBar") as? SongTableHeader else{
            print("DEBUG: Header Error")
            return UIView()
        }
        
        searchBar.searchBar.delegate = self
        searchBar.searchBar.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
            
        return searchBar
    }
    
    
    // Hide Keyboard logic:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = "Search"

    }
    func textFieldEndsEditing(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        
        //** THIS STATEMENT IS REAAAAALY IMPORTANT SINCE 2 Gestures or actions might intersect. We need to use it here
        gesture.cancelsTouchesInView = false
        //** If we didn't use it we would not be able to select the cell we want to select because it would identify it as we are clicking on the view
        //          instead of the cell. Always use it if you are working with ___**!! INTERSACTING GESTURES !!**__
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
    }
    @objc func hidekeyboard(){
        view.endEditing(true)
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    
    
    private func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SongTableCell", bundle: nil), forCellReuseIdentifier: "songCell")
        tableView.register(SongTableHeader.self, forHeaderFooterViewReuseIdentifier: "searchBar")
        
        tableView.showsVerticalScrollIndicator = false
                
        textFieldEndsEditing()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}




// MARK: - Actions:
extension SearchVC{
    private func showAlert(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        alert.modalPresentationStyle = .popover
        show(alert, sender: nil)
    }
    
    // This code block is triggered every time user types or deleted a value at at the search bar.
    @objc private func textChanged(_ tf : UITextField){
        if let searchValue = tf.text , !isSearching{
            isSearching = true
            self.searchVM.searchSongs(name: searchValue)
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                self.isSearching = false
            }
        }
    }
    
    private func setupNav(){
        navigationItem.title = "SPOTI SEARCH"
        
    }
    
}
