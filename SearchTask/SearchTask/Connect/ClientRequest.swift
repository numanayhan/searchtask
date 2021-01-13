//
//  ClientRequest.swift
//  SearchTask
//
//  Created by Melike Büşra Ayhan on 9.01.2021.


import Foundation
import UIKit
import Alamofire

protocol RequestDataDelegate {
    func didCompleteRequest(result: String)
}

class Request  {
    
    static let defaultService = Request()
    var delegate = RequestDataDelegate.self
    func  postParamsRequest(url :String,parameters:Parameters  , completion: @escaping (Any?) ->Void)
    {
       
        Alamofire.request(url, method: .post, parameters: parameters  , encoding: URLEncoding(destination: .queryString)).responseJSON(completionHandler: { (response ) in
            switch (response.result){
            case .success(_):
                if let data = response.result.value{
                    let jsonObject:NSDictionary = data as! NSDictionary
                    completion((jsonObject))
                }
                break
            case .failure(_):
                 break
            }
            return
        })
    }
    func  getRequest(api :String  , completion: @escaping (Any?) ->Void)
    {
        
        Alamofire.request(api , method: .get, encoding: URLEncoding.default).responseJSON(completionHandler: { (response ) in
            switch (response.result){
            case .success(_):
                if let data = response.data{
                    completion((data))
                }
                break
                
            case .failure(_):
                if let data = response.result.value{
                    let jsonObject:NSDictionary = data as! NSDictionary
                    completion((jsonObject))
                }
                break
            }
            return
            
        })
    }
}
