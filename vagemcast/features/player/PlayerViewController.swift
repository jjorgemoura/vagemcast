//
//  Copyright © 2021  ___ORGANIZATIONNAME___ . All rights reserved.

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        playPauseButton?.setTitle(nil, for: .normal)
        minusFitfteenButton?.setTitle(nil, for: .normal)
        plusFitfteenButton?.setTitle(nil, for: .normal)

        playPauseButton?.setImage(pauseButtonImage, for: .normal)
        minusFitfteenButton?.setImage(UIImage(systemName: "gobackward.15"), for: .normal)
        plusFitfteenButton?.setImage(UIImage(systemName: "goforward.15"), for: .normal)

        currentTimeLabel?.text = "00:00"
        totalDurationLabel?.text = "00:00"
        episodeTitleLabel?.text = "Title"
        episodeAuthorLabel?.text = "Author"

        episodeImageView?.image = UIImage(systemName: "antenna.radiowaves.left.and.right")
    }
}
