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
    var toolbar: UIToolbar!
    var searchBar = UISearchBar()
    var inSearchMode = true
    var collectionViewEnabled = true
    var mediaCV :  UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4)
        layout.minimumInteritemSpacing = 04
        layout.minimumLineSpacing = 04
        layout.invalidateLayout()
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor =  UIColor.white
        cv.register(MediaCell.self, forCellWithReuseIdentifier: reuseId)
        
        return cv
    }()
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
        sc.addTarget(self, action: #selector(typeChange), for: .valueChanged)
        return sc
    }()
    var mediaData = [Any]()
    var search = UISearchController()
    var searchFooterBottomConstraint:NSLayoutConstraint!
    var collectionSizeType:CGSize? = CGSize.init(width: 24, height: 24)
    var client = ClientRequest()
    let refreshControl = UIRefreshControl()
    var isFilter  = 0
    var entity = "all"
    override func viewDidLoad() {
        super.viewDidLoad()
  
        //Configure Media Collection View Cell
        setNavbar()
        setCollectionView()
        search.searchResultsUpdater =  self
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
        definesPresentationContext = true
        search.searchBar.scopeButtonTitles = Media.Category.allCases.map { $0.rawValue }
        search.searchBar.delegate = self
        search.searchBar.selectedScopeButtonIndex = 0
        segment.selectedSegmentIndex = 0
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { (notification) in self.handleKeyboard(notification: notification) }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in  self.handleKeyboard(notification: notification) }
        
        
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
        
       
        collectionSizeType = CGSize(width: ((self.view.frame.width/2) - 6), height: ((self.view.frame.width / 2) - 6))
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
    var isSearchBarEmpty: Bool {
      return search.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      let searchBarScopeIsFiltering = search.searchBar.selectedScopeButtonIndex != 0
      return search.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    func configureSearchBar() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.barTintColor = UIColor.white
        searchBar.tintColor = .black
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
        searchBar.showsCancelButton = true
        collectionViewEnabled = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange")
        let searchText = searchText.lowercased()
        
        if searchText.isEmpty || searchText == " " {
            inSearchMode = false
            
           // mediaCV.reloadData()
        } else {
            inSearchMode = true
            fetchMedia(searchText)
            //mediaCV.reloadData()
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
        
    
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.mediaCV.refreshControl = refreshControl
    }
    @objc func handleRefresh(){
        
        mediaData.removeAll(keepingCapacity: false)
        fetchMedia("")
        mediaCV.reloadData()
        refreshControl.endRefreshing()
    }
    @objc func typeChange(){
        print("segmetn",segment.selectedSegmentIndex.description)
    }
    // MARK: - API
    func fetchMedia(_ searchText:String) {
        if searchText.isEmpty || searchText == " "  {
            print("fetchMedia  : isEmpty")
        }else{
            print("search",isFilter)
            
            var parameters  = [String : String]()
            print(Media.Category.apps)
            var depositAccount = Filters()
            var user = FilterSearch(isActive: true, account: depositAccount)
            print(user)
            let aa = Media.init(name: "apps", category: Media.Category.apps)
            print(aa)
            
            if isFilter == 0{
                parameters  = ["term" : searchText,"entity":entity , "country":"tr","page":"20"]
            }else {
                
            }
               
            print("parameters",parameters)
            if isFiltering {
                print("parameters",parameters)
            } else {
               
            }
            if ConnectNetwork.isConnectedToNetwork() == true {
                client.getParamsRequest(url: Config.Search, parameters: parameters) { data in
                    DispatchQueue.main.async {
                        let result:NSDictionary = data  as NSDictionary.Value as! NSDictionary
//                        print(dataStatus)
                        
                        for (i,x) in result.enumerated(){
//                            print(x)
//
                        }
                        self.mediaCV.reloadData()
                    }
                }
            }
        }
        
    }
    func filterContentForSearchText(_ searchText: String,
                                    category: Media? = nil) {
      
        mediaCV.reloadData()
    }
    
    func handleKeyboard(notification: Notification) {
      // 1
      guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
//        searchFooterBottomConstraint.constant = 0
        view.layoutIfNeeded()
        return
      }
      
      guard
        let info = notification.userInfo,
        let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
          return
      }
      
      // 2
      let keyboardHeight = keyboardFrame.cgRectValue.size.height
      UIView.animate(withDuration: 0.1, animations: { () -> Void in
//        self.searchFooterBottomConstraint.constant = keyboardHeight
        self.view.layoutIfNeeded()
      })
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
         isFilter = searchBar.selectedScopeButtonIndex
    }
}

extension Search : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
 
        let searchText = searchController.searchBar.text!
        DispatchQueue.main.async {
             print("searchText",searchText)
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
        
        return collectionSizeType!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5//mediaData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as? MediaCell{
         
//            let artistName = mediaData[indexPath.item].results[indexPath.row].artistName
//            print(artistName)
            
            
            cell.contentView.backgroundColor = .red
            return cell
        }
         
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}

class MediaCell: UICollectionViewCell{
    let artworkUrl100  : UIImageView = {
           let image  = UIImageView()
            image.backgroundColor = UIColor.white
            image.translatesAutoresizingMaskIntoConstraints = true
            return image
        }()
    var id : String?
    override  init(frame:CGRect) {
        super.init(frame: frame)
        setViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
    func setViews(){
        addSubview(artworkUrl100)
        artworkUrl100.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contentView.frame.width, height: contentView.frame.height)
        
    }
}

