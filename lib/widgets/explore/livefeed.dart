import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart';

class Livefeeds extends StatefulWidget {
  Livefeeds({Key? key, required this.eventsLiveFeeds, required this.test})
      : super(key: key);
  bool test;
  late List eventsLiveFeeds;

  @override
  State<Livefeeds> createState() => _LivefeedsState();
}

class _LivefeedsState extends State<Livefeeds> {
  @override
  bool video = false;
  late int lenght;
  late VideoPlayerController _controller;

  String MainUrl = "https://theeventspotter.com/";
  void initState() {
    super.initState();
    lenght = widget.eventsLiveFeeds.length;
    print(widget.eventsLiveFeeds[0]);
    // print('hello g $lenght');
    //lenght = lenght - 1;
    // print(lenght);
    // _controller = VideoPlayerController.network(
    //     MainUrl + widget.eventsLiveFeeds[1]['img']);

    // _controller.addListener(() {
    //   setState(() {});
    // });
    // _controller.setLooping(true);
    // _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.test == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Event live feed",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.eventsLiveFeeds.isEmpty
              ? const SizedBox()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children:
                          List.generate(widget.eventsLiveFeeds.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      child: Container(
                        height: size.height * 0.23,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // color: Colors.red,
                        ),
                        child: Stack(
                          children: [
                            widget.eventsLiveFeeds[index]
                                        ['img'] //////////////////////////
                                    .toString()
                                    .contains('.mp4')
                                ? VideoPlayerScreen(
                                    url: MainUrl +
                                        widget.eventsLiveFeeds[index]['img'])
                                : Container(
                                    height: size.height * 0.2,
                                    width: size.width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: buildimage(index)),
                                  ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  widget.eventsLiveFeeds[index]['km'] +
                                      " " +
                                      "miles",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                )),
                          ],
                        ),
                      ),
                    );

                    // } else {
                    //   //index = index + 1;
                    //   return const SizedBox();
                    // }
                  })),
                ),
        ],
      );
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Event live feed",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
          ]);
    }
  }
  // buildlivefeed(BuildContext context, videoUrl)
  //  {
  //   _controller = VideoPlayerController.network(videoUrl);

  //   _controller.addListener(() {
  //     setState(() {});
  //   });
  //   _controller.setLooping(true);
  //   _controller.initialize().then((_) => setState(() {}));
  //   _controller.play();

  // }

  Widget buildimage(int index) {
    return CachedNetworkImage(
      imageUrl: MainUrl + widget.eventsLiveFeeds[index]['img'],
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key? key, required url}) : super(key: key);
  late String url;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
        'https://theeventspotter.com/images/eventImage/1637935035.mp4');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                                  _controller.play();

                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return Container(
                  height:100,width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    
                  ),
                  child: VideoPlayer(_controller),
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
          // ElevatedButton(
          //     onPressed: () {
          //       // If the video is playing, pause it.
          //       if (_controller.value.isPlaying) {
          //         _controller.pause();
          //       } else {
          //         // If the video is paused, play it.
          //         _controller.play();
          //       }
          //       setState(() {});
          //     },
          //     child: Text('PLAY'))
        ],
      ),
    );
  }
}
