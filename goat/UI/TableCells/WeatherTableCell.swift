//
//  WeatherTableCell.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import UIKit
import SDWebImage

class WeatherTableCell: UITableViewCell {
    
    static let reuseIdentifier = "WeatherTableCell"
    
    let iconImageView = UIImageView()
    
    let leftStackView = UIStackView()
    let dayOfWeekLabel = UILabel()
    let dateLabel = UILabel()
    
    let rightStackView = UIStackView()
    let highTempLabel = UILabel()
    let lowTempLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFill
        contentView.addSubview(iconImageView)
        
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.alignment = .leading
        leftStackView.axis = .vertical
        leftStackView.distribution = .fill
        leftStackView.spacing = 5.0
        contentView.addSubview(leftStackView)
        
        dayOfWeekLabel.font = .systemFont(ofSize: 22.0)
        dayOfWeekLabel.textColor = .black
        dayOfWeekLabel.textAlignment = .left
        leftStackView.addArrangedSubview(dayOfWeekLabel)
        
        dateLabel.font = .systemFont(ofSize: 14.0)
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .left
        leftStackView.addArrangedSubview(dateLabel)
                
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.alignment = .trailing
        rightStackView.axis = .vertical
        rightStackView.distribution = .fill
        rightStackView.spacing = 5.0
        contentView.addSubview(rightStackView)
        
        highTempLabel.font = .systemFont(ofSize: 14.0)
        highTempLabel.textColor = .darkGray
        highTempLabel.textAlignment = .right
        rightStackView.addArrangedSubview(highTempLabel)
        
        lowTempLabel.font = .systemFont(ofSize: 14.0)
        lowTempLabel.textColor = .darkGray
        lowTempLabel.textAlignment = .right
        rightStackView.addArrangedSubview(lowTempLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 44.0),
            iconImageView.heightAnchor.constraint(equalToConstant: 44.0),
            
            leftStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10.0),
            leftStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            leftStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            leftStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            rightStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            rightStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }
    
    func reload(viewModel: WeatherViewModel) {
        iconImageView.sd_setImage(with: viewModel.iconURL)
        dayOfWeekLabel.text = viewModel.dayOfWeek
        dateLabel.text = viewModel.date
        highTempLabel.text = viewModel.highTemp
        lowTempLabel.text = viewModel.lowTemp
    }

}
