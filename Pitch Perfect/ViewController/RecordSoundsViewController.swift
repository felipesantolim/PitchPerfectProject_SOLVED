//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Felipe Henrique Santolim on 12/9/16.
//  Copyright © 2016 Felipe Santolim. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    //MARK: Properties
    
    private var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pitch Perfect"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSettings()
    }
    
    //MARK: Actions
    
    @IBAction func recordAudio (_ sender: UIButton) {
        
        if let filePath = filePathSaveAudio() {
            
            configureRecordingButton(true)
            startAudioRecorder(filePath)
        }
    }
    
    @IBAction func stopRecordingAudio (_ sender: UIButton) {
        configureRecordingButton(false)
        audioRecorder.stop()
    }
    
    //MARK: Private methods
    
    private func initialSettings () {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        
    }
    
    private func configureRecordingButton (_ isRecording: Bool) {
        recordingLabel.text = isRecording ? "Recording audio" : "Tap to Record"
        recordButton.isEnabled = isRecording ? false : true
        stopRecordingButton.isEnabled = isRecording ? true : false
    }
    
    private func filePathSaveAudio () -> URL? {
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        return filePath
    }
    
    private func startAudioRecorder (_ filePath: URL) {
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
            
            audioRecorder.delegate          = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            
        } catch { print("") }
    }
    
    //MARK: AVAudioRecorderDelegate
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
            performSegue(withIdentifier: "PlaySoundsViewSegue", sender: audioRecorder.url)
            
        } else { print("") }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PlaySoundsViewSegue" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioUrl
        }
    }
}

