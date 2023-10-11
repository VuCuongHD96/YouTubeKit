//
//  YoutubeDownloader.swift
//
//
//  Created by Work on 20/11/2023.
//

import Combine

public struct YoutubeDownloader {
    
    public static let shared = YoutubeDownloader()
    
    public func fetchYouTubeStream(videoID: String) -> AnyPublisher<YTStream, Error> {
        return Future { promise in
            Task.detached {
                do {
                    if let streams = try await YouTube(videoID: videoID)
                        .streams
                        .highestResolutionStream() {
                        promise(.success(streams))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
