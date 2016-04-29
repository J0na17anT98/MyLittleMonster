//
//  ViewController.swift
//  myLittleMonster
//
//  Created by Jonathan Tsistinas on 4/11/16.
//  Copyright © 2016 Techinator. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var monsterImg2: MonsterImg2!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImage: DragImg!
    @IBOutlet weak var obeyImg: DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    @IBOutlet weak var ChooseCharacterButtonRockMonster: UIButton!
    @IBOutlet weak var ChooseCharacterButtonMole: UIButton!
    @IBOutlet weak var CharacterText: UIImageView!
    @IBOutlet weak var livesPanel: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    var whichCharacter = true
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChooseCharacter()
    }
        func playGame() {
            
            //hiding choose character buttons
            ChooseCharacterButtonRockMonster.hidden = true
            ChooseCharacterButtonMole.hidden = true
            CharacterText.hidden = true
            
            //setting objects dropTarget
            foodImg.dropTarget = monsterImg
            heartImage.dropTarget = monsterImg
            obeyImg.dropTarget = monsterImg
            
            penalty1Img.alpha = DIM_ALPHA
            penalty2Img.alpha = DIM_ALPHA
            penalty3Img.alpha = DIM_ALPHA
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
            
            do {
                let ResourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!
                let url = NSURL(fileURLWithPath: ResourcePath)
                try musicPlayer = AVAudioPlayer(contentsOfURL: url)
                
                try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
                try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
                try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
                try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
                
                
                musicPlayer.prepareToPlay()
                musicPlayer.play()
                
                sfxBite.prepareToPlay()
                sfxHeart.prepareToPlay()
                sfxDeath.prepareToPlay()
                sfxSkull.prepareToPlay()
                
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
            startTimer()
            
        }
    
        func itemDroppedOnCharacter(notif: AnyObject) {
            monsterHappy = true
            startTimer()
            
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            obeyImg.alpha = DIM_ALPHA
            obeyImg.userInteractionEnabled = false
        
            if currentItem == 0 {
                sfxHeart.play()
            }else if rand() == 1{
                sfxBite.play()
            }else{
                sfxHeart.play()
            }
        }
    
        func startTimer() {
            if timer != nil {
                timer.invalidate()
            }
        
            timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
        }

        func changeGameState() {
        
            if !monsterHappy {
                penalties += 1
            
                sfxSkull.play()
            
                if penalties == 1 {
                    penalty1Img.alpha = OPAQUE
                    penalty2Img.alpha = DIM_ALPHA
                }else if penalties == 2 {
                    penalty2Img.alpha = OPAQUE
                    penalty3Img.alpha = DIM_ALPHA
                }else if penalties == 3 {
                    penalty3Img.alpha = OPAQUE
                }else {
                    penalty1Img.alpha = DIM_ALPHA
                    penalty2Img.alpha = DIM_ALPHA
                    penalty3Img.alpha = DIM_ALPHA
                }
            
                if penalties >= MAX_PENALTIES {
                    timer.invalidate()
                    gameOver()
                }
            
            }
        
            let rand = arc4random_uniform(3)
            if rand == 0 {
                foodImg.alpha = DIM_ALPHA
                foodImg.userInteractionEnabled = false
            
                heartImage.alpha = OPAQUE
                heartImage.userInteractionEnabled = true
            
                obeyImg.alpha = DIM_ALPHA
                obeyImg.userInteractionEnabled = false
            }else if rand == 1{
                foodImg.alpha = OPAQUE
                foodImg.userInteractionEnabled = true
            
                heartImage.alpha = DIM_ALPHA
                heartImage.userInteractionEnabled = false
            
                obeyImg.alpha = DIM_ALPHA
                obeyImg.userInteractionEnabled = false
            }else{
                foodImg.alpha = DIM_ALPHA
                foodImg.userInteractionEnabled = false
            
                heartImage.alpha = DIM_ALPHA
                heartImage.userInteractionEnabled = false
            
                obeyImg.alpha = OPAQUE
                obeyImg.userInteractionEnabled = true
            }
            currentItem = rand
            monsterHappy = false
        }

        func gameOver() {
            timer.invalidate()
            monsterImg.playDeathAnimation()
            monsterImg2.playDeathAnimation()
            sfxDeath.play()
            
        }
    
    
    func ChooseCharacter() {
        ChooseCharacterButtonRockMonster.hidden = false
        ChooseCharacterButtonMole.hidden = false
        CharacterText.hidden = false
        monsterImg.hidden = true
        monsterImg2.hidden = true
        foodImg.hidden = true
        heartImage.hidden = true
        penalty1Img.hidden = true
        penalty2Img.hidden = true
        penalty3Img.hidden = true
        livesPanel.hidden = true
        obeyImg.hidden = true
        
        
    }
    
    @IBAction func TapRockCharacter () {
        ChooseCharacterButtonRockMonster.hidden = true
        ChooseCharacterButtonMole.hidden = true
        CharacterText.hidden = true
        monsterImg2.hidden = true
        monsterImg.hidden = false
        foodImg.hidden = false
        heartImage.hidden = false
        penalty1Img.hidden = false
        penalty2Img.hidden = false
        penalty3Img.hidden = false
        obeyImg.hidden = false
        livesPanel.hidden = false

        
        playGame()
    }
    
    @IBAction func TapMoleCharacter () {
        ChooseCharacterButtonRockMonster.hidden = true
        ChooseCharacterButtonMole.hidden = true
        CharacterText.hidden = true
        monsterImg.hidden = true
        monsterImg2.hidden = false
        foodImg.hidden = false
        heartImage.hidden = false
        penalty1Img.hidden = false
        penalty2Img.hidden = false
        penalty3Img.hidden = false
        obeyImg.hidden = false
        livesPanel.hidden = false

        
        playGame()
    }
    
    
}