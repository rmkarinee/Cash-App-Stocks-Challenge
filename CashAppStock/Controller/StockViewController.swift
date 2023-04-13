//
//  StockViewController.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-12.
//

import UIKit

class StockViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var serviceManager = ServiceManager()
    
    var stockList: [StockItem] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        serviceManager.requestStock(completion: handleRequestSuccess(data:))
    }
    
    func registerCell() {
        self.tableView.register(StockTableViewCell.nib(), forCellReuseIdentifier: StockTableViewCell.identifier)
    }
    
    func handleRequestSuccess(data: StockModel) {
        stockList = data.stocks
    }
}

//MARK:: TableView Delegate and DataSource
extension StockViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockTableViewCell {
            cell.layer.borderWidth = 1
            cell.selectionStyle = .none
            cell.setUpCell(stockList[indexPath.row])
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
}
