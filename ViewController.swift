//
//  ViewController.swift
//  MVVM_Example
//
//  Created by ajay on 09/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    
    var cartVM = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTableView.register(UINib(nibName: "CartTVCell", bundle: nil), forCellReuseIdentifier: "CartTVCell")
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        
        self.getCartData()
        
    }

    func getCartData() {
        
        self.cartVM.tableViewReload = {
            DispatchQueue.main.async {
                self.cartTableView.reloadData()
            }
        }
        
        self.cartVM.showError = {
            DispatchQueue.main.async {
                self.showAlert("Oops!, something went wrong.")
            }
        }
        
        self.cartVM.showLoader = {
            DispatchQueue.main.async {
                CustomActivityIndicator.shared.startAnimating()
            }
        }
        
        self.cartVM.hideLoader = {
            DispatchQueue.main.async {
                CustomActivityIndicator.shared.stopAnimating()
            }
        }
        
        self.cartVM.getCartData()
    }
    
    @IBAction func btn_submitAction(_ sender: Any) {
        
        print("Final cart")
        print(self.cartVM.cartData)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartVM.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVCell", for: indexPath) as! CartTVCell
        
        let data = self.cartVM.getCartViewModelData(indexPath: indexPath)
        cell.setupUI(data: data)
        
        cell.finalCount = { count in
            self.cartVM.cartData[indexPath.row].count = count
        }
        
        return cell
    }

}
