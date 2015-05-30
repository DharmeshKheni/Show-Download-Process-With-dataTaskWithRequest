//
//  ViewController.swift
//  testing
//
//  Created by Anil on 30/05/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController,NSURLSessionDelegate,NSURLSessionDataDelegate{
    
    @IBOutlet weak var progress: UIProgressView!
    
    var buffer:NSMutableData = NSMutableData()
    var session:NSURLSession?
    var dataTask:NSURLSessionDataTask?
    let url = NSURL(string:"http://i.stack.imgur.com/b8zkg.png" )!
    var expectedContentLength = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress.progress = 0.0
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let manqueue = NSOperationQueue.mainQueue()
        session = NSURLSession(configuration: configuration, delegate:self, delegateQueue: manqueue)
        dataTask = session?.dataTaskWithRequest(NSURLRequest(URL: url))
        dataTask?.resume()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        NSLog("%@",response.description)   // delete this line
        //here you can get full lenth of your ?content
        expectedContentLength = Int(response.expectedContentLength)
        println(expectedContentLength)
        completionHandler(NSURLSessionResponseDisposition.Allow)
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        

        buffer.appendData(data)
        
        let percentageDownloaded = Float(buffer.length) / Float(expectedContentLength)
        progress.progress =  percentageDownloaded
    }
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        //use buffer here.Download is done
        progress.progress = 1.0   // download 100% complete   ok now
    }
}

