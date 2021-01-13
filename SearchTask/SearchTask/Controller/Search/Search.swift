//
//  Search.swift
//  SearchTask
//
//  Created by Melike Büşra Ayhan on 9.01.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import Network
private let reuseId  = "MediaCell"

class Search: UIViewController {
    var isDark : Bool = true {
        didSet{
            setNeedsStatusBarAppearanceUpdate()
            
        }
    }
    var searchBar = UISearchBar()
    var inSearchMode = false
    var collectionViewEnabled = true
    var mediaCV :  UICollectionView!
    lazy var filterView: UIView = {
       var view = UIView()
        return view
        
    }()
    
    lazy var segment : UISegmentedControl = {
        let filterTabs = ["Movies", "Music", "Apps","Books"]
        var sc = UISegmentedControl(items: filterTabs)
        sc.selectedSegmentIndex = 0
        let frame = UIScreen.main.bounds
        sc.frame = CGRect(x: frame.minX + 10, y: frame.minY + 50,  width: frame.width - 20, height: frame.height*0.1)
        sc.layer.cornerRadius = 5.0
        sc.backgroundColor = UIColor.black
        sc.tintColor = UIColor.white
        return sc
    }()
    var mediaData = [Media]()
    var search = UISearchController()
    var isSearchBarEmpty: Bool {
        return search.searchBar.text?.isEmpty ?? true
         
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        //Configure Media Collection View Cell
        //setCollectionView()
        setNavbar()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if navigationController != nil{
            view.backgroundColor = .white
            self.navigationItem.setHidesBackButton(true, animated: true)
             
        }
    }
    func setNavbar(){
        if navigationController != nil{
            title = "App Store"
            navigationItem.searchController = UISearchController(searchResultsController: self)
            search = UISearchController(searchResultsController: nil)
            search.searchResultsUpdater = self
            search.obscuresBackgroundDuringPresentation = false
            search.searchBar.placeholder = "Search"
            definesPresentationContext = true
            navigationItem.searchController = search
            setFilterBar()
        }
    }
    
    func setFilterBar(){
        
    }
    func setCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical 
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height )
        
        mediaCV = UICollectionView(frame: frame, collectionViewLayout: layout)
        mediaCV.delegate = self
        mediaCV.dataSource = self
        mediaCV.alwaysBounceVertical = true
        mediaCV.backgroundColor = .white
        mediaCV.register(MediaCell.self, forCellWithReuseIdentifier: reuseId)
        
        view.addSubview(mediaCV)
        mediaCV.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        
        setRefreshControl()
        
    }
    // MARK: - UISearchBar

    func configureSearchBar() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.barTintColor = UIColor.white
        searchBar.tintColor = .black
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        fetchMedia()
        mediaCV.isHidden = true
        collectionViewEnabled = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText.lowercased()
        
        if searchText.isEmpty || searchText == " " {
            inSearchMode = false
            mediaCV.reloadData()
        } else {
            inSearchMode = true
            
            mediaCV.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = nil
        inSearchMode = false
        collectionViewEnabled = true
        mediaCV.isHidden = false
        mediaCV.reloadData()
    }
  
    @objc func setRefreshControl(){
    let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.mediaCV.refreshControl = refreshControl
    }
    @objc func handleRefresh(){
        mediaData.removeAll(keepingCapacity: false)
        fetchMedia()
        mediaCV?.reloadData()
    }
    // MARK: - API
    func fetchMedia() {
     
    }
    
}
extension Search : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
 
        let searchText = searchController.searchBar.text!
        DispatchQueue.main.async {
//             print("searchText",searchText)
        }
    }
}
extension Search : UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5//mediaData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as? MediaCell{
         
            let artistName = mediaData[indexPath.item].results[indexPath.row].artistName
            print(artistName)
            cell.contentView.backgroundColor = .red
            return cell
        }
         
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}
