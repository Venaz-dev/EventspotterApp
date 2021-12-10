import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/event_details_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Livefeeds extends StatefulWidget {
  Livefeeds(
      {Key? key,
      required this.eventsLiveFeeds,
      required this.test,
      required this.eventsModel,
      required this.id})
      : super(key: key);
  bool test;
  String id;
  EventsModel eventsModel;
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
    print("Live feeds lenght=$lenght");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (lenght > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white,
                  //   border: Border.all(color: Colors.black45,),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0.3,
                      blurRadius: 0.3,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10, top: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Event live feed",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.eventsLiveFeeds.isEmpty
                        ? const SizedBox()
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: List.generate(
                                    widget.eventsLiveFeeds.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 5.0,bottom: 3 , top : 3
                                ),
                                child: Container(
                                  height: size.height * 0.24,
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1.5,
                                        blurRadius: 1.5,
                                        offset: Offset(1.5, 0),
                                      )
                                    ],

                                    //  color: Colors.red,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Eventdetailing(
                                                    model: widget.eventsModel,
                                                    indexs: index,
                                                    id: widget.id,
                                                    eventId:
                                                        widget.eventsLiveFeeds[
                                                            index]["eventId"],
                                                  )));
                                    },
                                    child: Stack(
                                      children: [
                                        widget.eventsLiveFeeds[index][
                                                        'img'] //////////////////////////
                                                    .toString()
                                                    .contains('.mp4') ||
                                                widget.eventsLiveFeeds[index][
                                                        'img'] //////////////////////////
                                                    .toString()
                                                    .contains('.mov')
                                            ? VideoPlayerScreen(
                                                url: MainUrl +
                                                    widget.eventsLiveFeeds[
                                                        index]['img'])
                                            : Container(
                                                height: size.height * 0.2,
                                                width: size.width * 0.3,
                                                decoration: BoxDecoration(
                                                  // color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: buildimage(index)),
                                              ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              widget.eventsLiveFeeds[index]
                                                      ['km'] +
                                                  " " +
                                                  "miles",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17),
                                            )),
                                      ],
                                    ),
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
                ),
              ),
            ),
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
  VideoPlayerScreen({Key? key, required this.url}) : super(key: key);
  late String url;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String MainUrl = "https://theeventspotter.com/";
  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(widget.url);
    print(widget.url);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.setVolume(0.0);

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
    return Column(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _controller.play();

              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return Container(
                height: size.height * 0.2,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: VideoPlayer(_controller)),
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
    );
  }
}