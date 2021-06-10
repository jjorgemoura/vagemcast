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

    private let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()

    private var audioPlayer: AVAudioPlayer?
    private var audioData: Data?

    private var audioPlayerNode: AVAudioPlayerNode?
    private var audioEngine: AVAudioEngine?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPlayer()

        //        downloadAudioFile()
//        audioData = loadAudioFileFromDisk(fileName: "atp432.mp3")
        updateState(to: .paused)
    }

    // MARK: - Actions

    @IBAction private  func playPauseTapped(_ sender: Any) {
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
    }

    @IBAction private func fastForward(_ sender: Any) {
    }

    // MARK: - Private

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

    private func setupPlayer() {
        updateState(to: .inactive)

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("\(String(describing: error))")
            print("Failed to activate session!")
        }
    }

    private func play() {
        // AVPlayer
        guard let assetURL = URL(string: "https://traffic.libsyn.com/atpfm/atp432.mp3") else { return }

        let playerItem = AVPlayerItem(url: assetURL)
        player.replaceCurrentItem(with: playerItem)
        //        player.play()

        // AVAudioPlayer
        if let audioData = audioData {
            audioPlayer = try? AVAudioPlayer(data: audioData)
//            audioPlayer?.play()
        }

        // AvAudioPlayerNode
        let fileURL = getDocumentsDirectory().appendingPathComponent("atp432.mp3")
        guard let file = try? AVAudioFile(forReading: fileURL) else { return }
        let format = file.processingFormat

        let audioLengthSamples = file.length
        let audioSampleRate = format.sampleRate
        let audioLengthSeconds = Double(audioLengthSamples) / audioSampleRate
        print(audioLengthSeconds)
//        audioFile = file

        let engine = AVAudioEngine()
        let playerNode = AVAudioPlayerNode()
        engine.attach(playerNode)

        engine.connect(playerNode, to: engine.mainMixerNode, format: format)
        engine.prepare()

        do {
            try engine.start()

            playerNode.scheduleFile(file, at: nil) {
                print("sdafdsxfw")
            }

            playerNode.play()

        } catch {
            print("Error starting the player: \(error.localizedDescription)")
        }

        audioEngine = engine
        audioPlayerNode = playerNode
    }

    private func pause() {
        player.pause()
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
