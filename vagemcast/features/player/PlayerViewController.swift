//
//  Copyright © 2021  ___ORGANIZATIONNAME___ . All rights reserved.

import UIKit
import AVFoundation

enum PlaybackState {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPlayer()
    }

    // MARK: - Actions

    @IBAction private  func playPauseTapped(_ sender: Any) {
        switch playerState {
        case .paused:
            playerState = .playing
            playPauseButton?.setImage(pauseButtonImage, for: .normal)
            play()
        case .playing:
            playerState = .paused
            playPauseButton?.setImage(playButtonImage, for: .normal)
            pause()
        }
    }

    @IBAction private func rewind(_ sender: Any) {
    }

    @IBAction private func fastForward(_ sender: Any) {
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

    private func setupPlayer() {
        playerState = .paused

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("\(String(describing: error))")
            print("Failed to activate session!")
        }
    }

    private func play() {
        guard let assetURL = URL(string: "https://traffic.libsyn.com/atpfm/atp432.mp3") else { return }

        let playerItem = AVPlayerItem(url: assetURL)

        player.replaceCurrentItem(with: playerItem)
        player.play()
    }

    private func pause() {
        player.pause()
    }
}
