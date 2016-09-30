//
//  GuesturesViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by C4Q on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {
    
    var correctColorValue = 0.0
    
    enum ActionGesture: Int {
        case tap, doubleTap, twoFingerTap, leftSwipe, rightSwipe
    }
    
    
    var currentActionGesture: ActionGesture = .tap {
        willSet {
            self.updateLabel(for: newValue)
        }
    }
    
    internal var currentScore: Int = 0 {
        willSet {
            self.scoreLabel.text = "Score: \(newValue)"
        }
    }
    
    @IBOutlet weak var promptLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var rightSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var twoTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var twoFingerTapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer.require(toFail: twoTapGestureRecognizer)
        self.currentActionGesture = self.pickRandomActionGesture()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isCorrect(_ correct: Bool) {
        self.currentActionGesture = pickRandomActionGesture()
        
        if correct {
            self.view.backgroundColor = .green
            currentScore += 1
        } else {
            self.view.backgroundColor = .red
            currentScore = 0
        }
    }
    
    @IBAction func didPerformGesture(_ sender: UIGestureRecognizer) {
        if let tapGesture: UITapGestureRecognizer = sender as? UITapGestureRecognizer {
            switch (tapGesture.numberOfTapsRequired, tapGesture.numberOfTouchesRequired) {
            case (1,1):
                print("I was tapped once")
                isCorrect(self.currentActionGesture == .tap)
            case (2,1):
                print("I was tapped once")
                isCorrect(self.currentActionGesture == .doubleTap)
            case (1,2):
                print("I was tapped once")
                isCorrect(self.currentActionGesture == .twoFingerTap)
            default:
                print("type tap was wrong")
                isCorrect(false)
            }
        }
        if let swipeGesture: UISwipeGestureRecognizer = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                print("left")
                isCorrect(self.currentActionGesture == .leftSwipe)
            case UISwipeGestureRecognizerDirection.right:
                print("right")
                isCorrect(self.currentActionGesture == .rightSwipe)
            default:
                print("That wasn't a good direction")
                isCorrect(false)
                
            }
        }
    }
    
    
    // MARK: -Utility Gesture Functions
    // update our label for each gesture
    func updateLabel(for actionGes: ActionGesture) {
        var updateText: String = ""
        switch actionGes {
        case .tap: updateText = "tap"
        case .doubleTap: updateText = "double tap"
        case .twoFingerTap: updateText = "two finger tap"
        case .leftSwipe: updateText = "swift left"
        case .rightSwipe: updateText = "swipe right"
        }
        
        self.promptLabel.text = updateText
    }
    
    // a way to randomly get a gesture
    func pickRandomActionGesture() -> ActionGesture {
        let randomInt = Int(arc4random_uniform(5)) // number between 0-4
        return ActionGesture(rawValue: randomInt) ?? .tap
    }
    
    //MARK: -Actions
    /*
    @IBAction func didTwoFingerTappedView(_ sender: AnyObject) {
        print("I was tapped with two fingers")
        isCorrect(self.currentActionGesture == .twoFingerTap)
        //        if self.currentActionGesture == .twoFingerTap {
        //            self.view.backgroundColor = .green
        //            currentScore += 1
        //        } else {
        //            self.view.backgroundColor = .red
        //            currentScore = 0
        //        }
        //        self.currentActionGesture = pickRandomActionGesture()
        //we removed all that code we had written and refactored it as a function because its cleaner and makes more sense
    }
    
    @IBAction func didTapTwiceView(_ sender: UITapGestureRecognizer) {
        print("I was tapped twice")
        
        isCorrect(self.currentActionGesture == .doubleTap)
        
    }
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        print("I was tapped once")
        isCorrect(self.currentActionGesture == .tap)
        
    }
    
    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
        print("right")
        
        isCorrect(self.currentActionGesture == .rightSwipe)
        
    }
    
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        print("left")
        
        isCorrect(self.currentActionGesture == .leftSwipe)
        
    }
 */
}
