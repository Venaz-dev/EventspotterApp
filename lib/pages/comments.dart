import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:event_spotter/widgets/topmenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';

class comment extends StatefulWidget {
  String? eventPicture;
  String? userName;
  String? userProfile;
  String? date;
  String? distance;
  String? eventName;
  String? likeTotal;
  String? commentTotal;
  String? totalLive;
  String? eventId;
  List commentList = [];
  comment(
      {Key? key,
      required this.eventPicture,
      required this.userName,
      required this.userProfile,
      required this.distance,
      required this.eventName,
      required this.likeTotal,
      required this.totalLive,
      required this.eventId,
      required this.commentList,
      required this.commentTotal,
      required this.date})
      : super(key: key);

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
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
        child: GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);

        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(
                // right: size.width * 0.03,
                // left: size.width * 0.03,
                top: 20,
                bottom: 0),
            child:
                // SingleChildScrollView(
                //   scrollDirection: Axis.vertical,
                //   child:
                Column(
              children: [
                // Textform(
                //   controller: _search,
                //   icon: Icons.search,
                //   label: "Search",
                //   color: const Color(0XFFECF2F3),
                // ),
                const SizedBox(
                  height: 20,
                ),

                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    // padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              widget.commentList.isEmpty
                                  ? "Comment"
                                  : "Comments" +
                                      " " +
                                      "(" +
                                      widget.commentList.length.toString() +
                                      ")",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500),
                            )),
                        // widget.commentList.isNotEmpty
                        //     ?
                        //     Text(
                        //         widget.commentList.isEmpty
                        //             ? "Comment"
                        //             : "Comments" +
                        //                 " " +
                        //                 widget.commentList.length.toString(),
                        //         style: const TextStyle(
                        //             color: Colors.black,
                        //             fontSize: 19,
                        //             fontWeight: FontWeight.w500),
                        //       )
                        //     : const Text(
                        //         "No comments",
                        //         style: TextStyle(
                        //             color: Colors.black,
                        //             fontSize: 19,
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        const SizedBox(
                          height: 20,
                        ),
                        Commentbyperson(
                            // eventsModel: widget.eventsModel,
                            // index: widget.index,
                            size: size,
                            comments: widget.commentList,
                            eventId: widget.eventId!)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ),
          Topmenu(
            title: widget.eventName!,
          ),
        ]),
      ),
    ));
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
  List comments = [];
  String eventId;
  Size size;
  Commentbyperson({
    Key? key,
    // required this.eventsModel,
    // required this.index,
    required this.comments,
    required this.eventId,
    required this.size,
  }) : super(key: key);

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
  late String _picture;
  late String _name;
  List comments = [];

  // late Size size;

  String MainUrl = "https://theeventspotter.com/";

  @override
  void initState() {
    comments = widget.comments;
    // size = widget.size;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    final kbHeight = MediaQuery.of(context).viewInsets.bottom;
    // print(widget.eventsModel.data[widget.index].events.comment.length);
    return Container(
        // height: size.height * 0.50,
        constraints: BoxConstraints(
          minHeight: (size.height * 0.82) - kbHeight,
          maxHeight: (size.height * 0.82) - kbHeight,
        ),
        // color: Colors.red,
        child: Stack(children: [
          comments.isEmpty
              ? SizedBox(height: 20, width: size.width, child: const Text(""))
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  // physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Column(
                          children: List.generate(comments.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0, left: 20, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        MainUrl +
                                                            comments[index][
                                                                'profile_pic']),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        comments[index]['user_name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF101010),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      time(index),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 40.0,
                                          left: 0,
                                          top: 10,
                                          bottom: 5),
                                      child: Text(
                                        comments[index]['content'],
                                        style: const TextStyle(
                                            color: Color(0xFF101010),
                                            fontSize: 15),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                      const SizedBox(height: 80),
                      // const SizedBox(height: 80),
                      // const SizedBox(height: 80),
                      // const SizedBox(height: 500),
                    ],
                  )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: size.width,
                height: 80,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Flexible(
                          child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFD1D5DB)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          maxLines: null,
                          controller: _comment,
                          cursorColor: Colors.black54,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Write the comment"),
                        ),
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                          onTap: () async {
                            if (_comment.text.isEmpty) {
                              showToaster("please write the comment");
                            } else {
                              await PostComment(widget.eventId);
                              clearText();
                              FocusScopeNode currentfocus =
                                  FocusScope.of(context);

                              if (!currentfocus.hasPrimaryFocus) {
                                currentfocus.unfocus();
                              }
                              // Navigator.pop(context);
                            }
                          },
                          child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3BADB7),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ))),
                    ],
                  ),
                ),
              )),
        ]));
  }

  time(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          TimeAgo.displayTimeAgoFromTimestamp(comments[index]['createdAt']),
          style: const TextStyle(fontSize: 15, color: Colors.black45),
        ),
      ),
    );
  }

  PostComment(String id) async {
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
    try {
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
            'user_name': _name,
            'profile_pic': _picture,
            'content': _comment.text,
            'createdAt': text1
          };
          comments.add(js);
          setState(() {});
          print("////////////");
          // listcomments.add(text);
          //createdAt.add(text1);
        } else {
          showToaster("error");
          //text = " ";
        }
      });
    } catch (e) {
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
                child: CircularProgressIndicator(color: Color(0xFF3BADB7)),
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
