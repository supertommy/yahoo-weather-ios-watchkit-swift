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
    public enum State
    {
        case UNINITIALIZED, LOADING, READY
    }
    
    public typealias OnUpdatedCallback = (data: WeatherData) -> Void
    
    private var _state: State
    public var state: State {
        return _state
    }
    
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
    
    public var city: String {
        if let c = _city
        {
            return c
        }
        return ""
    }
    
    public var region: String {
        if let r = _region
        {
            return r
        }
        return ""
    }
    
    private var _location: String
    private var _name: String?
    private var _temperature: Int?
    private var _unit: String?
    
    private var _city: String?
    private var _region: String?
    
    private var onUpdatedCallbacks: [OnUpdatedCallback]
    
    init(location: String)
    {
        _state = State.UNINITIALIZED
        _location = location
        
        self.onUpdatedCallbacks = []
        
        update()
    }
    
    public func update() -> WeatherData
    {
        if (self.state == State.LOADING)
        {
            return self
        }
        
        self._state = State.LOADING
        
        let query = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(_location)\")"
        
        Craft.promise {
            (resolve: (value: Value) -> (), reject: (value: Value) -> ()) -> () in
            
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            dispatch_async(queue, {
                
                let result = JSON(YQL.query(query))
                
                dispatch_sync(dispatch_get_main_queue(), {
                    let response = result["query"]["results"]["channel"]
                    
                    self._name = response["title"].string
                    self._temperature = response["item"]["condition"]["temp"].intValue
                    self._unit = response["unit"]["temperature"].string
                    
                    self._city = response["location"]["city"].string
                    self._region = response["location"]["region"].string
                    
                    self._state = State.READY
                    
                    for cb in self.onUpdatedCallbacks
                    {
                        cb(data: self)
                    }
                    
                    self.onUpdatedCallbacks.removeAll(keepCapacity: true)
                })
            })
        }

        
        return self
    }
    
    public func then(resolve: OnUpdatedCallback)
    {
        self.onUpdatedCallbacks.append(resolve);
    }
    
}