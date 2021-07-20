import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class VoiceQuestion extends StatefulWidget {
  final String questionVoice;

  VoiceQuestion(this.questionVoice);

  @override
  _VoiceQuestionState createState() => _VoiceQuestionState();
}

class _VoiceQuestionState extends State<VoiceQuestion> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        audioPlayerState = s;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearCache();
    super.dispose();
  }

  playMusic() async {
    await audioCache.play(widget.questionVoice);
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50,
      onPressed: () {
        audioPlayerState == AudioPlayerState.PLAYING
            ? pauseMusic()
            : playMusic();
        setState(() {});
      },
      icon: Icon(audioPlayerState == AudioPlayerState.PLAYING
          ? Icons.pause_rounded
          : Icons.play_arrow_rounded),
    );
  }
}
