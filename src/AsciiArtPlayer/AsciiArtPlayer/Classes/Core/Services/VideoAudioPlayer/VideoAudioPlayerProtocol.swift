//
// Created by Sergey Teryokhin on 17/01/2017.
// Copyright (c) 2017 iMacDev. All rights reserved.
//

import Foundation

protocol VideoAudioPlayerDelegateProtocol: class {
    func didFinish(withService: VideoAudioPlayerService, result: Bool)
}

protocol VideoAudioPlayerServiceProtocol: class {
    /// Delegate to notify about events
    weak var delegate: VideoAudioPlayerDelegateProtocol? { get set }

    func play()
    func pause()
    func stop()

    func currentTime() -> TimeInterval
    func duration() -> TimeInterval
}
