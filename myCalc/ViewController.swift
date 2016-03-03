//
//  ViewController.swift
//  myCalc
//
//  Created by MqxError on 2/8/16.
//  Copyright © 2016 MqxError. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    enum operation:String {
        case Divide    = "/"
        case Multiply  = "*"
        case Add       = "+"
        case Substract = "-"
        case Empty     = "Empty"
    
    }
    
    
    @IBOutlet weak var OutputLbl:UILabel!
    
    var btnSound:AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOpperation = operation.Empty
    var result = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OutputLbl.text = ""
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL.fileURLWithPath(path!)
        do{
           try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
               btnSound.prepareToPlay()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func NumberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        OutputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation.Multiply)
    }
    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(operation.Substract)
    }
    @IBAction func onAddedPressed(sender: AnyObject) {
        processOperation(operation.Add)
    }
    @IBAction func OnEqualPressed(sender: AnyObject){
        processOperation(currentOpperation)
    }
    
    func processOperation(op: operation){
        playSound()
        if currentOpperation != operation.Empty
        {   //logic goes here
            
            if runningNumber != ""
            {
                rightValStr = runningNumber
                runningNumber = ""
                if currentOpperation == operation.Divide{
                    result = "\(Double(leftValStr)! /  Double(rightValStr)!)"
                }
                else if currentOpperation == operation.Add{
                    result = "\(Double(leftValStr)! +  Double(rightValStr)!)"
                }
                else if currentOpperation == operation.Multiply{
                    result = "\(Double(leftValStr)! *   Double(rightValStr)!)"
                }
                else if currentOpperation == operation.Substract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                OutputLbl.text = result
        
            }
            currentOpperation = op
        }
            
            else
            {
                leftValStr = runningNumber
                runningNumber = ""
                currentOpperation = op
            }

            
            }
    
    
    func playSound(){
        if btnSound.playing
        {btnSound.stop()}
        btnSound.play()
    }
    
    
    
    
    
    
    
}

