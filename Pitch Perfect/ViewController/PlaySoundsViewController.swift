//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Felipe Henrique Santolim on 12/10/16.
//  Copyright © 2016 Felipe Santolim. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //MARK: Properties
    
    var recordedAudioURL    : URL!
    var audioFile           : AVAudioFile!
    var audioEngine         : AVAudioEngine!
    var audioPlayerNode     : AVAudioPlayerNode!
    var stopTimer           : Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    //MARK: UI Elements
    
    @IBOutlet weak var stopButton       : UIButton!
    @IBOutlet weak var snailButton      : UIButton!
    @IBOutlet weak var chipmunkButton   : UIButton!
    @IBOutlet weak var rabbitButton     : UIButton!
    @IBOutlet weak var vaderButton      : UIButton!
    @IBOutlet weak var echoButton       : UIButton!
    @IBOutlet weak var reverbButton     : UIButton!
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAudio()
    }

    //MARK: Actions
    
    @IBAction func playSoundForButton (_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.4)
        case .fast:
            playSound(rate: 2.0)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopSoundPressed (_ sender: UIButton) {
        stopAudio()
    }
}
