//
//  ViewController.swift
//  V.I.C
//
//  Created by Ruiqing Qiu on 5/2/16.
//  Copyright © 2016 Ruiqing Qiu. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class ViewController: UIViewController {

    var socket: SocketIOClient?

    @IBOutlet var EnterMessage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        socket = SocketIOClient(socketURL: NSURL(string:"http://localhost:8000")!)
        addHandlers()
        socket!.connect()

    }
    @IBOutlet var TextField: UITextField!
    @IBAction func EnterMessageClicked(sender: AnyObject) {
        print("button clicked")
        print(TextField.text)
        socket?.emit("chat message", TextField.text!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addHandlers() {
        print(socket)
        socket?.on("chat message"){[weak self] data, ack in
            print(data)
    }
        
//        socket?.on("sendMessage") {[weak self] data, ack in
//            self?.handleStart()
//            return
//        }
    }


}

