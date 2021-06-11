//
//  Copyright © 2021  ___ORGANIZATIONNAME___ . All rights reserved.

import UIKit
import AVFoundation

enum PlaybackState {
    case inactive
    case playing
    case paused
}

class PlayerViewController: UIViewController {

    @IBOutlet private var episodeImageView: UIImageView?
    @IBOutlet private var episodeTitleLabel: UILabel?
    @IBOutlet private var episodeAuthorLabel: UILabel?
    @IBOutlet private var currentTimeLabel: UILabel?
    @IBOutlet private var totalDurationLabel: UILabel?
    @IBOutlet private var playPauseButton: UIButton?
    @IBOutlet private var plusFitfteenButton: UIButton?
    @IBOutlet private var minusFitfteenButton: UIButton?

    private let playButtonImage = UIImage(systemName: "play.fill")
    private let pauseButtonImage = UIImage(systemName: "pause.fill")

    private var playerState: PlaybackState = .paused
    private var audioData: Data?

    private var audioEngine = AVAudioEngine()
    private var audioPlayerNode = AVAudioPlayerNode()
    private var audioTimePitchEffectNode = AVAudioUnitTimePitch()
    private var audioFile: AVAudioFile?

    private var audioSampleRate: Double = 0
    private var audioLengthSamples: AVAudioFramePosition = 0
    private var audioLengthSeconds: Double = 0
    private var seekFrame: AVAudioFramePosition = 0
    private var currentPosition: AVAudioFramePosition = 0

    private var needsFileScheduled = true

    private var currentFrame: AVAudioFramePosition {
        guard let lastRenderTime = audioPlayerNode.lastRenderTime else { return 0 }
        guard let playerTime = audioPlayerNode.playerTime(forNodeTime: lastRenderTime) else { return 0 }

        return playerTime.sampleTime
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSession()
        setupPlayer()

        // downloadAudioFile()
        // audioData = loadAudioFileFromDisk(fileName: "atp432.mp3")

        updateState(to: .paused)
    }

    // MARK: - Actions

    @IBAction private func playPauseTapped(_ sender: Any) {
        switch playerState {
        case .paused:
            updateState(to: .playing)
        case .playing:
            updateState(to: .paused)
        default:
            updateState(to: .inactive)
        }
    }

    @IBAction private func rewind(_ sender: Any) {
        seek(to: -10)
    }

    @IBAction private func fastForward(_ sender: Any) {
        seek(to: 10)
    }

    // MARK: - Private

    private func setupView() {
        playPauseButton?.setTitle(nil, for: .normal)
        minusFitfteenButton?.setTitle(nil, for: .normal)
        plusFitfteenButton?.setTitle(nil, for: .normal)

        playPauseButton?.setImage(playButtonImage, for: .normal)
        minusFitfteenButton?.setImage(UIImage(systemName: "gobackward.15"), for: .normal)
        plusFitfteenButton?.setImage(UIImage(systemName: "goforward.15"), for: .normal)

        currentTimeLabel?.text = "00:00"
        totalDurationLabel?.text = "00:00"
        episodeTitleLabel?.text = "Title"
        episodeAuthorLabel?.text = "Author"

        episodeImageView?.image = UIImage(systemName: "antenna.radiowaves.left.and.right")
    }

    private func setupSession() {
        updateState(to: .inactive)

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("\(String(describing: error))")
            print("Failed to activate session!")
        }
    }

    private func setupPlayer() {
        guard let file = try? AVAudioFile(forReading: getDocumentsDirectory().appendingPathComponent("atp432.mp3")) else { return }

        audioFile = file
        let format = file.processingFormat
        audioSampleRate = format.sampleRate
        audioLengthSamples = file.length
        audioLengthSeconds = Double(audioLengthSamples) / audioSampleRate

        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(audioTimePitchEffectNode)
        audioEngine.connect(audioPlayerNode, to: audioTimePitchEffectNode, format: format)
        audioEngine.connect(audioTimePitchEffectNode, to: audioEngine.mainMixerNode, format: format)
        audioEngine.prepare()

        do {
            try audioEngine.start()

            audioPlayerNode.scheduleFile(file, at: nil)
        } catch {
            print("Error starting the player: \(error.localizedDescription)")
        }
    }

    private func updateState(to playbackState: PlaybackState) {
        switch playbackState {
        case .inactive:
            playerState = .inactive
            playPauseButton?.isEnabled = false
        case .playing:
            playerState = .playing
            playPauseButton?.isEnabled = true
            playPauseButton?.setImage(pauseButtonImage, for: .normal)
            play()
        case .paused:
            playerState = .paused
            playPauseButton?.isEnabled = true
            playPauseButton?.setImage(playButtonImage, for: .normal)
            pause()
        }
    }

    private func updateDisplay() {
        currentPosition = currentFrame + seekFrame
        currentPosition = max(currentPosition, 0)
        currentPosition = min(currentPosition, audioLengthSamples)

        if currentPosition >= audioLengthSamples {
            audioPlayerNode.stop()

            seekFrame = 0
            currentPosition = 0

//            isPlaying = false
//            displayLink?.isPaused = true

//            disconnectVolumeTap()
        }

        let playerProgress = Double(currentPosition) / Double(audioLengthSamples)
        currentTimeLabel?.text = String(playerProgress)

        let time = Double(currentPosition) / audioSampleRate
//        let playerTime = PlayerTime(elapsedTime: time, remainingTime: audioLengthSeconds - time)
        totalDurationLabel?.text = String(time)
    }

    private func play() {
        update(rate: 1.5)
//        update(pitch: 12) // 1 octave
//        update(pitch: -12) // -1
//        update(pitch: 7) // 5th
        audioPlayerNode.play()
    }

    private func pause() {
        audioPlayerNode.pause()
    }

    private func seek(to time: Double) {
        guard let audioFile = audioFile else { return }

        let offset = AVAudioFramePosition(time * audioSampleRate)
        seekFrame = currentPosition + offset
        seekFrame = max(seekFrame, 0)
        seekFrame = min(seekFrame, audioLengthSamples)
        currentPosition = seekFrame

        let wasPlaying = audioPlayerNode.isPlaying
        audioPlayerNode.stop()

        if currentPosition < audioLengthSamples {
            updateDisplay()
            needsFileScheduled = false

            let frameCount = AVAudioFrameCount(audioLengthSamples - seekFrame)
            audioPlayerNode.scheduleSegment(audioFile, startingFrame: seekFrame, frameCount: frameCount, at: nil) {
                self.needsFileScheduled = true
            }

            if wasPlaying {
                audioPlayerNode.play()
            }
        }
    }

    private func update(rate: Float) {
        audioTimePitchEffectNode.rate = rate
    }

    private func update(pitch: Int) {
        audioTimePitchEffectNode.pitch = Float(100 * pitch) // pitch means 1 half tone. 1 octave = 1200 cents
    }
}

extension PlayerViewController {

    private func downloadAudioFile() {
        guard let assetURL = URL(string: "https://traffic.libsyn.com/atpfm/atp432.mp3") else { return }

        let session = URLSession.shared.dataTask(with: assetURL) { data, response, error in
            if let error = error {
                print("Opsss -> \(error)")
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Return code -> \(httpResponse.statusCode)")
            }

            self.audioData = data
            DispatchQueue.main.async {
                self.updateState(to: .paused)
            }
            //                    self.saveAudioFileToDisk(data: data!)
        }
        session.resume()
    }

    private func loadAudioFileFromDisk(fileName: String) -> Data {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)

        if let loadedData = try? Data(contentsOf: fileURL) {
            updateState(to: .paused)
            return loadedData
        }
        fatalError("oops")
    }

    private func saveAudioFileToDisk(data: Data) {
        let fileURL = getDocumentsDirectory().appendingPathComponent("atp432.mp3")

        do {
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            print(error)
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
