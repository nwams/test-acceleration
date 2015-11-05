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
    
    lazy var motionManager = CMMotionManager()
    var currentMaxAccelX: Double = 0;
    var currentMaxAccelY: Double = 0;
    var currentMaxAccelZ: Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //checking if Accelerometer is available
//        let manager = CMMotionManager()
//        
//        if manager.accelerometerAvailable {
//            manager.accelerometerUpdateInterval = 0.1
//            
//            //Starting Updates to “pull” Data
//            //after this call, manager.accelerometerData is accessible at any time with the device’s current accelerometer data.
//            manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
//                [weak self] (data, error) in
//                
//                self!.outputAccelertionData(data!.acceleration)
//                
//                if (error != nil) {
//                    print(error)
//                }
//            }
//            
//            
//        }
        
        if motionManager.accelerometerAvailable {
            let queue = NSOperationQueue()
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler: {
                data, error in
                guard let data = data else{
                    return
                }
                    
                    print("X = \(data.acceleration.x)")
                    print("Y = \(data.acceleration.y)")
                    print("Z = \(data.acceleration.z)")
                    
                self.xAccel.text = String(data.acceleration.x)
                self.yAccel.text = String(format: "%.5f", data.acceleration.y)
                self.zAccel.text = String(format: "%.5f", data.acceleration.z)

                }
            )
        } else {
            print("Accelerometer is not available")
        }
    }
    
    func outputAccelertionData(acceleration: CMAcceleration) {
        print ("hello")
        xAccel.text = String(format: "%.2f", acceleration.x)
        print (xAccel)
        
        if fabs(acceleration.x) > fabs(currentMaxAccelX) {
            currentMaxAccelX = acceleration.x
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}