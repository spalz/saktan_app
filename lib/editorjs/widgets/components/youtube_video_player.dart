import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const YoutubeVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.caption,
  }) : super(key: key);

  @override
  YoutubeVideoPlayerState createState() => YoutubeVideoPlayerState();
}

class YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    String videoId =
        YoutubePlayerController.convertUrlToId(widget.videoUrl) ?? 'x';

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        YoutubePlayerScaffold(
          controller: _controller,
          aspectRatio: 16 / 9,
          enableFullScreenOnVerticalDrag: true,
          builder: (context, player) {
            return player;
          },
        ),
        if (widget.caption.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              widget.caption,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
