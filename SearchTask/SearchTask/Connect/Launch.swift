//
//  Launch.swift
//  SearchTask
//
//  Created by Numan Ayhan on 12.01.2021.
//

import UIKit
import Cartography


class Launch: UIViewController {
    var logo: UILabel = {
        let title  =  UILabel()
        title.textColor = .black
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        return title
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
        setLaunch()
    }
    func setLaunch(){
        view.backgroundColor = .white
        if navigationController != nil{
            
//            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//            navigationController?.navigationBar.shadowImage = UIImage()
//            navigationController?.navigationBar.isTranslucent = true
//            navigationController?.view.backgroundColor = UIColor.clear
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
           
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let  searchSB: UIStoryboard = UIStoryboard(name: "Search", bundle: .main)
            let  searchVC = searchSB.instantiateViewController(withIdentifier: "Search") as? Search
            self.navigationController?.pushViewController(searchVC!, animated: true)
            
        }
    }
}
