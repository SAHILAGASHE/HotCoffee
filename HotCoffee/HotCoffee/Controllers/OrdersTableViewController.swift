//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Sahil Agashe on 19/05/23.
//

import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {
    
    // MARK: - Properties
    
    var orderListViewModel = OrderListViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    // MARK: - AddcoffeeOrderDelegate Methods
    
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
        
    }
    
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func populateOrders() {
        
        Webservice().load(resource: Order.all) { [weak self] result in
            
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let addCoffeeOrderVC = navC.viewControllers.first as? AddOrderViewController else {
                  fatalError("Error performing segue!")
              }
        
        addCoffeeOrderVC.delegate = self
    }
    
    
    // MARK: - UITableViewDataSource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        cell.textLabel?.text = vm.type
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        cell.textLabel?.textColor = .blue
        
        cell.detailTextLabel?.text = vm.size
        cell.detailTextLabel?.textColor = .black
        cell.detailTextLabel?.font = .systemFont(ofSize: 18)
        
        
        return cell
        
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66.0
    }
}

