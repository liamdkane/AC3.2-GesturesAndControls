//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var winningColor: UIColor? {
        willSet {
            winningColorLabel.text = "This is your current winning color"
        }
    }
    var losingColor: UIColor? {
        willSet {
            losingColorLabel.text = "This is your current losing color"
        }
    }
    var winningNumber: Double? {
        willSet {
            winningNumberLabelView.text = "It will take \(Int(newValue!)) correct answers to win"
        }
    }
    var losingNumber: Double? {
        willSet {
            winningNumberLabelView.text = "You have \(Int(newValue!)) tries to win"
        }
    }
    
    @IBOutlet weak var winningColorLabel: UILabel!
    @IBOutlet weak var losingColorLabel: UILabel!
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var currentColorView: UIView!
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var stepperView: UIStepper!
    @IBOutlet weak var winningNumberLabelView: UILabel!
    @IBOutlet weak var resetScoreToggleLabelView: UILabel!
    @IBOutlet weak var winningOrLosingSegmentedControlView: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentColorView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func winningOrLosing(_ sender: UISegmentedControl) {
        stepperView.value = 0
        switch sender.selectedSegmentIndex {
        case 0:
            winningNumberLabelView.text = "Please set the number of correct \n answers needed to win"
        case 1:
            winningNumberLabelView.text = "Please set total number of tries"
        default:
            print("How did you get another segment?")
        }
    }
    
    @IBAction func whenStepped(_ sender: UIStepper) {
        switch winningOrLosingSegmentedControlView.selectedSegmentIndex {
        case 0:
            winningNumber = sender.value
        case 1:
            losingNumber = sender.value
        default:
            print("How did you get another segment?")
        }
    }
    
    @IBAction func onOrOff(_ sender: UISwitch) {
        if sender.isOn {
            resetScoreToggleLabelView.text = "The score will be reset with a loss"
        } else {
            resetScoreToggleLabelView.text = "The score will be never be reset"
        }
        
    }
    
    @IBAction func currentColor(_ sender: UISlider) {
        
        let blue = UIColor(red: 0.0, green: 0.0, blue: CGFloat(sender.value), alpha: 1.0)
        let red = UIColor(red: CGFloat(sender.value), green: 0.0, blue: 0.0, alpha: 1.0)
        let green = UIColor(red: 0.0, green: CGFloat(sender.value), blue: 0.0, alpha: 1.0)
        let currentColor = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1.0)
        
        switch sender.tag {
            
        case 0:
            redColorSlider.tintColor = red
            redColorSlider.maximumTrackTintColor = red
        case 1:
            blueColorSlider.maximumTrackTintColor = blue
            blueColorSlider.minimumTrackTintColor = blue
            
        case 2:
            greenColorSlider.maximumTrackTintColor = green
            greenColorSlider.minimumTrackTintColor = green
        default:
            print("How did you get another slider???")
        }
        
        switch winningOrLosingSegmentedControlView.selectedSegmentIndex {
        case 0:
            winningColor = currentColor
            currentColorView.backgroundColor = currentColor
            winningColorLabel.backgroundColor = currentColor
        case 1:
            losingColor = currentColor
            currentColorView.backgroundColor = currentColor
            losingColorLabel.backgroundColor = currentColor
        default:
            print("How did you get another segment?")
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            if let wc = winningColor {
                gvc.currentWinningColor = wc
            }
            if let lc = losingColor {
                gvc.currentLosingColor = lc
            }
            gvc.switchValue = switchView.isOn
            gvc.numberOfTriesBeforeAWin = winningNumber
            gvc.numberOfTriesBeforeALoss = losingNumber
        }
    }
}
