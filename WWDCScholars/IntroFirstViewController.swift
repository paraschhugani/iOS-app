//
//  IntroFirstViewController.swift
//  WWDCScholars
//
//  Created by Sam Eckert on 08.05.17.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import UIKit

internal class IntroFirstViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    
    
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var getStartedButton: UIButton!
    
    
    internal override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.buttonBoundsDynamicItem = APLPositionToBoundsMapping(target: self.getStartedButton)
        self.pushBehavior = UIPushBehavior(items: [buttonBoundsDynamicItem], mode: .instantaneous)
        
        setupUI()
    }

    internal override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UI
    private var animator: UIDynamicAnimator!
    private var buttonBoundsDynamicItem: APLPositionToBoundsMapping!
    private var pushBehavior: UIPushBehavior!
    private var attachmentBehavior: UIAttachmentBehavior!
    
    private func setupUI(){
        // Label text and spacing
        headerLabel.text = "Here's to the Crazy Ones."
        headerLabel.addTextSpacing(spacing: 0.8)
        
        // Button text and adaption
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.layer.cornerRadius = 10
        
        // Button text and adaption
        skipButton.setTitle("Skip", for: .normal)
        skipButton.layer.cornerRadius = 10
        
        // Background Image View
        backgroundImageView.clipsToBounds = true
        
        // UIKit Dynamics
        let attachmentBehavior = UIAttachmentBehavior(item: self.buttonBoundsDynamicItem, attachedToAnchor: self.buttonBoundsDynamicItem.center)
        
        self.attachmentBehavior = attachmentBehavior
        self.attachmentBehavior.frequency = 2.0
        self.attachmentBehavior.damping = 0.1
        self.animator!.addBehavior(self.attachmentBehavior)
        
        getStartedButton.adjustsImageWhenHighlighted = false
        self.getStartedButton.addTarget(self, action: #selector(IntroFirstViewController.onDown(sender:)), for: UIControl.Event.touchDown)
        self.getStartedButton.addTarget(self, action: #selector(IntroFirstViewController.onUp(sender:)), for: UIControl.Event.touchCancel)
        self.getStartedButton.addTarget(self, action: #selector(IntroFirstViewController.onUp(sender:)), for: UIControl.Event.touchUpInside)
        self.getStartedButton.addTarget(self, action: #selector(IntroFirstViewController.onUp(sender:)), for: UIControl.Event.touchUpOutside)
    }
    @objc private func onDown(sender: UIButton) {
        self.attachmentBehavior.damping = 0.1
        self.pushBehavior.angle = CGFloat(Double.pi / 4)
        self.pushBehavior.magnitude = 20
        UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: { sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }, completion: {_ in})

    }
    @objc private func onUp(sender: UIButton) {
        self.pushBehavior.active = false
        self.attachmentBehavior.damping = 100
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: { sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)}, completion: {_ in})
    }

    
    
    @IBAction func getStartedButtonAction(_ sender: Any) {
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func unwindToFirst(segue: UIStoryboardSegue) {}
}
