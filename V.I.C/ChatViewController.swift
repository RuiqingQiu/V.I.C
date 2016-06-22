//
//  ChatViewController.swift
//  V.I.C
//
//  Created by Ruiqing Qiu on 6/22/16.
//  Copyright © 2016 Ruiqing Qiu. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIGestureRecognizerDelegate {
    var chatMessagesCount = 0;
    var chatMessages = [String]()
    var socket: SocketIOClient?


    @IBOutlet var TextField: UITextField!
    @IBOutlet var SendMessage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.TableView.reloadData()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        socket = SocketIOClient(socketURL: NSURL(string:"http://localhost:8000")!)
        addHandlers()
        socket!.connect()

    }

    @IBAction func SendMessageClicked(sender: AnyObject) {
        print("button clicked")
        print(TextField.text)
        socket?.emit("chat message", TextField.text!)
    }
    @IBOutlet var TableView: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addHandlers() {
        print(socket)
        socket?.on("chat message"){[weak self] data, ack in
            print(data[0])
            self!.chatMessages.append(data[0] as! String)
            self!.chatMessagesCount = self!.chatMessagesCount + 1
            self?.TableView.reloadData()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configureTableView() {
        TableView.delegate = self
        TableView.dataSource = self
        self.TableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")

    }
    
    
    // MARK: UITableView Delegate and Datasource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessagesCount
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        print("in here")
        cell.textLabel!.text = chatMessages[indexPath.row]
        
        return cell
    }


}
