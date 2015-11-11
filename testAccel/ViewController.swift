//
//  ViewController.swift
//  testAccel
//
//  Created by Nwamaka Nzeocha on 10/25/15.
//  Copyright © 2015 Nwamaka Nzeocha. All rights reserved.
//

import UIKit
import Foundation
import CoreMotion


class ViewController: UIViewController {
    @IBOutlet weak var xAccel: UILabel!
    @IBOutlet weak var yAccel: UILabel!
    @IBOutlet weak var zAccel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var motionManager : CMMotionManager!
    var queue : NSOperationQueue!
    
    // timer stuff
    var masterTimer: NSTimer? = nil
    var timeLeft = 1 //default number of seconds left
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate these objects to get them ready to use
        motionManager = CMMotionManager()
        queue = NSOperationQueue()
        }
    
    
    @IBAction func startButtonPressed(sender: AnyObject) {
        // set the number of times the device should update motion data (in seconds)
        // since 1 / 0.01 will give 100 data points per second
        motionManager.deviceMotionUpdateInterval = 0.01
        
        
        //start timer that calls countDown every second
        self.masterTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
}
    
    
    func countDown(){
        var valX: Double!
        var valY: Double!
        var valZ: Double!
        var outputRow: String!
        var myArray = [String]()
        
        --timeLeft //take a second away
        if (timeLeft >= 0)
        {
            //update the label if the timeleft is greater than 0
            self.timerLabel.text = String(timeLeft)
            
            // start receiving data by instructing the CMMotionManager object, motionManager, to send us the data
            // give it the handler, "data", to trigger when data is available
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler: { data, error in
                
                guard let data = data else{
                    return
                }
                valX = data.acceleration.x
                valY = data.acceleration.y
                valZ = data.acceleration.z

                outputRow = "\(valX)" + ",\(valY)" + ",\(valZ)"
                print (outputRow)

                myArray.append(outputRow)
            })
        } else {
            self.timerLabel.text = "Done!" //otherwise let the user know and update the label
            self.masterTimer!.invalidate() //get rid of timer - game over no longer needed to fire
            self.masterTimer = nil
            self.motionManager.stopAccelerometerUpdates()
            print ("myArray = \(myArray)")
        }
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        // Important. Stop data collection if the view becomes inactive
        // if not, it can sit here, chewing up resources on the phone
        self.motionManager.stopAccelerometerUpdates()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}