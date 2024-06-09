//
//  CartViewModel.swift
//  MVVM_Example
//
//  Created by ajay on 09/06/24.
//

import Foundation

class CartViewModel {
    
    var cartData = [CartModel]()
    
    private var cartCellViewModel = [CartCellViewModel]() {
        didSet {
            self.tableViewReload?()
        }
    }
    
    var tableViewReload: (()->())?
    var showError: (()->())?
    var showLoader: (()->())?
    var hideLoader: (()->())?
    
    func getCartData() {
        
        self.showLoader?()
        APIManager.getDataFromServer { (success, data) in
            self.hideLoader?()
            if success {
                self.createCartCell(data: data!)
            } else {
                self.showError?()
            }
        }
    }
    
    func createCartCell(data: [CartModel]) {
        
        self.cartData = data
        
        var vm = [CartCellViewModel]()
        
        for cartData in data {
            vm.append(CartCellViewModel(productName: cartData.product_name!, count: cartData.count!))
        }
        
        self.cartCellViewModel = vm
    }
    
    var numberOfRows: Int {
        return self.cartCellViewModel.count
    }
    
    func getCartViewModelData(indexPath: IndexPath) -> CartCellViewModel {
        return self.cartCellViewModel[indexPath.row]
    }
}

struct CartCellViewModel {
    
    var productName: String
    var count: Int
}
