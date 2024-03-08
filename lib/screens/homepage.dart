import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:player/components/my_drawer.dart';
import 'package:player/provider/playlist_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final AudioPlayer _audioplayer = AudioPlayer();

class _HomePageState extends State<HomePage> {
  late final PlaylistProvider playlistProvider;
  late List<SongModel> songs = [];
  final audioQuery = OnAudioQuery();
  late List<String> path;
  @override
  void initState() {
    super.initState();

    requestPermission();
    fetchSongs();
  }

  void requestPermission() async {
    await Permission.storage.request();
  }

  void fetchSongs() async {
    final result = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      sortType: null,
    );
    setState(() {
      songs = result;
    });
  }

  // void fetchpath() async {
  //   final spath = await audioQuery.queryAllPath();
  //   print(spath);
  //   print('huuuuu');

  //   setState(() {
  //     path = spath;
  //   });
  // }

  void play() async {
    await _audioplayer.play(AssetSource('audio/1 Chor.mp3'));
    print('jdkk');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text('P L A Y L I S T')),
      drawer: const MyDrawer(),
      body: songs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(songs[index].displayNameWOExt),
                subtitle: Text(songs[index].artist.toString()),
                onTap: () {
                  play();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return AudioPlayerPage(filePath: path[0]);
                  //     },
                  //   ),
                  // );
                },
              ),
            ),
    );
  }
}
