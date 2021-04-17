//
//  MainViewController.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import UIKit
import CoreLocation

struct MainViewModel {
    
    let dailyConditions: [DailyConditions]
    let cellModels: [WeatherTableCellModel]
    
    init(weather: OpenWeather) {
        dailyConditions = weather.daily.compactMap { $0 }
        cellModels = weather.daily.compactMap { WeatherTableCellModel(conditions: $0) }
    }
}

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        
        view.backgroundColor = .white
        
        let locationRequestButton = UIBarButtonItem(
            title: "Allow Location",
            style: .plain,
            target: self,
            action: #selector(didTapLocationRequest)
        )
        locationRequestButton.isEnabled = !LocationService.shared.isAuthorized
        navigationItem.rightBarButtonItem = locationRequestButton
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeatherTableCell.self, forCellReuseIdentifier: WeatherTableCell.reuseIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        reload()
    }
    
    func reload() {
        guard LocationService.shared.isAuthorized else { return }
        LocationService.shared.delegate = self
        LocationService.shared.getLocation()
    }
    
    func render(weather: OpenWeather) {
        viewModel = .init(weather: weather)
        tableView.reloadData()
    }
    
    @objc func didTapLocationRequest() {
        guard LocationService.shared.isAuthorized == false else { return }
        LocationService.shared.request(delegate: self)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableCell.reuseIdentifier, for: indexPath) as! WeatherTableCell
        if let cellModel = viewModel?.cellModels[indexPath.row] {
            cell.reload(cellModel: cellModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let conditions = viewModel?.dailyConditions[indexPath.row] else { return }
        let detailVC = DetailViewController()
        detailVC.reload(viewModel: .init(conditions: conditions))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: LocationServiceDelegate {
    
    func didAuthorizeLocationServices(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse: navigationItem.rightBarButtonItem?.isEnabled = false
        default: break
        }
    }
    
    func didUpdateLocation(location: CLLocation) {
        WeatherService.shared.get(coordinates: location.coordinate) { [weak self] weather, error in
            guard let weather = weather, error == nil else {
                // Show some manner of error
                return
            }
            self?.render(weather: weather)
        }
    }
    
}
