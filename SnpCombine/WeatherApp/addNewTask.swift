//
//  addNewTask.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 19/09/22.
//

import SnapKit
import UIKit
import Combine

class addNewTask: UIViewController {
    
    private var webservice: WebService = WebService()
    private var cancellable: AnyCancellable?
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Add New City Name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.layer.borderColor = UIColor.systemGray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 8
        tf.textAlignment = .center
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }

        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel).offset(50)
            make.centerX.equalTo(temperatureLabel)
            make.width.equalTo(UIScreen.main.bounds.width-60)
            make.height.equalTo(40)
        }
        
        setupPublishers()
    }
    
    private func setupPublishers() {
        
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self.textField)
        
        self.cancellable = publisher.compactMap {
            ($0.object as! UITextField).text?
                .addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)
        }.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .flatMap { city in
                return self.webservice.fetchWeather(city: city)
                    .catch { _ in Just(Weather.placeholder)}
                    .map{ $0 }
            }.sink {
                
                if let temp = $0.temp {
                    self.temperatureLabel.text = "\(temp) ℃"
                } else {
                    self.temperatureLabel.text = "Add New City Name"
                }
            }
    }
}
