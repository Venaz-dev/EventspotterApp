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
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Eventss extends StatefulWidget {
  const Eventss({Key? key}) : super(key: key);

  @override
  State<Eventss> createState() => _EventssState();
}

class _EventssState extends State<Eventss> {
  final Dio _dio = Dio();
  late SharedPreferences _sharedPreferences;
  late String _token;
  late int lenght;
  late String valuee;
  bool _isLoading = true;
  late EventsModel _eventsModel;
  late List eventsLiveFeed = [];
  bool test = false;
  bool active = false;
  String isFollow = "follow";
  late String id;
  late EventTypeModel _eventTypeModel;
  String urlEvent = "https://theeventspotter.com/api/getEvents";
  String Favourite = "https://theeventspotter.com/api/favrouite";
  String UnFavourite = "https://theeventspotter.com/api/unfavrouit";
  String MainUrl = "https://theeventspotter.com/";
  String PostlikeUrl = "https://theeventspotter.com/api/like";

  @override
  void initState() {
    super.initState();
    getEvetns().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // String description = "new year party at local park";

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Livefeeds(eventsLiveFeeds: eventsLiveFeed, test: test),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Events near you",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  children:
                      List.generate(lenght = _eventsModel.data.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Eventdetailing(
                                    model: _eventsModel,
                                    indexs: index,
                                  )));
                        },
                        child: Container(
                          height: size.height * 0.38,
                          width: size.width * double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  color: Colors.black12)
                            ],
                          ),
                          child: Column(children: [
                            Container(
                              height: size.height * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: size.width * double.infinity,
                              child: Stack(children: [
                                _eventsModel.data[index].events.eventPictures[0]
                                            .imagePath
                                            .toString()
                                            .contains('.mp4') ||
                                        _eventsModel.data[index].events
                                            .eventPictures[0].imagePath
                                            .toString()
                                            .contains('.mov')
                                    ? VideoPlayerScreenn(
                                        url: MainUrl +
                                            _eventsModel.data[index].events
                                                .eventPictures[0].imagePath)
                                    : Container(
                                        height: size.height * 0.25,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: MainUrl +
                                                _eventsModel.data[index].events
                                                    .eventPictures[0].imagePath,
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
                                Positioned(
                                  right: 10,
                                  top: size.height * 0.02,
                                  child: SizedBox(
                                      height: size.height * 0.04,
                                      width: size.width * 0.25,
                                      // decoration: const BoxDecoration(color: Color(0XFF38888E)),
                                      child: followingcheck(index)),
                                ),
                                Positioned(
                                  top: size.height * 0.07,
                                  right: 20,
                                  child: LikeButton(
                                    size: 20,
                                    onTap: (isLiked) {
                                      print("hello");

                                      if (active == isLiked) {
                                        setState(() {
                                          active = !active;
                                          print(active);
                                        });
                                        return PostLike(index,
                                            _eventsModel.data[index].events.id);
                                      } else {
                                        return PostDislike(index,
                                            _eventsModel.data[index].events.id);
                                      }
                                    },
                                    likeBuilder: (isLiked) {
                                      final color =
                                          active ? Colors.red : Colors.grey;
                                      return Icon(Icons.favorite,
                                          color: color, size: 20);
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: size.width * 0.02,
                                  left: size.width * 0.02,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Button(
                                          onpressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Eventposterprofile(
                                                          id: _eventsModel
                                                              .data[index]
                                                              .events
                                                              .user
                                                              .id,
                                                        )));
                                          },
                                          title: _eventsModel.data[index].events
                                              .user.name, //new
                                          radiusofbutton:
                                              BorderRadius.circular(20),
                                          profileImage: MainUrl +
                                              _eventsModel.data[index].events
                                                  .user.profilePicture!.image!),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Buttonicon(
                                        radiusofbutton:
                                            BorderRadius.circular(20),
                                        icon: FontAwesomeIcons.userPlus,
                                        title: _eventsModel.data[index].events
                                                .user.followers.length
                                                .toString() +
                                            " " "Followers",
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              height: size.height * 0.12,
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: size.height * 0.008,
                                    right: size.width * 0.020,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                          _eventsModel
                                              .data[index].events.eventDate
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                            _eventsModel.data[index].km
                                                    .toString() +
                                                " " +
                                                "away",
                                            style: const TextStyle(
                                                color: Colors.black87)),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      top: size.height * 0.04,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          _eventsModel.data[index].events
                                              .eventDescription,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: size.width * 0.01,
                                    left: size.width * 0.01,
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
                                              _eventsModel.data[index].events
                                                  .comment.length
                                                  .toString(),
                                              size, () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Commentofuser(
                                                          eventsModel:
                                                              _eventsModel,
                                                          index: index,
                                                        )));
                                          }),
                                          divider(),

                                          // extras(MdiIcons.share,
                                          //     posts[1]['share'], size),
                                          // divider(),                           //no inculded
                                          extras(
                                              Icons.live_tv,
                                              _eventsModel.data[index].events
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
              size: 16,
            ),
            onPressed: onpress),
        Text(totalcount),
      ],
    );
  }

  likefunction(int index, IconData icon) {
    print(_eventsModel.data[index].totalLikes.toString());
    String likecount = _eventsModel.data[index].totalLikes.toString();
    String vv = "0";

    return Row(
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: 16,
          ),
          onPressed: () async {
            setState(() {
              print("insde setstate");
              likecount = vv;
            });
            print('asdf');
            vv = await postThumbs(_eventsModel.data[index].events.id);
            print('HELLO G $vv');
          },
        ),
        Text(likecount),
      ],
    );
  }

  Future getEvetns() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    id = _sharedPreferences.getString('id')!;
    print("Inside the Get Event function");
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(urlEvent);
      //print(response.data);
      if (response.statusCode == 200) {
        _eventsModel = EventsModel.fromJson(response.data);

        lenght = _eventsModel.data.length;
        for (int i = 0; i < _eventsModel.data.length; i++) {
          var km = _eventsModel.data[i].km;
          if (_eventsModel.data[i].events.liveFeed.isNotEmpty) {
            for (int j = 0;
                j < _eventsModel.data[i].events.liveFeed.length;
                j++) {
              var js = {
                'img': _eventsModel.data[i].events.liveFeed[j].path,
                'km': km,
              };
              test = true;
              eventsLiveFeed.add(js);
            }
          } else {
            test = false;
          }
        }
        print(lenght);
        // print(MainUrl + _eventsModel.data[0].events.user.profilePicture.image);
      }
    } catch (e) {
      print(e.toString() + "Catch");
    } finally {
      _isLoading = false;
    }
    setState(() {});
  }

//   isliked(bool like, int index) {
//     print(_eventsModel.data[index].isFavroute.toInt());
//     if (_eventsModel.data[index].isFavroute.toInt() == 1) {
//       setState(() {
//         active = !active;

//       });
// return !active;

//     } else {
//       setState(() {
//         active = active;
//       });
// return active;
//     }
//   }

  Future<bool> PostDislike(int index, int eventId) async {
    print("inside postlike");
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    FormData formData = new FormData.fromMap({
      "event_id": eventId,
    });
    // try {
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    await _dio.post(UnFavourite, data: formData).then((value) {
      print(value.data.toString());
      if (value.data['success'] == true) {
        print(value.data.toString());
        setState(() {
          active = false;
        });
      }
    });
    return Future.value(active);
    //     } else {
    //       print("error while getting favouites");
    //     }
    //   });
    // } catch (e) {
    //   print(e.toString());
    // } finally {
    //   return Future.value(false);
    // }
  }

  Future<bool> PostLike(int index, int eventId) async {
    print("inside postlike");
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    FormData formData = new FormData.fromMap({
      "event_id": eventId,
    });
    // try {
    _dio.options.headers["Authorization"] = "Bearer ${_token}";

    await _dio.post(Favourite, data: formData).then((value) {
      print(value.toString());
      if (value.data['status'] == true) {
        print(value.data.toString());
        setState(() {
          active = true;
        });
      }
    });
    return Future.value(active);
    //     } else {

    //       print("error while getting favouites");

    //     }
    //   });
    // } catch (e) {
    //   print(e.toString());
    // } finally {
    //   return Future.value(false);
    // }
  }

  followingcheck(int index) {
    print("inside followingcheck");

    if (_eventsModel.data[index].events.user.id.toString() != id) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Eventposterprofile(
                    id: _eventsModel.data[index].events.user.id,
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

  Future<String> postThumbs(int id) async {
    String count = "0";
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    FormData formData = FormData.fromMap({
      "event_id": id,
    });
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    Response response = await _dio.post(PostlikeUrl, data: formData);
    if (response.data['success']) {
      count = response.data['totalLikes'].toString();
      print('Hasdf');
    } else {
      print('ERROR');
    }
    return count;
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
                height: size.height * 0.25,
                width: double.infinity,
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
