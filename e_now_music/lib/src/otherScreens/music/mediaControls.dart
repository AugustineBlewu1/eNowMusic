
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';

MediaControl playControl = MediaControl(
    androidIcon: 'drawable/ic_arrow_play_arrow',
    label: 'Play',
    action: MediaAction.play);

MediaControl pauseControl = MediaControl(
    androidIcon: 'drawable/ic_action_pause',
    label: 'Pause',
    action: MediaAction.pause);
MediaControl skipToNextControl = MediaControl(
    androidIcon: 'drawable/ic_action_skip_next',
    label: 'Next',
    action: MediaAction.pause);
MediaControl skipToPrevious = MediaControl(
    androidIcon: 'drawable/ic_action_skip_previous',
    label: 'Previous',
    action: MediaAction.pause);
MediaControl stopControl = MediaControl(
    androidIcon: 'drawable/ic_action_stop',
    label: 'Stop',
    action: MediaAction.pause);

class AudioPlayerTask extends BaseAudioHandler {
  BehaviorSubject<List<MediaItem>> queue =
      <MediaItem>[] as BehaviorSubject<List<MediaItem>>;

  int? _queueIndex = -1;
  AudioPlayer? _audioPlayer = new AudioPlayer();
  AudioProcessingState? _skipState;
  bool? _playing;

 // bool get hasNext => _queueIndex + 1 < _queueIndex!.length;
}
