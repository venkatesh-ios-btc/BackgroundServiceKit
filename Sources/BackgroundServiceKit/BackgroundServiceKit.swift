// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import BackgroundTasks
import AVFoundation
import UIKit

public class BackgroundService {
    public static let shared = BackgroundService()


    public func start() {
           startBackgroundExecution()
       }

       public func stop() {
           stopBackgroundExecution()
       }
    
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    private var timer: Timer?

    private init() {}


    public func startBackgroundExecution() {
        registerBackgroundTask()
        startAudioPlayback() // Trick iOS into keeping the app alive
        startTimer()
    }

    public func stopBackgroundExecution() {
        stopAudioPlayback()
        timer?.invalidate()
        endBackgroundTask()
    }

    // MARK: - Keep the app alive using silent audio
    private var audioPlayer: AVAudioPlayer?

    private func startAudioPlayback() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try audioSession.setActive(true)

            if let url = Bundle.main.url(forResource: "silent", withExtension: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // Infinite loop
                audioPlayer?.play()
                print("✅ Silent music started playing")
                
                // Print confirmation every 10 seconds
                Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                    if self.audioPlayer?.isPlaying == true {
                        print("🎵 Silent music is still playing in the background")
                    }
                }
            }
        } catch {
            print("❌ Audio session error: \(error)")
        }
    }

    private func stopAudioPlayback() {
        audioPlayer?.stop()
        audioPlayer = nil
    }

    // MARK: - Register and Handle Background Task
    private func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask {
            self.endBackgroundTask()
        }
    }

    private func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }

    // MARK: - Simulated Background Work (For Your Use Case)
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            self.sendData()
        }
    }

    private func sendData() {
        print("✅ Background Task Running: Sending Data...")
        // Add logic for background operations (e.g., network requests, location updates, etc.)
    }
}

