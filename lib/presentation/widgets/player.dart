import 'package:audioplayers/audioplayers.dart';
import 'package:dyslexia/constants/colors.dart';
import 'package:dyslexia/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Player extends StatefulWidget {
  final String url;
  const Player({required this.url, super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final AudioPlayer player = AudioPlayer();
  late final String url;
  bool isPlaying = false;
  bool _onDragging = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool get onDragging => _onDragging;

  @override
  void initState() {
    super.initState();

    url = widget.url;

    setAudio();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((duration) {
      setState(() {
        this.duration = duration;
      });
    });

    player.onPositionChanged.listen((position) {
      if (!onDragging) {
        setState(() {
          this.position = position;
        });
      } else {}
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future setAudio() async {
    // player.setReleaseMode(ReleaseMode.loop);
    player.setReleaseMode(ReleaseMode.stop);
    player.setSourceUrl(url);
  }

  _buildPlayButton() {
    return Material(
      elevation: 5.0,
      shape: const CircleBorder(),
      color: primaryColor,
      child: InkWell(
        onTap: () {
          if (isPlaying) {
            player.pause();
          } else {
            player.resume();
          }
        },
        customBorder: const CircleBorder(),
        child: Container(
          width: 88.0,
          height: 88.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.25),
                spreadRadius: 5,
                blurRadius: 9,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 50.0,
            ),
          ),
        ),
      ),
    );
  }

  _buildSeekButton(VoidCallback onPressed, Widget icon) {
    return IconButton(onPressed: onPressed, icon: icon);
  }

  _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 52),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildSeekButton(() async {
            await player.seek(position - const Duration(seconds: 10));
          }, SvgPicture.asset(seekBackIcon)),
          _buildPlayButton(),
          _buildSeekButton(() async {
            await player.seek(position + const Duration(seconds: 10));
          }, SvgPicture.asset(seekForwardIcon)),
        ],
      ),
    );
  }

  _buildSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 6,
          thumbShape: const RoundSliderThumbShape(
            enabledThumbRadius: 4,
            elevation: 0,
          ),
        ),
        child: Slider(
          min: 0,
          max: (duration.inMilliseconds / 100).toDouble(),
          value: (position.inMilliseconds / 100).toDouble(),
          onChanged: (value) async {
            _onDragging = true;
            setState(() {
              position = Duration(milliseconds: (value * 100).toInt());
            });
          },
          onChangeEnd: (value) async {
            await player.seek(position);
            _onDragging = false;
          },
        ),
      ),
    );
  }

  // _buildDuration() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 60),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(_formatTime(position)),
  //         Text(_formatTime(duration - position)),
  //       ],
  //     ),
  //   );
  // }

  // String _formatTime(Duration d) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final hours = twoDigits(d.inHours);
  //   final minutes = twoDigits(d.inMinutes.remainder(60));
  //   final seconds = twoDigits(d.inSeconds.remainder(60));

  //   return [
  //     if (d.inHours > 0) hours,
  //     minutes,
  //     seconds,
  //   ].join(':');
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildButtons(),
        _buildSlider(),
      ],
    );
  }
}
