//
//  StockViewController.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-12.
//

import UIKit

class StockViewController: UIViewController {
    
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
        setupView()
        
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
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

extension StockViewController: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}
