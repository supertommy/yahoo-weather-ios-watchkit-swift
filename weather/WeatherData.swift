//
//  WeatherData.swift
//  weather
//
//  Created by Tommy Leung on 3/14/15.
//  Copyright (c) 2015 Tommy Leung. All rights reserved.
//

import Foundation

public class WeatherData
{
    public var name: String {
        if let s = _name
        {
            return s
        }
        return ""
    }
    
    public var temperature: Int {
        if let t = _temperature
        {
            return t
        }
        return -1
    }
    
    public var unit: String {
        if let u = _unit
        {
            return u
        }
        return "F"
    }
    
    private var _location: String
    private var _name: String?
    private var _temperature: Int?
    private var _unit: String?
    
    init(location: String)
    {
        _location = location
        
        update()
    }
    
    public func update()
    {
        let query = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(_location)\")"
        let result = JSON(YQL.query(query))
        
        let response = result["query"]["results"]["channel"]
        
        _name = response["title"].string
        _temperature = response["item"]["condition"]["temp"].intValue
        _unit = response["unit"]["temperature"].string
    }
}