//
//  YQL.swift
//  weather
//
//  Created by Tommy Leung on 3/14/15.
//  Copyright (c) 2015 Tommy Leung. All rights reserved.
//

import Foundation

public class YQL
{
    private class var prefix: String {
        return "http://query.yahooapis.com/v1/public/yql?q="
    }
    
    private class var suffix: String {
        return "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=";
    }
    
    public class func query(statement: String) -> NSDictionary
    {
        let query = "\(prefix)\(statement.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)!)\(suffix)"
        
        let jsonData = String(contentsOfURL: NSURL(string: query)!, encoding: NSUTF8StringEncoding, error: nil)?.dataUsingEncoding(NSUTF8StringEncoding)
        
        var result = { _ -> NSDictionary in
            if let data = jsonData
            {
                var error: NSError?
                
                return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
            }
            
            return NSDictionary()
        }()
        
        return result;
    }
}