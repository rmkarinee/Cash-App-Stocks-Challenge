//
//  StockViewController.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-12.
//

import UIKit

class StockViewController: UIViewController {
    
    var stockList: [StockItem] = []
    var viewModel = StockViewModel()
    var serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerCell()
        viewModel.requestStocks()
        viewModel.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    
    func registerCell() {
        self.tableView.register(StockTableViewCell.nib(), forCellReuseIdentifier: StockTableViewCell.identifier)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}

extension StockViewController: StockViewModelDelegate {
    func didFinishRequest() {
        stockList = viewModel.stockItems
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK:: TableView Delegate and DataSource
extension StockViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItens()
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
