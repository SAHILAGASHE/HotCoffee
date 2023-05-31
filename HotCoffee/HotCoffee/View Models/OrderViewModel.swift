//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by Sahil Agashe on 19/05/23.
//

import Foundation

// MARK: - OrderListViewModel

class OrderListViewModel {
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
    
}


// MARK: - OrderViewModel

struct OrderViewModel {
    let order:Order
}

extension OrderViewModel {
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
}
