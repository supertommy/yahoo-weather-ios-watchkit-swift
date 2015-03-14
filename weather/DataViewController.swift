//
//  DataViewController.swift
//  weather
//
//  Created by Tommy Leung on 3/14/15.
//  Copyright (c) 2015 Tommy Leung. All rights reserved.
//

import UIKit

class DataViewController: UIViewController
{
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherData: WeatherData?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        reload()
    }

    func reload()
    {
        if let d = weatherData
        {
            self.dataLabel.text = d.name
            self.temperatureLabel.text = "\(d.temperature)\(d.unit)"
        }

    }

}

