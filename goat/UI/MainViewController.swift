//
//  MainViewController.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import UIKit
import CoreLocation

struct MainViewModel {
    
    let viewModels: [WeatherViewModel]
    
    init(weather: OpenWeather) {
        viewModels = weather.daily.compactMap { WeatherViewModel($0) }
    }
}

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let refreshControl = UIRefreshControl()
    
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
        
        refreshControl.addTarget(self, action: #selector(load), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        load()
    }
    
    @objc func load() {
        guard LocationService.shared.isAuthorized else { return }
        refreshControl.beginRefreshing()
        LocationService.shared.delegate = self
        LocationService.shared.getLocation()
    }
    
    func request(coordinates: CLLocationCoordinate2D) {
        WeatherService.shared.get(coordinates: coordinates) { [weak self] weather, error in
            self?.refreshControl.endRefreshing()
            guard let weather = weather, error == nil else {
                // Show some manner of error
                return
            }
            self?.render(weather: weather)
        }
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
        return viewModel.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableCell.reuseIdentifier, for: indexPath) as! WeatherTableCell
        if let viewModel = viewModel?.viewModels[indexPath.row] {
            cell.reload(viewModel: viewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel?.viewModels[indexPath.row] else { return }
        let detailVC = DetailViewController()
        detailVC.reload(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: LocationServiceDelegate {
    
    func didAuthorizeLocationServices(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            load()
            navigationItem.rightBarButtonItem?.isEnabled = false
        default: break
        }
    }
    
    func didUpdateLocation(location: CLLocation) {
        request(coordinates: location.coordinate)
    }
    
}
