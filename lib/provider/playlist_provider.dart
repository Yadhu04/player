import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:music_player/models/songes.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlaylistProvider extends ChangeNotifier {
  //  final OnAudioQuery _audioQuery = OnAudioQuery();

  List<SongModel>? _playlist;

  Future<void> loadSongs() async {
    final OnAudioQuery audioQuery = OnAudioQuery();
    final permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      _playlist = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        sortType: null,
      );
    } else {
      _playlist = [];
    }
    notifyListeners();
  }

  // late final _playlist = _audioQuery.querySongs();

  // late final Future<List<SongModel>> _playlist = _audioQuery.querySongs();

  // final List<Songs> _playlist = [
  //   Songs(
  //       songName: 'Chor',
  //       artistName: 'artistName',
  //       imagePath: 'assets/images/1.png',
  //       audioPath: 'audio/1 Chor.mp3'),
  //   Songs(
  //       songName: 'Husn',
  //       artistName: 'artistName',
  //       imagePath: 'assets/images/2.png',
  //       audioPath: 'audio/2Husn.mp3'),
  //   Songs(
  //       songName: 'Kabhi Kabhi',
  //       artistName: 'artistName',
  //       imagePath: 'assets/images/3.png',
  //       audioPath: 'audio/3kabhi.mp3'),
  // ];

/*audio Player*/
  final AudioPlayer _audioplayer = AudioPlayer();

//duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
//constructor
  PlaylistProvider() {
    listenToDuration();
  }
//intially not playing
  bool _isPlaying = false;
// play song
  // void play() async {
  //   String path = _playlist?[_currentSongIndex!
  //   await _audioplayer.stop();
  //   await _audioplayer.play(AssetSource(path));
  //   _isPlaying = true;
  //   notifyListeners();
  // }

// pause cuurent song
  void pause() async {
    await _audioplayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

// resum song
  void resume() async {
    await _audioplayer.resume();
    _isPlaying = true;
  }

// pause or resume
  void pauseAndplay() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

// seek song
  void seek(Duration position) async {
    await _audioplayer.seek(position);
  }

// play next
  void playNext() {
    if (currentSongIndex != null) {
      if (currentSongIndex! < _playlist!.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

// play previous
  void playprevious() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist!.length - 1;
      }
    }
  }

// list of Duration
  void listenToDuration() {
    // total
    _audioplayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    // current
    _audioplayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    // song end
    _audioplayer.onPlayerComplete.listen((event) {
      playNext();
    });
  }
// dispose audio player

  int? _currentSongIndex;
// GETTER

  // get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  List<SongModel>? get playlist => _playlist;

// SETTER
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      // play();
    }
    notifyListeners();
  }
}
