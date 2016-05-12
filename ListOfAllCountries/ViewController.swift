//
//  ViewController.swift
//  RandomUserInfo
//
//  Created by N. M. Ali Hayder on 5/12/16.
//  Copyright © 2016 N. M. Ali Hayder. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var countryNames = [String]()
    var numOfRows = 0
    
    
    
    
    func loadCountries(urlPath: String){
        
        Alamofire.request(.GET, urlPath)
            .responseJSON{response in
                
                if let value = response.result.value{
                    let json = JSON(value)
                    //print(json)
                    
                    for (_, value) in json {
                        
                        
                        //print("\(value["name"])")
                        
                        let cname = value["name"].stringValue
                        
                        
                        self.countryNames.append(cname)
                        self.numOfRows += 1;
                        
                    }
                    
                    
                }
                
                self.doTableRefresh()
                
                
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadCountries("https://restcountries.eu/rest/v1/all")
        print("\(countryNames)")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return numOfRows    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
        cell.textLabel?.text = self.countryNames[indexPath.row]
        
        return cell
    }
    
    func doTableRefresh(){
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    
    
}

