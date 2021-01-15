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

class ClientRequest  {
    
    static let defaultService = ClientRequest()
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
    func  getParamsRequest(url :String,parameters:Parameters  , completion: @escaping (Any?) ->Void)
    {
        Alamofire.request(url   , method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { (response ) in
             
            switch (response.result){
            case .success(_):
                if let data = response.result.value{
                    let jsonObject = data
                    completion((jsonObject))
                }
                break
            case .failure(_):
                break
            }
            return
        })
    }
}
