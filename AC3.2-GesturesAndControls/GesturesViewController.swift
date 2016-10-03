//
//  GesturesViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {
    var currentWinningColor: UIColor?
    var currentLosingColor: UIColor?
    var switchValue = true
    var numberOfTriesBeforeAWin: Double?
    var numberOfTriesBeforeALoss: Double?
    
    
    var numberOfTries = 0 {
        willSet {
            self.numberOfTriesLabel.text = "Number of tries: \(newValue)"
        }
    }
    
    enum ActionGesture: Int {
        case tap, doubleTap, twoFingerTap, leftSwipe, rightSwipe
    }
    
    var currentActionGesture = ActionGesture.tap {
        willSet {
            self.updateLabel(for: newValue)
        }
    }
    
    var currentScore: Int = 0 {
        willSet {
            self.scoreLabel.text = "Score: \(newValue)"
        }
    }
    
    @IBOutlet weak var actionToPerformLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var rightSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var doubleTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var twoFingerTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var numberOfTriesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        self.currentActionGesture = self.pickRandomActionGesture()
        self.resetButton.isHidden = true
    }
    
    // MARK: - Utility
    // update our label for each gesture
    func updateLabel(for actionGes: ActionGesture) {
        var updateText: String = ""
        switch actionGes {
        case .tap: updateText = "tap"
        case .doubleTap: updateText = "double tap"
        case .twoFingerTap: updateText = "two finger tap"
        case .leftSwipe: updateText = "swipe left"
        case .rightSwipe: updateText = "swipe right"
        }
        
        self.actionToPerformLabel.text = updateText
    }
    
    // a way to randomly get a gesture
    func pickRandomActionGesture() -> ActionGesture {
        let randomInt = Int(arc4random_uniform(5)) // number between 0-4
        return ActionGesture(rawValue: randomInt) ?? .tap
    }
    
    // MARK: - Actions
    //    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
    //        print("I was tapped")
    //        self.isCorrect(self.currentActionGesture == .tap)
    //    }
    //
    //    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
    //        print("Swiped left")
    //        self.isCorrect(self.currentActionGesture == .leftSwipe)
    //    }
    //
    //    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
    //        print("Swiped right")
    //        self.isCorrect(self.currentActionGesture == .rightSwipe)
    //    }
    //
    //    @IBAction func didDoubleTapView(_ sender: UITapGestureRecognizer) {
    //        print("Did double tap view")
    //        self.isCorrect(self.currentActionGesture == .doubleTap)
    //    }
    //
    //    @IBAction func didTwoFingerTapView(_ sender: UITapGestureRecognizer) {
    //        print("Did two finger tap view")
    //        self.isCorrect(self.currentActionGesture == .twoFingerTap)
    //    }
    
    @IBAction func didPerformGesture(_ sender: UIGestureRecognizer) {
        numberOfTries += 1
        if let tapGesture: UITapGestureRecognizer = sender as? UITapGestureRecognizer {
            switch (tapGesture.numberOfTapsRequired, tapGesture.numberOfTouchesRequired) {
                
            case (1, 1):
                print("Heck yea I was tapped")
                self.isCorrect(self.currentActionGesture == .tap)
                
            case (2, 1):
                print("double tap!")
                self.isCorrect(self.currentActionGesture == .doubleTap)
                
            case (1, 2):
                print("two finger tap!")
                self.isCorrect(self.currentActionGesture == .twoFingerTap)
                
            default:
                print("tap type was wrong!")
                self.isCorrect(false)
            }
        }
        
        if let swipeGesture: UISwipeGestureRecognizer = sender as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.left:
                print("did swipe left")
                self.isCorrect(self.currentActionGesture == .leftSwipe)
                
            case UISwipeGestureRecognizerDirection.right:
                print("did swipe right")
                self.isCorrect(self.currentActionGesture == .rightSwipe)
                
            default:
                print("was not left/right")
                self.isCorrect(false)
            }
        }
    }
    
    func isCorrect(_ correct: Bool) {
        self.currentActionGesture = pickRandomActionGesture()
        
        if correct {
            // use the "correctColorValue" to manipulate the red component of a color
            self.view.backgroundColor = currentWinningColor
            // alternatively we can change the hue using this initializer of UIColor
            // self.view.backgroundColor = UIColor(hue: CGFloat(Float(self.correctColorValue)), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            
            self.currentScore += 1
        }
        else {
            self.view.backgroundColor = currentLosingColor
            if switchValue {
                self.currentScore = 0
                self.scoreLabel.text = "Score: \(currentScore)"
            }
        }
        if let win = numberOfTriesBeforeAWin {
            if currentScore == Int(win) {
                scoreLabel.text = "WINNER"
                self.resetButton.isHidden = false
            }
        }
        if let lose = numberOfTriesBeforeALoss {
            if numberOfTries == Int(lose) {
                scoreLabel.text = "LOSE"
                self.resetButton.isHidden = false
            }
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        self.currentScore = 0
        self.numberOfTries = 0
        self.view.reloadInputViews()
    }
}
