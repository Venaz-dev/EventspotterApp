import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(widget.eventsLiveFeeds.length, (index) {
              // if (widget.liveModel.data[index].events.liveFeed.isNotEmpty) {
              //   lenght1 = widget.liveModel.data[index].events.liveFeed.length;

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
                      Container(
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
                            widget.eventsLiveFeeds[index]['km'] + " " + "miles",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 17),
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
        ]
      );
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
    if (widget.eventsLiveFeeds[index]['image'].toString().contains('mp4') &&
        widget.eventsLiveFeeds[index]['image'].toString().contains('mov')) {
      //video plater code here
      return SizedBox();
    } else {
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
}
