//
//  CartTVCell.swift
//  MVVM_Example
//
//  Created by ajay on 09/06/24.
//

import UIKit

class CartTVCell: UITableViewCell {

    @IBOutlet weak var lbl_product: UILabel!
    @IBOutlet weak var stackView_cart: UIStackView!
    @IBOutlet weak var lbl_count: UILabel!
    
    var cartData: CartCellViewModel?
    
    var finalCount: ((_ count: Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.stackView_cart.layer.cornerRadius = 8
        self.stackView_cart.layer.borderColor = UIColor.black.cgColor
        self.stackView_cart.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI(data: CartCellViewModel) {
        
        self.cartData = data
        
        self.lbl_product.text = self.cartData?.productName
        self.lbl_count.text = "\(self.cartData?.count ?? 0)"
        
    }
    
    @IBAction func btn_minusAction(_ sender: Any) {
        
        guard let count = self.cartData?.count else { return }
        
        self.cartData?.count = count > 0 ? count - 1 : 0
        self.lbl_count.text = "\(self.cartData?.count ?? 0)"
        
        self.finalCount?(self.cartData?.count ?? 0)
    }
    
    @IBAction func btn_plusAction(_ sender: Any) {
        
        self.cartData?.count += 1
        self.lbl_count.text = "\(self.cartData?.count ?? 0)"
        self.finalCount?(self.cartData?.count ?? 0)
    }
    
}
