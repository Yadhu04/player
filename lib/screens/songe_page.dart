import 'package:flutter/material.dart';
import 'package:player/components/neo_box.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatedTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formatedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formatedTime;
  }

  @override
  Widget build(BuildContext context) {
//     return Consumer<PlaylistProvider>(
//       builder: (context, value, child) {
// //get playlist
//         final playlist = value.playlist;
// //get currebt song index
//         final currentsong = playlist?[value.currentSongIndex!];
//         //return scaffold ui
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              const Text(
                'S O N G E S',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          NeoBox(
              child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const Icon(
                    Icons.music_note,
                    size: 200,
                  )),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'name',
                        // currentsong!.displayName,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text('artist')
                    ],
                  ),
                  Icon(Icons.favorite_border)
                ],
              )
            ],
          )),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('00'),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.shuffle)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.repeat)),
                    const Text('00')
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 0)),
                child: Slider(
                  min: 0,
                  max: 100, //value.totalDuration.inSeconds.toDouble(),
                  value: 50, //value.currentDuration.inSeconds.toDouble(),
                  activeColor: Colors.green,
                  onChanged: (double double) {},
                  // onChangeEnd: (double double) {
                  //   value.seek(Duration(seconds: double.toInt()));
                  // },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      // value.playprevious();
                    },
                    child:
                        const NeoBox(child: Icon(Icons.skip_previous_rounded))),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                    onTap: () {
                      // value.pauseAndplay();
                    },
                    child: const NeoBox(child: Icon(Icons.play_arrow)
                        //  Icon(value.isPlaying
                        //     ? Icons.pause
                        //     : Icons.play_arrow_rounded)
                        )),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      // value.playNext();
                    },
                    child: const NeoBox(child: Icon(Icons.skip_next_rounded))),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      )),
    );
  }
}
