//
//  DetailViewController.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
 
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let imageView = UIImageView()
    let dateLabel = UILabel()
    let descriptionLabel = UILabel()
    let tempLabel = UILabel()
    let humidityLabel = UILabel()
    let windspeedLabel = UILabel()
    let sunriseLabel = UILabel()
    let sunsetLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10.0
        scrollView.addSubview(stackView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        stackView.addArrangedSubview(imageView)
        
        dateLabel.font = .systemFont(ofSize: 14.0)
        dateLabel.textColor = .darkGray
        stackView.addArrangedSubview(dateLabel)
        stackView.setCustomSpacing(30.0, after: dateLabel)
        
        descriptionLabel.font = .systemFont(ofSize: 24.0)
        descriptionLabel.textColor = .black
        stackView.addArrangedSubview(descriptionLabel)
        
        tempLabel.font = .systemFont(ofSize: 14.0)
        tempLabel.textColor = .black
        stackView.addArrangedSubview(tempLabel)
        
        humidityLabel.font = .systemFont(ofSize: 14.0)
        humidityLabel.textColor = .black
        stackView.addArrangedSubview(humidityLabel)
        
        windspeedLabel.font = .systemFont(ofSize: 14.0)
        windspeedLabel.textColor = .black
        stackView.addArrangedSubview(windspeedLabel)
        
        sunriseLabel.font = .systemFont(ofSize: 14.0)
        sunriseLabel.textColor = .black
        stackView.addArrangedSubview(sunriseLabel)
        
        sunsetLabel.font = .systemFont(ofSize: 14.0)
        sunsetLabel.textColor = .black
        stackView.addArrangedSubview(sunsetLabel)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 100.0),
            imageView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }
    
    func reload(viewModel: WeatherViewModel) {
        imageView.sd_setImage(with: viewModel.iconURL)
        dateLabel.text = "\(viewModel.dayOfWeek), \(viewModel.date)"
        descriptionLabel.text = viewModel.description.capitalized
        tempLabel.text = "\(viewModel.highTemp) / \(viewModel.lowTemp)"
        humidityLabel.text = viewModel.humidity
        windspeedLabel.text = viewModel.windSpeed
        sunriseLabel.text = viewModel.sunrise
        sunsetLabel.text = viewModel.sunset
    }
    
}
