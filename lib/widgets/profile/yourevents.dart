import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/constant/json/post.dart';
import 'package:event_spotter/models/userDraftEvents.dart';
import 'package:event_spotter/models/userPastEvents.dart';
import 'package:event_spotter/models/userUpcomingEvent.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

enum yourevent { upcoming, pastevents, drafts }

class Yourevents extends StatefulWidget {
  const Yourevents({
    Key? key,
    required this.images,
    required this.size,
  }) : super(key: key);

  final List images;
  final Size size;

  @override
  State<Yourevents> createState() => _YoureventsState();
}

class _YoureventsState extends State<Yourevents> {
  yourevent eventshuffling = yourevent.upcoming;
  late GetUserUpcomingEvents _getUserUpcomingEvents;
  late GetUserDraftEvents _getUserDraftEvents;
  late UserPastEvents _userPastEvents;
  String getUpComingEventUrl =
      "https://theeventspotter.com/api/getUserUpcomingEvents";
  String getPastEventsUrl = "https://theeventspotter.com/api/getUserPastEvent";
  String getDraftUrl = "https://theeventspotter.com/api/getUserDraftEvent";
  String MainUrl = "https://theeventspotter.com/";
  late SharedPreferences _sharedPreferences;
  Dio _dio = Dio();
  late String _token;
  bool test = false;
  bool test1 = false;
  bool test2 = false;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    getUpComingEvents().whenComplete(() {
      setState(() {});
    });
    getPastEvents().whenComplete(() {
      setState(() {});
    });
    getDaftEvents().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(
                            0,
                            0,
                          )),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your Events",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        eventstype(),
                      ]),
                ),
              ),
            ],
          );
  }

  Widget eventstype() {
    switch (eventshuffling) {
      case yourevent.upcoming:
        return upcoming();

      case yourevent.pastevents:
        return past();

      case yourevent.drafts:
        return drafts();
    }
  }

  Widget upcoming() {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: Row(
            children: [
              Elevatedbuttons(
                sidecolor: Colors.white,
                primary: const Color(0XFF38888F),
                text: "Upcoming",
                textColor: Colors.white,
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    setState(() {
                      eventshuffling = yourevent.upcoming;
                    });
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Past Events",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.pastevents;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Drafts",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.drafts;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        upcomingeventlist(), ////////////////////////////
      ],
    );
  }

  Widget past() {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: Row(
            children: [
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Upcoming",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.upcoming;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: Colors.white,
                primary: const Color(0XFF38888F),
                text: "Past Events",
                textColor: Colors.white,
                coloring: const Color(0XFF38888F),
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.pastevents;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Drafts",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.drafts;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        pasEventslist(), //////////////////////////
      ],
    );
  }

  Widget drafts() {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: Row(
            children: [
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Upcoming",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.upcoming;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Past Events",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.pastevents;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: Colors.white,
                primary: const Color(0XFF38888F),
                text: "Drafts",
                textColor: Colors.white,
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    setState(() {
                      eventshuffling = yourevent.upcoming;
                    });
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        userDraftlist(), ///////////////////////
      ],
    );
  }

  getUpComingEvents() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    print("Inside the Get upcomming function");

    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(getUpComingEventUrl);
      if (response.data["data"].length > 0) {
        print(response.data);
        print("inside has data");
        _getUserUpcomingEvents = GetUserUpcomingEvents.fromJson(response.data);
        setState(() {
          test = true;
        });
      } else {
        test = false;
        print('Empty data nahi hai');
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  getPastEvents() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    print("Inside the Get upcomming function");

    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(getPastEventsUrl);
      if (response.data["data"].length > 0) {
        print(response.data);
        print("inside has data past events");
        _userPastEvents = UserPastEvents.fromJson(response.data);
        setState(() {
          test1 = true;
        });
      } else {
        test1 = false;
        print('Empty nahi ha hai');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  getDaftEvents() async {
    print("Inside the Get upcomming function");
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(getDraftUrl);
      if (response.data["data"].length > 0) {
        print(response.data);
        print("inside has data Draft events");
        _getUserDraftEvents = GetUserDraftEvents.fromJson(response.data);
        setState(() {
          test2 = true;
        });
      } else {
        test2 = false;
        print('Empty nahi ha hai in Draft');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  upcomingeventlist() {
    if (test) {
      return Column(
        children: List.generate(_getUserUpcomingEvents.data.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FittedBox(
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, right: 15, left: 15, bottom: 15),
                  child: Row(
                    children: [
                      _getUserUpcomingEvents
                                  .data[index].events.eventPictures[0].imagePath
                                  .toString()
                                  .contains('.mp4') ||
                              _getUserUpcomingEvents
                                  .data[index].events.eventPictures[0].imagePath
                                  .toString()
                                  .contains('.mov')
                          ? VideoPlayerScreennn(
                              url: MainUrl +
                                  _getUserUpcomingEvents.data[index].events
                                      .eventPictures[0].imagePath)
                          : SizedBox(
                              height: widget.size.height * 0.17,
                              width: widget.size.width * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: MainUrl +
                                      _getUserUpcomingEvents.data[index].events
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getUserUpcomingEvents
                                  .data[index].events.eventName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
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
                                  _getUserUpcomingEvents
                                      .data[index].events.location,
                                  style: const TextStyle(color: Colors.black87),
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
                                    _getUserUpcomingEvents.data[index].km +
                                        " " +
                                        "away",
                                    style:
                                        const TextStyle(color: Colors.black87)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      );
    } else {
      return const Text("No Upcoming Events");
    }
  }

  pasEventslist() {
    if (test1) {
      return Column(
        children: List.generate(_userPastEvents.data.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FittedBox(
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, right: 15, left: 15, bottom: 15),
                  child: Row(
                    children: [
                      _userPastEvents
                                  .data[index].events.eventPictures[0].imagePath
                                  .toString()
                                  .contains('.mp4') ||
                              _userPastEvents
                                  .data[index].events.eventPictures[0].imagePath
                                  .toString()
                                  .contains('.mov')
                          ? VideoPlayerScreennn(
                              url: MainUrl +
                                  _userPastEvents.data[index].events
                                      .eventPictures[0].imagePath)
                          : SizedBox(
                              height: widget.size.height * 0.17,
                              width: widget.size.width * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: MainUrl +
                                      _userPastEvents.data[index].events
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userPastEvents.data[index].events.eventName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
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
                                  _userPastEvents.data[index].events.location,
                                  style: const TextStyle(color: Colors.black87),
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
                                    _userPastEvents.data[index].km +
                                        " " +
                                        "away",
                                    style:
                                        const TextStyle(color: Colors.black87)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      );
    } else {
      return const Center(
        child: Text('No past events'),
      );
    }
  }

  userDraftlist() {
    if (test2) {
      return Column(
        children: List.generate(_getUserDraftEvents.data.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FittedBox(
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, right: 15, left: 15, bottom: 15),
                  child: Row(
                    children: [
                      _getUserDraftEvents
                                  .data[index].events.eventPictures[0].imagePath
                                  .toString()
                                  .contains('.mp4') ||
                              _getUserDraftEvents
                                  .data[index].events.eventPictures[0].imagePath
                                  .toString()
                                  .contains('.mov')
                          ? VideoPlayerScreennn(
                              url: MainUrl +
                                  _getUserDraftEvents.data[index].events
                                      .eventPictures[0].imagePath)
                          : SizedBox(
                              height: widget.size.height * 0.17,
                              width: widget.size.width * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: MainUrl +
                                      _getUserDraftEvents.data[index].events
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getUserDraftEvents.data[index].events.eventName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
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
                                  _getUserDraftEvents
                                      .data[index].events.location,
                                  style: const TextStyle(color: Colors.black87),
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
                                    _getUserDraftEvents.data[index].km +
                                        " " +
                                        "away",
                                    style:
                                        const TextStyle(color: Colors.black87)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      );
    } else {
      return const Text("No Drafts Saved");
    }
  }
}

class VideoPlayerScreennn extends StatefulWidget {
  VideoPlayerScreennn({Key? key, required this.url}) : super(key: key);
  late String url;

  @override
  _VideoPlayerScreennnState createState() => _VideoPlayerScreennnState();
}

class _VideoPlayerScreennnState extends State<VideoPlayerScreennn> {
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
