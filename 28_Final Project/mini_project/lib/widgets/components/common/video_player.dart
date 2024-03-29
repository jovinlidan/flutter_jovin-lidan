import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  String videoUrl;
  bool isFullscreen;
  Function() onSwitchFullscreen;
  VideoPlayerWidget(
      {Key? key,
      required this.videoUrl,
      required this.isFullscreen,
      required this.onSwitchFullscreen})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    );
    _initializeVideoPlayerFuture = _controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.dispose();
      _controller = VideoPlayerController.network(
        widget.videoUrl,
      );
      _initializeVideoPlayerFuture = _controller.initialize().then((value) {
        setState(() {});
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.isFullscreen ? 1 : 0,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_controller),
                  _ControlsOverlay(
                    controller: _controller,
                    onFullscreen: widget.onSwitchFullscreen,
                    isFullscreen: widget.isFullscreen,
                  ),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({
    Key? key,
    required this.controller,
    required this.onFullscreen,
    required this.isFullscreen,
  }) : super(key: key);

  final VideoPlayerController controller;

  final void Function() onFullscreen;
  final bool isFullscreen;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> with TickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _animationController;
  Duration _currentDuration = const Duration(seconds: 0);
  late final Timer timer;
  bool _visible = true;
  bool _showAnimatedOpacity = true;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    handleDurationSetup();
    super.initState();
  }

  void handlePlayPause() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
      _animationController.reverse();
    } else {
      widget.controller.play();
      _animationController.forward();
    }
  }

  void handleMuteUnmute() {
    if (widget.controller.value.volume == 0) {
      widget.controller.setVolume(1);
    } else {
      widget.controller.setVolume(0);
    }
  }

  void handleVisibleSetup() async {
    if (widget.controller.value.isPlaying && _visible) {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        _visible = false;
      });
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void handleDurationSetup() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _currentDuration = widget.controller.value.position;
      });
    });
  }

  void handleEndAnimatedOpacity() {
    if (_showAnimatedOpacity && !_visible) {
      setState(() {
        _showAnimatedOpacity = false;
      });
    }
  }

  @override
  void dispose() {
    timer.cancel();
    widget.controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _showAnimatedOpacity = true;
              _visible = !_visible;
            });
          },
        ),
        Container(
          alignment: Alignment.center,
          width: 80,
          height: 80,
          child: _showAnimatedOpacity
              ? (AnimatedOpacity(
                  onEnd: handleEndAnimatedOpacity,
                  opacity: _visible ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: handlePlayPause,
                    child: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      color: Colors.white,
                      size: 80,
                      semanticLabel: 'Play',
                      progress: _animation,
                    ),
                  ),
                ))
              : const SizedBox.shrink(),
        ),
        Positioned(
          bottom: 16,
          left: 12,
          child: AnimatedOpacity(
            opacity: _visible ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: Row(
              children: [
                Text(formatDuration(_currentDuration),
                    style: const TextStyle(
                      color: Colors.white,
                    )),
                Text(" / ${formatDuration(widget.controller.value.duration)}",
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 12,
          child: _showAnimatedOpacity
              ? (AnimatedOpacity(
                  onEnd: handleEndAnimatedOpacity,
                  opacity: _visible ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: handleMuteUnmute,
                        child: Icon(
                            widget.controller.value.volume == 0
                                ? Icons.volume_off_outlined
                                : Icons.volume_up_outlined,
                            color: Colors.white,
                            size: 20),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: widget.onFullscreen,
                        child: Icon(
                            widget.isFullscreen ? Icons.fullscreen_exit_outlined : Icons.fullscreen,
                            color: Colors.white,
                            size: 20),
                      ),
                    ],
                  ),
                ))
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
