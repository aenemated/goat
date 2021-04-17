//
//  DetailViewController.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import UIKit

struct DetailViewModel {
    
    let description: String
    let icon: URL?
    
    init(conditions: DailyConditions) {
        self.description = conditions.weather.first?.description ?? "No description available."
        self.icon = conditions.weather.first?.iconURL
    }
}

class DetailViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func reload(viewModel: DetailViewModel) {
        
    }
    
}
