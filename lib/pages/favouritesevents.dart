import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/getFavouitePastEventsModel.dart';
import 'package:event_spotter/models/getFavouriteUpcomingEvents.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Fevents extends StatefulWidget {
  const Fevents({Key? key}) : super(key: key);

  @override
  State<Fevents> createState() => _FeventsState();
}

class _FeventsState extends State<Fevents> {
  bool isupcoming = true;
  String MainUrl = "https://theeventspotter.com/";
  String upcomingUrl =
      "https://theeventspotter.com/api/getFavouriteUserUpcomingEvents";
  String pastUrl = "https://theeventspotter.com/api/getFavouriteUserPastEvents";
  late SharedPreferences _sharedPreferences;
  Dio _dio = Dio();
  bool _isLoading = true;

  late String _token;
  bool test1 = false;

  bool test2 = false;
  late FavouritePastEventsModel _favouritePastEventsModel;
  late FavouriteUpcomingEventsModel _favouriteUpcomingEventsModel;
  final bool isliked = true;
  likebutton() {
    return LikeButton(
        size: 20,
        isLiked: isliked,
        likeBuilder: (isliked) {
          final color = isliked ? Colors.red : Colors.grey;
          return Icon(Icons.favorite, color: color, size: 20);
        },
        countBuilder: (count, isliked, text) {
          final color = isliked ? Colors.red : Colors.grey;
        });
  }

  @override
  void initState() {
    UpcomingEvent().whenComplete(() {
      setState(() {});
    });
    PastEvent().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentfocus = FocusScope.of(context);

          if (!currentfocus.hasPrimaryFocus) {
            currentfocus.unfocus();
          }
        },
        child: Scaffold(
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.only(top: 20.0, left: size.width * 0.05),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     top: size.height * 0.02,
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //         //height: size.height*0.1,
                        //         width: size.width * 0.8,
                        //         child: Textform(
                        //           controller: _search,
                        //           icon: Icons.search,
                        //           label: "Search",
                        //           color: const Color(0XFFECF2F3),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: size.width * 0.01,
                        //       ),
                        //       Smallbutton(
                        //         icon: FontAwesomeIcons.slidersH,
                        //         onpressed: () {
                        //           setState(() {
                        //             //swap = screens.filter;
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Elevatedbuttons(
                              sidecolor: isupcoming == true
                                  ? Colors.transparent
                                  : Colors.black,
                              text: "Upcoming",
                              textColor: isupcoming == true
                                  ? Colors.white
                                  : Colors.black,
                              coloring: isupcoming == true
                                  ? const Color(0XFF38888F)
                                  : Colors.white,
                              primary: isupcoming == true
                                  ? const Color(0XFF38888F)
                                  : Colors.white,
                              onpressed: () {
                                setState(() {
                                  isupcoming = true;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Elevatedbuttons(
                              sidecolor: isupcoming == false
                                  ? Colors.transparent
                                  : Colors.black,
                              text: "Past Events",
                              textColor: isupcoming == false
                                  ? Colors.white
                                  : Colors.black,
                              coloring: isupcoming == false
                                  ? const Color(0XFF38888F)
                                  : Colors.white,
                              onpressed: () {
                                setState(() {
                                  isupcoming = false;
                                });
                              },
                              primary: isupcoming == false
                                  ? const Color(0XFF38888F)
                                  : Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isupcoming ? upcoming(size) : past(size)
                      ],
                    ),
                  ),
                ),
        ),
      ),
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

  extras(IconData icon, String totalcount, Size size) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: 16,
          ),
          onPressed: () {},
        ),
        Text(totalcount),
      ],
    );
  }

  Future UpcomingEvent() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    print("Inside the Get upcomming function");

    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(upcomingUrl);
      print(response.data);
      // print(response.data["data"].length);
      if (response.data["data"].length > 0) {
        print(response.data);
        print("inside has data past events");
        _favouriteUpcomingEventsModel =
            FavouriteUpcomingEventsModel.fromJson(response.data);
        test1 = true;
      } else {
        print('Empty nahi ha hai');
        test1 = false;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  Future PastEvent() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    print("Inside the Get upcomming function");

    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(pastUrl);
      if (response.data["data"].length > 0) {
        print(response.data);
        print("inside has data past events");
        _favouritePastEventsModel =
            FavouritePastEventsModel.fromJson(response.data);
        test2 = true;
      } else {
        test2 = false;

        print('Empty nahi ha hai');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  upcoming(Size size) {
    if (test1 == true) {
      // ignore: prefer_is_empty
      if (_favouriteUpcomingEventsModel.data.length > 0) {
        return Padding(
            padding: EdgeInsets.only(right: size.width * 0.05),
            child: Column(
              children: List.generate(_favouriteUpcomingEventsModel.data.length,
                  (index) {
                return Padding(
                  padding: EdgeInsets.only(top: size.height * .01),
                  child: Container(
                    // width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 2)
                        ]),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 10,
                          top: 10,
                          child: likebutton(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 15, left: 15, bottom: 15),
                          child: Row(
                            children: [
                              _favouriteUpcomingEventsModel.data[index].events
                                          .eventPictures[0].imagePath
                                          .toString()
                                          .contains('.mp4') ||
                                      _favouriteUpcomingEventsModel.data[index]
                                          .events.eventPictures[0].imagePath
                                          .toString()
                                          .contains('.mov')
                                  ? VideoPlayerScreemm(
                                      url: MainUrl +
                                          _favouriteUpcomingEventsModel
                                              .data[index]
                                              .events
                                              .eventPictures[0]
                                              .imagePath)
                                  : SizedBox(
                                      height: size.height * 0.17,
                                      width: size.width * 0.3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: MainUrl +
                                              _favouriteUpcomingEventsModel
                                                  .data[index]
                                                  .events
                                                  .eventPictures[0]
                                                  .imagePath,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.35,
                                      child: AutoSizeText(
                                        _favouriteUpcomingEventsModel
                                            .data[index].events.eventName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                        maxFontSize: 16,
                                        minFontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                          _favouriteUpcomingEventsModel
                                              .data[index].events.eventDate,
                                          style: const TextStyle(
                                              color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                            _favouriteUpcomingEventsModel
                                                    .data[index].km +
                                                " " +
                                                "away",
                                            style: const TextStyle(
                                                color: Colors.black87)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ));
      } else {
        return const Center(child: Text("No favourite Upcoming Events"));
      }
    } else {
      return const Center(child: Text("No favourite Upcoming Events"));
    }
  }

  past(Size size) {
    if (test2 == true) {
      // ignore: prefer_is_empty
      if (_favouritePastEventsModel.data.length > 0) {
        return Padding(
            padding: EdgeInsets.only(right: size.width * 0.05),
            child: Column(
              children:
                  List.generate(_favouritePastEventsModel.data.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(top: size.height * .01),
                  child: Container(
                    // width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 2)
                        ]),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 10,
                          top: 10,
                          child: likebutton(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 15, left: 15, bottom: 15),
                          child: Row(
                            children: [
                              _favouritePastEventsModel.data[index].events
                                          .eventPictures[0].imagePath
                                          .toString()
                                          .contains('.mp4') ||
                                      _favouritePastEventsModel.data[index]
                                          .events.eventPictures[0].imagePath
                                          .toString()
                                          .contains('.mov')
                                  ? VideoPlayerScreemm(
                                      url: MainUrl +
                                          _favouritePastEventsModel
                                              .data[index]
                                              .events
                                              .eventPictures[0]
                                              .imagePath)
                                  : SizedBox(
                                      height: size.height * 0.17,
                                      width: size.width * 0.3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: MainUrl +
                                              _favouritePastEventsModel
                                                  .data[index]
                                                  .events
                                                  .eventPictures[0]
                                                  .imagePath,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.35,
                                      child: AutoSizeText(
                                        _favouritePastEventsModel
                                            .data[index].events.eventName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                        maxFontSize: 16,
                                        minFontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                          _favouritePastEventsModel
                                              .data[index].events.eventDate,
                                          style: const TextStyle(
                                              color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                            _favouritePastEventsModel
                                                    .data[index].km +
                                                " " +
                                                "away",
                                            style: const TextStyle(
                                                color: Colors.black87)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ));
      } else {
        return const Center(child: Text("No favourite past events"));
      }
    } else {
      return const Center(child: Text("No favourite past events"));
    }
  }
}

class VideoPlayerScreemm extends StatefulWidget {
  VideoPlayerScreemm({Key? key, required this.url}) : super(key: key);
  late String url;

  @override
  _VideoPlayerScreemmState createState() => _VideoPlayerScreemmState();
}

class _VideoPlayerScreemmState extends State<VideoPlayerScreemm> {
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
                height: size.height * 0.17,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
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
