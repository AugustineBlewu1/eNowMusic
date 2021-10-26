import 'dart:math';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';

class SeekBar extends StatefulWidget {
  const SeekBar(
      {Key? key,
      required this.duration,
      required this.position,
      this.bufferedPosition,
      this.onChanged,
      this.onChangedEnd})
      : super(key: key);
  final Duration duration;
  final Duration position;
  final Duration? bufferedPosition;
  final ValueChanged<Duration?>? onChanged;
  final ValueChanged<Duration?>? onChangedEnd;
  

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  SliderThemeData? _sliderThemeData;

  @override
  void didChangeDependencies() {
    _sliderThemeData = SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.deepPurple,
        inactiveTrackColor: Colors.deepPurple,
        thumbColor: Colors.deepPurple,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
        trackHeight: 2.0);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
            data: _sliderThemeData!.copyWith(
                activeTrackColor: Colors.purple.shade200,
                inactiveTickMarkColor: Colors.grey.shade300,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 0.0)),
            child: ExcludeSemantics(
              child: Slider(
                min: 0.0,
                max: widget.duration.inMilliseconds.toDouble(),
                value: widget.bufferedPosition!.inMilliseconds.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _dragValue = value;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(Duration(milliseconds: value.round()));
                  }
                },
                onChangeEnd: (value) {
                  if (widget.onChangedEnd != null) {
                    widget.onChangedEnd!(Duration(milliseconds: value.round()));
                  }
                  _dragValue = null;
                },
              ),
            )),
        SliderTheme(
            data: _sliderThemeData!.copyWith(
                inactiveTrackColor: Colors.transparent,
                valueIndicatorTextStyle: const TextStyle(color: Colors.white)),
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(
                  _dragValue ?? widget.position.inMilliseconds.toDouble(),
                  widget.duration.inMilliseconds.toDouble()),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });

                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangedEnd != null) {
                  widget.onChangedEnd!(Duration(milliseconds: value.round()));
                }

                _dragValue = null;
              },
            )),
        Positioned(
            right: 16.0,
            bottom: 0.0,
            child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("$_remaining")
                      ?.group(1) ??
                  '$_remaining',
              style: context.textTheme.caption,
            ))
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}
