//
//  ApiServices.swift
//  SwapiSwiftMVC
//
//  Created by mac on 13/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiServices {
    private init() {}
    static let sharedInstance = ApiServices();
    
    private let queue = DispatchQueue(label: Constants.LABEL_TEXT, qos: .background, attributes: [DispatchQueue.Attributes.concurrent])
    
    func alomofireGet(URL: String, onCompletion: @escaping ((Data) -> Void), onError: @escaping ((String)-> Void)) {
        
        AF.request(URL, method: .get, headers: nil ).response(queue: queue) { data in
            if data.response?.statusCode == 200 {
//                let json = JSON(String(data: data.data!, encoding: .utf8)!)
                onCompletion(data.data!)
            } else {
                onError("Connection Error")
            }
        }
    }
}
