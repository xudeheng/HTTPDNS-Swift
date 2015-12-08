//
//  HTTPDNS.swift
//  HTTPDNS-SwiftDemo
//
//  Created by YourtionGuo on 12/4/15.
//  Copyright © 2015 Yourtion. All rights reserved.
//

import Foundation

struct DNSRecord {
    let ip : String
    let ttl : Int
    let ips : Array<String>
}

class HTTPDNS {
    private let SERVER_ADDRESS = "http://119.29.29.29/"
    private var cache = Dictionary<String,DNSRecord>()
    
    static let sharedInstance = HTTPDNS()
    
    func getRecordSync(domain: String) -> DNSRecord! {
        let res = self.cache[domain]
        if (res != nil){
            return res!
        } else {
            requsetRecord(domain)
            return nil
        }
    }
    
    func requsetRecord(domain: String) {
        let urlString = self.SERVER_ADDRESS + "d?dn=" + domain + "&ttl=1"
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            if let data = data {
                let res = self.parseResult(data)
                if (res.ipList.count > 0) {
                    let record = DNSRecord.init(ip: res.ipList[0], ttl: res.ttl, ips: res.ipList)
                    self.cache.updateValue(record, forKey: domain)
                    print(self.cache)
                }
            }
        }
        
        task.resume()
    }
    
    func parseResult (data: NSData) -> (ipList: Array<String>, ttl: Int){
        let str = String(data: data, encoding: NSUTF8StringEncoding)
        let strArray = str!.componentsSeparatedByString(",")
        let ttl = Int(strArray[1])
        let ipStr = strArray[0] as String
        let ipList = ipStr.componentsSeparatedByString(";") as Array<String>
        print(ipList, ttl)
        if (ipList.count > 0 && ttl > 0){
            return (ipList,ttl!)
        }
        return ([],0)
    }
    
    
}