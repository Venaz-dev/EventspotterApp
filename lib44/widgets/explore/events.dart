import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventTypeModel.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/event_details_page.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/userprofile.dart';
import 'package:event_spotter/widgets/explore/comment.dart';
import 'package:event_spotter/widgets/explore/livefeed.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Eventss extends StatefulWidget {
  List<int> favourite = [];
  List eventsLiveFeed = [];
  List like = [];
  List totalCount = [];
  late String id;

  EventsModel eventsModel;
  Eventss(
      {Key? key,
      required this.favourite,
      required this.eventsLiveFeed,
      required this.eventsModel,
      required this.like,
      required this.totalCount,
      required this.id})
      : super(key: key);

  @override
  State<Eventss> createState() => _EventssState();
}

class _EventssState extends State<Eventss> {
  final Dio _dio = Dio();
  late SharedPreferences _sharedPreferences;
  late String _token;
  // late int lenght;
  late String formatted;

  late String valuee;
  //bool _isLoading = true;
  // late EventsModel _eventsModel;
  //late List eventsLiveFeed = [];
  bool test = false;
  bool active = false;
  String isFollow = "follow";
//late String id;
  late int bb;
  //late int totalcount;
  late EventTypeModel _eventTypeModel;
  // String urlEvent = "https://theeventspotter.com/api/getEvents";
  String Favourite = "https://theeventspotter.com/api/favrouite";
  String UnFavourite = "https://theeventspotter.com/api/unfavrouit";
  String MainUrl = "https://theeventspotter.com/";
  String PostlikeUrl = "https://theeventspotter.com/api/like";

  //late List<int> favourite = [];

  @override
  void initState() {
    super.initState();
    // getEvetns().whenComplete(() {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // String description = "new year party at local park";

    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Livefeeds(
          eventsLiveFeeds: widget.eventsLiveFeed,
          test: test,
          eventsModel: widget.eventsModel,
          id: widget.id,
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Events near you",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          ),
        ),
        Column(
          children: List.generate(widget.eventsModel.data.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Eventdetailing(
                            model: widget.eventsModel,
                            indexs: index,
                            id: widget.id,
                          )));
                },
                child: Container(
                
                  decoration: const BoxDecoration(
                    color:  Colors.white,
                    // borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 3,
                          blurRadius: 3,
                          color: Colors.black12,
                         
                          ),
                      
                    ],
                  ),
                  child: Column(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 5, left: 5, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Button(
                              onpressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Eventposterprofile(
                                          id: widget.eventsModel.data[index]
                                              .events.user.id,
                                        )));
                              },
                              title: widget.eventsModel.data[index].events
                                  .user.name, //new
                              radiusofbutton: BorderRadius.circular(20),
                              profileImage: MainUrl +
                                  widget.eventsModel.data[index].events.user
                                      .profilePicture!.image),
                          SizedBox(
                              height: size.height * 0.04,
                              width: size.width * 0.25,
                              // decoration: const BoxDecoration(color: Color(0XFF38888E)),
                              child: followingcheck(index)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 3, bottom: 3),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          widget.eventsModel.data[index].events.eventName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 17),
                          maxFontSize: 17,
                          minFontSize: 10,
                          maxLines: 5,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          //borderRadius: BorderRadius.circular(15),
                          ),
                      width: size.width * double.infinity,
                      child: Stack(children: [
                        
                        widget.eventsModel.data[index].events.eventPictures[0]
                                    .imagePath
                                    .toString()
                                    .contains('.mp4') ||
                                widget.eventsModel.data[index].events
                                    .eventPictures[0].imagePath
                                    .toString()
                                    .contains('.mov')
                            ? VideoPlayerScreenn(
                                url: MainUrl +
                                    widget.eventsModel.data[index].events
                                        .eventPictures[0].imagePath)

                                      

                                        
                            : Container(
                                height: size.height * 0.4,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    // borderRadius: BorderRadius.circular(20)
                                    ),
                                child: Center(
                                  child: Container(
                                       height: size.height * 0.4,
                                       width: double.infinity,
                                    child: CachedNetworkImage(
                                    
                                      alignment : Alignment.center,
                                      imageUrl: MainUrl +
                                          widget.eventsModel.data[index].events
                                              .eventPictures[0].imagePath,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                        Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                                onPressed: () {
                                  if (widget.favourite[index] == 1) {
                                    widget.favourite[index] = 0;
                                    PostDislike(
                                        index,
                                        widget.eventsModel.data[index].events
                                            .id);
                                  } else {
                                    widget.favourite[index] = 1;
                                    PostLike(
                                        index,
                                        widget.eventsModel.data[index].events
                                            .id);
                                  }
                                  setState(() {});
                                },
                                icon: Icon(MdiIcons.heart,
                                    color: widget.favourite[index] == 0
                                        ? Colors.grey
                                        : Colors.red))),
                      ]),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(color: Colors.black12),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8, left: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Buttonicon(
                                    radiusofbutton: BorderRadius.circular(20),
                                    icon: FontAwesomeIcons.userPlus,
                                    title: widget.eventsModel.data[index]
                                            .events.user.followers.length
                                            .toString() +
                                        " " "Followers",
                                  ),
                               
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.calendar,
                                        size: 13,
                                        color: Colors.black54,
                                      ),
                                      const   SizedBox(width : 5),
                                      Text(
                                        time(index),
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                 
                                  Row(
                                    children : [
                                  const Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    size: 15,
                                    color: Colors.black54,
                                  ),
                                  Text(
                                      widget.eventsModel.data[index].km
                                              .toString() +
                                          " " +
                                          "away",
                                      style: const TextStyle(
                                          color: Colors.black87)),
                                    ]
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.black12),
                              ),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // extras(
                                  //     FontAwesomeIcons.thumbsUp,
                                  //     _eventsModel.data[index].isLiked
                                  //         .toString(),
                                  //     size, () {
                                  //   postThumbs(_eventsModel
                                  //       .data[index].events.id);
                                  // }),
                                  likefunction(
                                      index, FontAwesomeIcons.thumbsUp),
                                  divider(),
                                  extras(
                                      Icons.comment,
                                      widget.eventsModel.data[index].events
                                          .comment.length
                                          .toString(),
                                      size, () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Commentofuser(
                                                  eventsModel:
                                                      widget.eventsModel,
                                                  index: index,
                                                )));
                                  }),
                                  divider(),

                                  // extras(MdiIcons.share,
                                  //     posts[1]['share'], size),
                                  // divider(),                           //no inculded
                                  extras(
                                      Icons.play_arrow,
                                      widget.eventsModel.data[index].events
                                          .liveFeed.length
                                          .toString(),
                                      size,
                                      () {}),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            );
          }),
        ),
      ],
    
    );
  }

  VerticalDivider divider() {
    return const VerticalDivider(
      thickness: 1,
      color: Colors.black26,
      indent: 13,
      endIndent: 13,
    );
  }

  extras(IconData icon, String totalcount, Size size, VoidCallback onpress) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
            onPressed: onpress),
        Text(totalcount),
      ],
    );
  }

  likefunction(int index, IconData icon) {
    return Row(
      children: [
        IconButton(
          icon: Icon(icon,
              size: 16,
              color: widget.like[index] == 1 ? Colors.blue : Colors.black),
          onPressed: () async {
            if (widget.like[index] == 0) {
              widget.like[index] = 1;
              widget.totalCount[index]++;
            } else {
              widget.like[index] = 0;
              widget.totalCount[index]--;
            }
            await postThumbs(widget.eventsModel.data[index].events.id);
            setState(() {});
          },
        ),
        Text(widget.totalCount[index].toString()),
      ],
    );
  }

  
  PostDislike(int index, int eventId) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    FormData formData = new FormData.fromMap({
      "event_id": eventId,
    });
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      await _dio.post(UnFavourite, data: formData).then((value) {
        print(value.data.toString());
        if (value.data['success'] == true) {
          // showToaster("UnFavourite");
        }
      });
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  PostLike(int index, int eventId) async {
    // print("inside postlike");
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    FormData formData = new FormData.fromMap({
      "event_id": eventId,
    });
    // try {
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    try {
      await _dio.post(Favourite, data: formData).then((value) {
        print(value.toString());
        if (value.data['status'] == true) {
          print(value.data.toString());

          // showToaster("Favourite");
        }
      });
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  followingcheck(int index) {
    if (widget.eventsModel.data[index].events.user.id.toString() != widget.id) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Eventposterprofile(
                    id: widget.eventsModel.data[index].events.user.id,
                  )));
        },
        style: ElevatedButton.styleFrom(
          primary: const Color(0XFF38888E),
        ),
        child: const Text("Follow"),
      );
    } else {
      return const SizedBox();
    }
  }

  // listFav() {
  //   if (_eventsModel.data.length > 0) {
  //     for (int i = 0; i < _eventsModel.data.length; i++) {
  //       var value = _eventsModel.data[i].isFavroute;
  //       favourite.add(value);
  //     }
  //   } else {
  //     favourite.add(0);
  //   }
  // }

  Future<void> postThumbs(int id) async {
    int count = 0;
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    FormData formData = FormData.fromMap({
      "event_id": id,
    });
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.post(PostlikeUrl, data: formData);
      if (response.statusCode == 200) {
        print('Like ');
      } else {
        print('ERROR');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
  }

  String time(int index) {
    DateTime parseDate = DateFormat("yyyy-mm-dd")
        .parse(widget.eventsModel.data[index].events.eventDate);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('mm/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }
}

class VideoPlayerScreenn extends StatefulWidget {
  VideoPlayerScreenn({Key? key, required this.url}) : super(key: key);
  late String url;

  @override
  _VideoPlayerScreennState createState() => _VideoPlayerScreennState();
}

class _VideoPlayerScreennState extends State<VideoPlayerScreenn> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
//String MainUrl = "https://theeventspotter.com/";
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
    _controller.setVolume(100);

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
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return SizedBox(
                height: size.height * 0.4,
                width: double.infinity,

                child: SizedBox(
                  child: ClipRRect(
                    //  borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        ControlsOverlay(controller: _controller),
                        VideoProgressIndicator(_controller,
                            allowScrubbing: true),
                      ],
                    ),
                  ),
                ),
                //borderRadius: BorderRadius.circular(20),
                //    child: VideoPlayer(_controller),
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
        
      ],
    );
  }
}

class ControlsOverlay extends StatefulWidget {
  ControlsOverlay({Key? key, required this.controller}) : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  VideoPlayerController controller;

  @override
  State<ControlsOverlay> createState() => ControlsOverlayState();
}

class ControlsOverlayState extends State<ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
            setState(() {});
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: widget.controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              widget.controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in ControlsOverlay._examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${widget.controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
