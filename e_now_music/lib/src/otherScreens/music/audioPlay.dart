import 'package:e_now_music/src/otherScreens/music/seekBar.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:e_now_music/src/utils/navigators.dart';

class AudioPlay extends StatefulWidget {
  const AudioPlay({Key? key, this.audio}) : super(key: key);
  final audio;

  @override
  _AudioPlayState createState() => _AudioPlayState();
}

class _AudioPlayState extends State<AudioPlay> {
  late AudioPlayer _audioPlayer;
  String? audio =
      'https://ia801802.us.archive.org/8/items/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3';

  bool fetching = false;

  @override
  void initState() {
    loadAudio();

    super.initState();
  }

  loadAudio() async {
    _audioPlayer = AudioPlayer();

    await _audioPlayer
        .setAudioSource(AudioSource.uri(Uri.parse(audio!)))
        .catchError((error) {
      print('Error : $error');
      context.showSnackError(error: error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlayButtons(_audioPlayer);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

class PlayButtons extends StatelessWidget {
  const PlayButtons(
    this.audio, {
    Key? key,
  }) : super(key: key);
  final AudioPlayer audio;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20.0,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: StreamBuilder<Duration?>(
          stream: audio.durationStream,
          builder: (context, snapshot) {
            final duration = snapshot.data ?? Duration.zero;

            /* PositionData is a class we'll define in a sec */
            return StreamBuilder<PositionData>(
              stream: Rx.combineLatest2<Duration, Duration, PositionData>(
                audio.positionStream,
                audio.bufferedPositionStream,
                (position, bufferedPosition) =>
                    PositionData(position, bufferedPosition),
              ),
              builder: (context, snapshot) {
                final positionData =
                    snapshot.data ?? PositionData(Duration.zero, Duration.zero);
                var position = positionData.position;
                if (position > duration) {
                  position = duration;
                }
                var bufferedPosition = positionData.bufferedPosition;
                if (bufferedPosition > duration) {
                  bufferedPosition = duration;
                }

                /* SEEKBAR IS A WIDGET WE'LL DEFINE IN A SEC */
                return SeekBar(
                  duration: duration,
                  position: position,
                  bufferedPosition: bufferedPosition,
                  onChangedEnd: (newPosition) {
                    audio.seek(newPosition ?? const Duration());
                  },
                );
              },
            );
          },
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        'Sunday Morning',
        style: context.textTheme.headline3,
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        'By kwaku Awu',
        style: context.textTheme.caption!
            .copyWith(fontSize: 18.0, color: eNowColor.withOpacity(0.5)),
      ),
      SizedBox(
        height: 30.0,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // StreamBuilder(
            //     stream: audio!.shuffleModeEnabledStream,
            //     builder: (context, snapshot) {
            //       return _shuffleButton(context, snapshot.data!! ?? false);
            //     })
            //previousButton
            StreamBuilder<SequenceState?>(
                stream: audio.sequenceStateStream,
                builder: (_, __) {
                  return _previousButton();
                }),

            //PauseandPlayButton
            StreamBuilder<PlayerState?>(
                stream: audio.playerStateStream,
                builder: (_, snapshot) {
                  if (snapshot.hasData) return audioStateWidget(snapshot.data!);
                  return SizedBox.shrink();
                }),

            StreamBuilder(
                stream: audio.sequenceStateStream,
                builder: (_, __) {
                  return _nextButton();
                })
          ],
        ),
      ),
    ]);
  }

  Widget _previousButton() {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.skip_previous_outlined,
          size: 30.0,
        ));
  }

  Widget audioStateWidget(PlayerState playerState) {
    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
          height: 40.0, width: 40.0, child: CircularProgressIndicator());
    } else if (audio.playing != true) {
      return IconButton(
          onPressed: audio.play,
          icon: Icon(
            Icons.play_circle_fill_rounded,
            size: 40,
          ));
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        onPressed: audio.pause,
        icon: Icon(
          Icons.pause,
          size: 30.0,
        ),
      );
    } else {
      return IconButton(
          onPressed: () {
            audio.seek(Duration.zero, index: audio.effectiveIndices?.first);
          },
          icon: Icon(
            Icons.replay,
            size: 30.0,
          ));
    }
  }

  Widget _nextButton() {
    return IconButton(
      icon: Icon(
        Icons.skip_next_outlined,
        size: 30.0,
      ),
      onPressed: () => audio.hasNext ? audio.seekToNext() : null,
    );
  }

  // Widget _shuffleButton(BuildContext context, bool enabled) {
  //   return IconButton(
  //       onPressed: () {},
  //       icon: enabled ? Icon(Icons.shuffle) : Icon(Icons.shuffle));
  // }
}
