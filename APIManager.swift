//
//  APIManager.swift
//  MVVM_Example
//
//  Created by ajay on 09/06/24.
//

import Foundation

public struct APIManager {
    
    static func getDataFromServer( complete: @escaping (_ success: Bool, _ data: [CartModel]? )->() ){
        DispatchQueue.global().async {
            sleep(2)
            var dummyData: [CartModel] = [CartModel]()
            for i in 0...20 {
                dummyData.append(CartModel(product_name: "Prodct \(i+1)", count: 0))
            }
            complete(true, dummyData)
            // If server gives an error, use "complete(false, nil)"
        }
    }
}
