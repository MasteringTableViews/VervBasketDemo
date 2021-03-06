//
//  CheckoutVC.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import UIKit

protocol CheckoutVCDelegate: class {
    func reloadData()
}

class CheckoutVC: UIViewController, CheckoutVCDelegate {
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var totalPrice = "Total price: "
    
    var model: CheckoutVCModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let price = model?.basket.totalPriceAndCurrencyString {
            totalPriceLabel.text = totalPrice + price
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            if let price = self?.model?.basket.totalPriceAndCurrencyString, let totalPrice = self?.totalPrice {
                self?.totalPriceLabel.text = totalPrice + price
            }
        }
    }
}

extension CheckoutVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.allCurrencies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        cell.textLabel?.text = model?.allCurrencies?[indexPath.row].uid
        return cell
    }
}

extension CheckoutVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model?.changeToCurrency(atIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
