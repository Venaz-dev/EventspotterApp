import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/uploadimage.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/explore/comment.dart';
import 'package:event_spotter/widgets/explore/events.dart';
import 'package:event_spotter/widgets/explore/livefeed.dart';
import 'package:event_spotter/widgets/map.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum livefeed { details, livesnaps }

class Eventdetailing extends StatefulWidget {
  EventsModel? model;
  final int? indexs;
  String id;
  Eventdetailing({
    Key? key,
    //  this.networkImage, this.isfollow, this.uploaderName, this.uploaderimage, this.followers, this.takingplace, this.distance, required this.description, this.like, this.comment, this.share, this.views
    @required this.model,
    required this.id,
    this.indexs,
  }) : super(key: key);

  @override
  State<Eventdetailing> createState() => _EventdetailingState();
}

class _EventdetailingState extends State<Eventdetailing> {
  livefeed swapping = livefeed.details;
  late List Live = [];
  bool test1 = false;
  final Dio _dio = Dio();
  bool _isLoading = false;
  late SharedPreferences _sharedPreferences;
  late String _token;

  String MainUrl = "https://theeventspotter.com/";

  @override
  void initState() {
    super.initState();
    livefeedList();
  }

  String MainUrl1 = "https://theeventspotter.com/";
  String deleteEventUrl = "https://theeventspotter.com/api/delete-event";
  String deletesnapUrl = "https://theeventspotter.com/api/deleteSnap";

  @override
  Widget build(BuildContext context) {
    print(widget.model!.data[0].events.eventName.toString());
    bool active = false;

    String description = widget.model!.data[widget.indexs!].events.eventName;
    TextEditingController _search = TextEditingController();
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
        body: Padding(
          padding:
              const EdgeInsets.only(right: 30.0, left: 30, top: 20, bottom: 30),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Smallbutton(
                    icon: FontAwesomeIcons.arrowLeft,
                    onpressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: size.width * 0.7),
                    child: Textform(
                      controller: _search,
                      icon: Icons.search,
                      label: "Search",
                      color: const Color(0XFFECF2F3),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: size.width * double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(children: [
                  Container(
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: size.width * double.infinity,
                    child: Stack(children: [
                      widget.model!.data[widget.indexs!].events.eventPictures[0]
                                  .imagePath
                                  .toString()
                                  .contains('.mp4') ||
                              widget.model!.data[widget.indexs!].events
                                  .eventPictures[0].imagePath
                                  .toString()
                                  .contains('.mov')
                          ? VideoPlayerScreem(
                              url: MainUrl1 +
                                  widget.model!.data[widget.indexs!].events
                                      .eventPictures[0].imagePath)
                          : Container(
                              height: size.height * 0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: MainUrl1 +
                                      widget.model!.data[widget.indexs!].events
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
                      Positioned(
                        right: 10,
                        top: size.height * 0.02,
                        child: SizedBox(
                          height: size.height * 0.04,

                          // decoration: const BoxDecoration(color: Color(0XFF38888E)),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0XFF38888E),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    FontAwesomeIcons.userPlus,
                                    size: 10,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Follow"),
                                ],
                              )),
                        ),
                      ),
                      // Positioned(
                      //   top: size.height * 0.07,
                      //   right: size.width * 0.02,
                      //   child: Column(children: [
                      //     LikeButton(
                      //         size: 20,
                      //         isLiked: active,
                      //         likeBuilder: (isliked) {
                      //           final color =
                      //               isliked ? Colors.red : Colors.grey;
                      //           return Icon(Icons.favorite,
                      //               color: color, size: 20);
                      //         },
                      //         countBuilder: (count, isliked, text) {
                      //           final color =
                      //               isliked ? Colors.red : Colors.grey;
                      //         }),
                      //     const SizedBox(
                      //       height: 10,
                      //     ),
                      //     // LikeButton(
                      //     //     size: 20,
                      //     //     isLiked: active,
                      //     //     likeBuilder: (isliked) {
                      //     //       final color =
                      //     //           isliked ? Colors.green : Colors.grey;
                      //     //       return Icon(Icons.flag, color: color, size: 20);
                      //     //     },
                      //     //     countBuilder: (count, isliked, text) {
                      //     //       final color =
                      //     //           isliked ? Colors.green : Colors.grey;
                      //     //     }),
                      //   ]),
                      // ),
                      Positioned(
                        bottom: 0,
                        right: size.width * 0.02,
                        left: size.width * 0.02,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Button(
                                onpressed: () {},
                                title: widget.model!.data[widget.indexs!].events
                                    .user.name,
                                radiusofbutton: BorderRadius.circular(20),
                                profileImage: MainUrl1 +
                                    widget.model!.data[widget.indexs!].events
                                        .user.profilePicture!.image),
                            const SizedBox(
                              width: 10,
                            ),
                            Buttonicon(
                              radiusofbutton: BorderRadius.circular(20),
                              icon: FontAwesomeIcons.userPlus,
                              title: widget
                                      .model!.data[widget.indexs!].Following
                                      .toString() +
                                  " " "Followers",
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              FontAwesomeIcons.calendar,
                              size: 15,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              widget
                                  .model!.data[widget.indexs!].events.eventDate,
                              style: const TextStyle(color: Colors.black87),
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
                                widget.model!.data[widget.indexs!].km +
                                    " " +
                                    "away",
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, right: 20),
                            child: AutoSizeText(
                              description,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              maxFontSize: 17,
                              minFontSize: 15,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              extras(
                                FontAwesomeIcons.thumbsUp,
                                widget.model!.data[widget.indexs!].isLiked
                                    .toString(),
                                size,
                                () {},
                              ),
                              divider(),
                              extras(
                                Icons.comment,
                                widget.model!.data[widget.indexs!].events
                                    .comment.length
                                    .toString(),
                                size,
                                () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Commentofuser(
                                            eventsModel: widget.model!,
                                            index: widget.indexs!,
                                          )));
                                },
                              ),
                              // divider(),
                              // extras(MdiIcons.share, posts[1]['share'],
                              //     size),
                              divider(),
                              extras(
                                Icons.live_tv,
                                widget.model!.data[widget.indexs!].events
                                    .liveFeed.length
                                    .toString(),
                                size,
                                () {
                                  setState(() {
                                    swapping = livefeed.livesnaps;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white10,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(
                        4,
                        8,
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              calloflivesnaps(size),
            ],
          ),
        ),
      ),
    ));
  }

  Widget calloflivesnaps(Size size) {
    switch (swapping) {
      case livefeed.details:
        return personaldetails(size);

      case livefeed.livesnaps:
        return livesnaps(size);
    }
  }

  Widget personaldetails(Size size) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Details",
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.model!.data[widget.indexs!].events.eventDescription,
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Conditions",
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Wrap(
              children: List.generate(
                  widget.model!.data[widget.indexs!].events.conditions.length,
                  (index) {
            return widget
                        .model!.data[widget.indexs!].events.conditions[index] !=
                    ''
                ? Padding(
                    padding: const EdgeInsets.only(right: 6.0, top: 10),
                    child: Elevatedbuttons(
                      sidecolor: Colors.black,
                      coloring: Colors.white,
                      text: widget
                          .model!.data[widget.indexs!].events.conditions[index]
                          .toString(),
                      textColor: Colors.black,
                      primary: Colors.white,
                      onpressed: () {},
                    ),
                  )
                : const SizedBox();
          })),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Location",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Container(
            height: size.height * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(
                    2,
                    2,
                  ),
                )
              ],
            ),
            child: Map(
              lat: widget.model!.data[widget.indexs!].events.lat.toString(),
              long: widget.model!.data[widget.indexs!].events.lng.toString(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.model!.data[widget.indexs!].events.location.toString(),
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : widget.model!.data[widget.indexs!].events.userId == widget.id
                  ? Elevatedbutton(
                      text: "Delete",
                      width: double.infinity,
                      coloring: Colors.redAccent,
                      textColor: const Color(0XFFFFFFFF),
                      onpressed: () async {
                        _isLoading = true;
                        setState(() {});

                        await deleteevent();
                        Navigator.pop(context);
                      },
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }

  deleteevent() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer $_token";
    try {
      await _dio
          .get(deleteEventUrl +
              "/" +
              widget.model!.data[widget.indexs!].events.id.toString())
          .then((value) {
        print(value.data);
        if (value.statusCode == 200) {
          showToaster("Event Deleted");
        } else {
          print("error");
        }
      });
    } catch (e) {
      print(e.toString());
      _isLoading = false;
      setState(() {});
    }
  }

  Widget livesnaps(Size size) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Livefeed",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            Live.isEmpty
                ? const Center(child: Text("No Live Feeds"))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(Live.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: Container(
                          height: size.height * 0.23,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            //  color: Colors.red,
                          ),
                          child: Stack(
                            children: [
                              Live[index]
                                          //////////////////////////
                                          .toString()
                                          .contains('.mp4') ||
                                      Live[index]
                                          //////////////////////////
                                          .toString()
                                          .contains('.mov')
                                  ? VideoPlayerScreen(
                                      url: MainUrl + Live[index])
                                  : Container(
                                      height: size.height * 0.2,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: buildimage(index)),
                                    ),
                              widget.model!.data[widget.indexs!].events
                                          .userId ==
                                      widget.id
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () async {
                                          await showpopup(index);
                                          //setState(() {});
                                        },
                                        icon: const Icon(Icons.delete,
                                            size: 20, color: Color(0XFF368890)),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        widget.model!.data[widget.indexs!].km +
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Elevatedbutton(
                  primary: const Color(0xFF304747),
                  text: "Upload Picture/Video",
                  width: double.infinity,
                  coloring: const Color(0xFF304747),
                  onpressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Uploadimage(
                              eventId:
                                  widget.model!.data[widget.indexs!].events.id,
                            )));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  flaggedOrLiked(Size size, IconData icon) {
    return Container(
      height: size.height * 0.03,
      width: size.width * 0.07,
      decoration: const BoxDecoration(color: Colors.white),
      child: Icon(
        icon,
        size: 15,
      ),
    );
  }

  extras(IconData icon, String totalcount, Size size, VoidCallback press) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: 16,
          ),
          onPressed: press,
        ),
        Text(totalcount),
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

  livefeedList() {
    if (widget.model!.data[widget.indexs!].events.liveFeed.length > 0) {
      for (int i = 0;
          widget.model!.data[widget.indexs!].events.liveFeed.length > i;
          i++) {
        var js = {
          'img': widget.model!.data[widget.indexs!].events.liveFeed[i].path,
          'id': widget.model!.data[widget.indexs!].events.liveFeed[i].id,
        };
        Live.add(js);
      }
      test1 = true;
    } else {
      test1 = false;
    }
  }

  Widget buildimage(int index) {
    return CachedNetworkImage(
      imageUrl: MainUrl + Live[index]['img'],
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  showpopup(int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete the snap"),
          content: const Text("Press confirm to delete snap"),
          actions: [
            MaterialButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: const Text("Confirm"),
              onPressed: ()async {
               await deleteSnap(index);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  deleteSnap(int index) async {
    print("inside delete snap");
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer $_token";
    FormData formData = FormData.fromMap({
      "id": Live[index]["id"],
    });
    try {
      await _dio.post(deletesnapUrl, data: formData).then((value) {
        print(value.data);
        if (value.statusCode == 200) {
          Live.removeAt(index);
          // print(Live[index]);
          showToaster("Event Snap deleted");
        } else {
          print("error");
        }
      });
    } catch (e) {
      print(e.toString());
      _isLoading = false;
      setState(() {});
    }
  }
}

class VideoPlayerScreem extends StatefulWidget {
  VideoPlayerScreem({Key? key, required this.url}) : super(key: key);
  late String url;

  @override
  _VideoPlayerScreemState createState() => _VideoPlayerScreemState();
}

class _VideoPlayerScreemState extends State<VideoPlayerScreem> {
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
              _controller.play();

              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return Container(
                height: size.height * 0.25,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(_controller),
                    ControlsOverlay(controller: _controller),
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
