//
// Created by Sergey Teryokhin on 17/01/2017.
// Copyright (c) 2017 iMacDev. All rights reserved.
//

import Foundation
import AVFoundation
import QorumLogs

//TODO: actially we need to have one service which manage audio and frame services

/// Service to play audio for given video asset
class VideoAudioPlayerService: NSObject, VideoAudioPlayerServiceProtocol, AVAudioPlayerDelegate {
    enum VideoAudioPlayerServiceError : Error {
        case noPlayer
    }

    var player: AVPlayer!

    weak var delegate: VideoAudioPlayerDelegateProtocol?

    init(withURL url: URL) throws {
        super.init()

        let myPlayer = AVPlayer(url: url)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(VideoAudioPlayerService.audioPlayerDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: myPlayer.currentItem)

        self.player = myPlayer
    }
    
    deinit {
        QL2("DEINIT")
        NotificationCenter.default.removeObserver(self)
    }

    ///MARK: VideoAudioPlayerProtocol
    func play() {
        self.player.play()
    }

    func pause() {
        self.player.pause()
    }

    func stop() {
        self.player.pause()
    }

    func currentTime() -> TimeInterval {
        let current = CMTimeGetSeconds(self.player.currentTime());
        return current
    }

    func duration() -> TimeInterval {
        guard let myPlayItem = self.player.currentItem else {
            return 0.0
        }

        let durationTime: CMTime = myPlayItem .duration
        return CMTimeGetSeconds(durationTime)
    }

    ///MARK:
    func audioPlayerDidFinishPlaying(_ notification: Notification) {
        QL2("FINISHED!")
        
        guard let myDelegate = self.delegate else {
            return
        }

        myDelegate.didFinish(withService: self, result: true)
    }
}
