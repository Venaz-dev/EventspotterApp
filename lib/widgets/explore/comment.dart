import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:event_spotter/pages/userprofile.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Commentofuser extends StatefulWidget {
  EventsModel eventsModel;
  int index;
  Commentofuser({Key? key, required this.eventsModel, required this.index})
      : super(key: key);

  @override
  State<Commentofuser> createState() => _CommentofuserState();
}

class _CommentofuserState extends State<Commentofuser> {
  String MainUrl = "https://theeventspotter.com/";
  bool active = false;
  EventsModel? model;
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String description =
    //     widget.model!.data[widget.indexs!].events.eventDescription;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(right: 30.0, left: 30, top: 20, bottom: 30),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Textform(
                  controller: _search,
                  icon: Icons.search,
                  label: "Search",
                  color: const Color(0XFFECF2F3),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: size.height * 0.38,
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
                        widget.eventsModel.data[widget.index].events
                                    .eventPictures[0].imagePath
                                    .toString()
                                    .contains('.mp4') ||
                                widget.eventsModel.data[widget.index].events
                                    .eventPictures[0].imagePath
                                    .toString()
                                    .contains('.mov')
                            ? VideoPlayerScreennnn(
                                url: MainUrl +
                                    widget.eventsModel.data[widget.index].events
                                        .eventPictures[0].imagePath)
                            : Container(
                                height: size.height * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: MainUrl +
                                        widget.eventsModel.data[widget.index]
                                            .events.eventPictures[0].imagePath,
                                    // imageUrl: mainurl +
                                    //     widget.model!.data[widget.indexs!].events
                                    //         .eventPictures[0].imagePath,
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
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Eventposterprofile(
                                          id: widget
                                              .eventsModel
                                              .data[widget.index]
                                              .events
                                              .user
                                              .id)));
                                },
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
                        Positioned(
                          bottom: 0,
                          right: size.width * 0.02,
                          left: size.width * 0.02,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Button(
                                title: widget.eventsModel.data[widget.index]
                                    .events.user.name,
                                // widget.model!.data[widget.indexs!].events
                                //     .user.name,
                                radiusofbutton: BorderRadius.circular(20),
                                profileImage: MainUrl +
                                    widget.eventsModel.data[widget.index].events
                                        .user.profilePicture!.image!,
                                //mainurl +
                                // widget.
                                // model!.data[widget.indexs!].events
                                //     .user.profilePicture!.image!
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              // Buttonicon(
                              //     radiusofbutton: BorderRadius.circular(20),
                              //     icon: FontAwesomeIcons.userPlus,
                              //     title: "sfssf"
                              //     // widget
                              //     //         .model!.data[widget.indexs!].Following
                              //     //         .toString() +
                              //     //     " " "Followers",
                              //     ),
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
                            right: size.width * 0.05,
                            child: Row(
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
                                  widget.eventsModel.data[widget.index].events
                                      .eventDate,
                                  // widget.model!.data[widget.indexs!].events
                                  //     .eventDate,
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
                                    widget.eventsModel.data[widget.index].km +
                                        " " +
                                        "away",
                                    style: TextStyle(color: Colors.black87)),
                              ],
                            ),
                          ),
                          Positioned(
                              top: size.height * 0.04,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  widget.eventsModel.data[widget.index].events
                                      .eventName,
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
                                  extras(
                                      FontAwesomeIcons.thumbsUp,
                                      widget.eventsModel.data[widget.index]
                                          .isLiked
                                          .toString(),
                                      // widget
                                      //     .model!.data[widget.indexs!].isLiked
                                      //     .toString(),
                                      size),
                                  divider(),
                                  SizedBox(
                                    height: size.height * 0.04,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      onPressed: () {},
                                      child: extras(
                                          Icons.comment,
                                          widget.eventsModel.data[widget.index]
                                              .events.comment.length
                                              .toString(),
                                          // widget.model!.data[widget.indexs!]
                                          //     .events.comment.length
                                          //     .toString(),
                                          size),
                                    ),
                                  ),
                                  // divider(),
                                  // extras(MdiIcons.share, posts[1]['share'],
                                  //     size),
                                  divider(),
                                  extras(
                                      Icons.live_tv,
                                      "0",
                                      // widget.model!.data[widget.indexs!]
                                      //     .events.liveFeed.length
                                      //     .toString(),
                                      size),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      //background color of box
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 2.0,
                          offset: Offset(
                            0,
                            0,
                          ))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.eventsModel.data[widget.index].events.comment
                                .isNotEmpty
                            ? Text(
                                widget.eventsModel.data[widget.index].events
                                        .comment.isEmpty
                                    ? "Comment"
                                    : "Comments" +
                                        " " +
                                        widget.eventsModel.data[widget.index]
                                            .events.comment.length
                                            .toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500),
                              )
                            : const Text(
                                "No comments",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Commentbyperson(
                            eventsModel: widget.eventsModel,
                            index: widget.index,
                            eventId:
                                widget.eventsModel.data[widget.index].events.id)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  extras(
    IconData icon,
    String totalcount,
    Size size,
  ) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              icon,
              size: 16,
            ),
            onPressed: () {}),
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
}

class Commentbyperson extends StatefulWidget {
  EventsModel eventsModel;
  int index;
  int eventId;
  Commentbyperson(
      {Key? key,
      required this.eventsModel,
      required this.index,
      required this.eventId})
      : super(key: key);

  @override
  State<Commentbyperson> createState() => _CommentbypersonState();
}

final Dio _dio = Dio();
late SharedPreferences _sharedPreferences;
late String _token;

class _CommentbypersonState extends State<Commentbyperson> {
  final TextEditingController _comment = TextEditingController();
  // late String text;
  String postCommenturl = "https://theeventspotter.com/api/storeComment";
  late List listcomments = [];
  late List createdAt = [];
  late List listprofilepic = [];
  late List username = [];
  late String _picture;
  late String _name;

  String MainUrl = "https://theeventspotter.com/";

  @override
  void initState() {
    super.initState();
    getcomments(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.eventsModel.data[widget.index].events.comment.length);
    return Column(
      children: [
        Column(
            children: List.generate(listcomments.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(MainUrl +
                                      listcomments[index]['img']),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          listcomments[index]['name'],
                              
                          style: TextStyle(fontSize: 18),
                        ),
                        const Spacer(),
                        time(index),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            right: 40.0, left: 40, top: 5, bottom: 5),
                        child: Text(listcomments[index]['comment']))
                  ],
                ),
              ),
            ),
          );
        })),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    maxLines: null,
                    controller: _comment,
                    cursorColor: Colors.black54,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write the comment"),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF3BACEC),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      if (_comment.text.isEmpty) {
                        showToaster("please write the comment");
                      } else {
                        await PostComment(widget.eventId);
                        clearText();
                       // Navigator.pop(context);
                      }
                    },
                    child: const Text('Comment')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  getcomments(int index) {
    if (widget.eventsModel.data[index].events.comment.length > 0) {
      for (int i = 0;
          i < widget.eventsModel.data[index].events.comment.length;
          i++) {
        {
          var js = {
            'img': widget.eventsModel.data[index].events.comment[i].user
                .profilePicture!.image,
            'name': widget.eventsModel.data[index].events.comment[i].user.name,
            'createdAt':
                widget.eventsModel.data[index].events.comment[i].createdAt,
            'comment': widget.eventsModel.data[index].events.comment[i].comment,
          };

          listcomments.add(js);
        }
      }
    }
  }

  time(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          TimeAgo.displayTimeAgoFromTimestamp(listcomments[index]['createdAt']),
          style: const TextStyle(fontSize: 15, color: Colors.black45),
        ),
      ),
    );
  }

  PostComment(int id) async {
    /////////////////////////
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _picture = _sharedPreferences.getString('profilePicture')!;
    _name = _sharedPreferences.getString('name')!;
    FormData formData = new FormData.fromMap({
      "event_id": id,
      "comment": _comment.text,
    });
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    try{
    await _dio.post(postCommenturl, data: formData).then((value) {
      print(value.data.toString());
      if (value.data['success'] == true) {
        print(value.data);
        showToaster("Comment Sent");

        var text = value.data["data"]["comment"];
        var text1 = value.data["data"]["created_at"];
        // print(text);
        // print(created);
        var js = {
          'name': _name,
          'img': _picture,
          'comment': _comment.text,
          'createdAt': text1
        };
        listcomments.add(js);
        setState(() {});
        print("////////////");
        // listcomments.add(text);
        createdAt.add(text1);
      } else {
        showToaster("error");
        //text = " ";
      }
    }
   
    );
     }catch(e){
      print(e.toString());
    }
    //  print(text);
  }

  void clearText() {
    _comment.clear();
  }
}

class VideoPlayerScreennnn extends StatefulWidget {
  VideoPlayerScreennnn({Key? key, required this.url}) : super(key: key);
  late String url;

  @override
  _VideoPlayerScreennnnState createState() => _VideoPlayerScreennnnState();
}

class _VideoPlayerScreennnnState extends State<VideoPlayerScreennnn> {
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
