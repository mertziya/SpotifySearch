//
//  SongDetailsVC.swift
//  RESTfulService
//
//  Created by Mert Ziya on 8.01.2025.
//

import Foundation
import UIKit

class SongDetailsVC : UIViewController {
    
    // PROPERTIES:
    var selectedSong : Song?
    
    // UI COMPONENTS:
    var gradientLayer : CAGradientLayer!
    
    var albumImageView = UIImageView()
    var songNameLabel = UILabel()
    var artistNameLabel = UILabel()
    
    var progressView = UIProgressView()
    var progressCurrentTimeLabel = UILabel()
    var progressEndTimeLabel = UILabel()
    
    var likeButton = UIImageView()
    var likesLabel = UILabel()
    
    var previousSong = UIImageView()
    var nextSong = UIImageView()
    var stopMusic = UIImageView()
    
    // LIFECYCLES:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNav()
        
    }
    
    override func viewDidLayoutSubviews() {
        // Update the gradient layer's frame to match the view's bounds
        setupGradientBackground(withMainColor: UIColor.systemGreen.withAlphaComponent(0.2))
    }
}





// MARK: - UI CONFIGURATIONS:
extension SongDetailsVC {

    private func setupGradientBackground(withMainColor : UIColor){
        view.backgroundColor = .systemBackground
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [withMainColor.cgColor, UIColor.systemBackground.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0,1]
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.bounds
    }
    
    private func setupUI(){
        view.addSubview(albumImageView)
        view.addSubview(songNameLabel)
        view.addSubview(artistNameLabel)
        
        view.addSubview(progressView)
        view.addSubview(progressCurrentTimeLabel)
        view.addSubview(progressEndTimeLabel)
        
        view.addSubview(likeButton)
        view.addSubview(likesLabel)
        
        view.addSubview(previousSong)
        view.addSubview(stopMusic)
        view.addSubview(nextSong)
        
        
        albumImageView.contentMode = .scaleAspectFit
        albumImageView.backgroundColor = .systemBackground
        albumImageView.clipsToBounds = true
        guard let imageURL = selectedSong?.albumImg else {print("DEBUG: Image nil error") ; return}
        ImageLoadService.loadImage(urlString: imageURL) { albumImage in
            DispatchQueue.main.async {
                self.albumImageView.image = albumImage
            }
        }
        
        songNameLabel.text = selectedSong?.songName
        songNameLabel.textColor = .label
        songNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        artistNameLabel.text = selectedSong?.mainArtistName
        artistNameLabel.textColor = .label.withAlphaComponent(0.6)
        artistNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        
        
        let sampleCurrentTime = Int.random(in: 0...(selectedSong!.duration_ms / 1000))
        let currentMinutes = sampleCurrentTime / 60 ; let currentSeconds = sampleCurrentTime % 60
        progressCurrentTimeLabel.text = "\(currentMinutes):\(currentSeconds)"
        progressCurrentTimeLabel.textColor = .label.withAlphaComponent(0.6)
        progressCurrentTimeLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        
        let endTime = selectedSong!.duration_ms / 1000
        let endMinutes = endTime / 60 ; let endSeconds = endTime % 60
        progressEndTimeLabel.text = "\(endMinutes):\(endSeconds)"
        progressEndTimeLabel.textColor = .label.withAlphaComponent(0.6)
        progressEndTimeLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        
        let progressValue = Float(sampleCurrentTime) / Float(endTime)
        progressView.progress = progressValue
        
        
        likeButton.image = UIImage(systemName: "heart")
        likeButton.tintColor = .label
        likeButton.contentMode = .scaleAspectFill
        likeButton.clipsToBounds = true
        
        likesLabel.text = String(selectedSong!.popularity)
        likesLabel.textColor = .label.withAlphaComponent(0.7)
        likesLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        
        
        stopMusic.image = UIImage(systemName: "pause.circle.fill")
        stopMusic.tintColor = .white
        stopMusic.contentMode = .scaleAspectFill
        stopMusic.clipsToBounds = true
        
        previousSong.image = UIImage(systemName: "backward.end.fill")
        previousSong.tintColor = .white
        previousSong.contentMode = .scaleAspectFit
        previousSong.clipsToBounds = true
        
        nextSong.image = UIImage(systemName: "forward.end.fill")
        nextSong.tintColor = .white
        nextSong.contentMode = .scaleAspectFit
        nextSong.clipsToBounds = true
        
        
        
        
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressCurrentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        progressEndTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        previousSong.translatesAutoresizingMaskIntoConstraints = false
        nextSong.translatesAutoresizingMaskIntoConstraints = false
        stopMusic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width * 0.05),
            albumImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.2),
            albumImageView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            albumImageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            
            songNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: view.bounds.width * 0.12),
            songNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width * 0.05),
            
            artistNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width * 0.05),
            artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 8),
            
            progressView.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 20),
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width*0.05),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            progressView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            
            progressCurrentTimeLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 4),
            progressCurrentTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width*0.05),
            
            progressEndTimeLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 4),
            progressEndTimeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: view.bounds.width * -0.05),
            
            likeButton.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: view.bounds.width * 0.12),
            likeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: view.bounds.width * -0.05),
            likeButton.heightAnchor.constraint(equalToConstant: 32),
            likeButton.widthAnchor.constraint(equalToConstant: 32),
            
            likesLabel.centerXAnchor.constraint(equalTo: likeButton.centerXAnchor),
            likesLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 4),
            
            stopMusic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopMusic.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.width * 0.26),
            stopMusic.heightAnchor.constraint(equalToConstant: 68),
            stopMusic.widthAnchor.constraint(equalToConstant: 68),
            
            previousSong.centerYAnchor.constraint(equalTo: stopMusic.centerYAnchor),
            previousSong.rightAnchor.constraint(equalTo: stopMusic.leftAnchor, constant: -16),
            previousSong.heightAnchor.constraint(equalToConstant: 30),
            previousSong.widthAnchor.constraint(equalToConstant: 42),
            
            nextSong.centerYAnchor.constraint(equalTo: stopMusic.centerYAnchor),
            nextSong.leftAnchor.constraint(equalTo: stopMusic.rightAnchor, constant: 16),
            nextSong.heightAnchor.constraint(equalToConstant: 30),
            nextSong.widthAnchor.constraint(equalToConstant: 42),
            
                        
        ])
    }
    
    private func setupNav(){
        navigationItem.title = selectedSong?.albumName
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .label
    }
    @objc private func goBack(){
        navigationController?.popViewController(animated: true)
    }

}
