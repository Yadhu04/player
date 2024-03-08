import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Audio Files'),
        ),
        body: const AudioList(),
      ),
    );
  }
}

class AudioList extends StatefulWidget {
  const AudioList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AudioListState createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> {
  late OnAudioQuery _audioQuery;
  List<SongModel> _songs = [];
  final AudioPlayer _audioplayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioQuery = OnAudioQuery();
    _getSongs();
    play();
  }

  Future<void> _getSongs() async {
    List<SongModel> songs = await _audioQuery.querySongs();

    setState(() {
      _songs = songs;
    });
  }

  void play() async {
    // await _audioplayer.setSourceDeviceFile(path);
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      _audioplayer.setSourceDeviceFile(file.path);
      print(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _songs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_songs[index].title),
          subtitle: Text(_songs[index].displayName),
          onTap: () {
            play();
            print('File path: ${_songs[index].uri}');
          },
        );
      },
    );
  }
}
