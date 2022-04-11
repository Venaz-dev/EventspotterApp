import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventdetail.dart';
import 'package:event_spotter/pages/comments.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:event_spotter/pages/uploadimage.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/explore/events.dart';
import 'package:event_spotter/widgets/explore/livefeed.dart';
import 'package:event_spotter/pages/livesnaps.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:event_spotter/widgets/topmenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_spotter/widgets/map.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Differentlivesnaps extends StatefulWidget {
  const Differentlivesnaps({
    Key? key,
    required this.eventpicture,
    this.conditions,
    this.details,
    this.eventname,
    this.ticketlink,
    this.distance,
    this.date,
    required this.eventId,
    this.lat,
    this.long,
    this.userName,
    this.location,
  }) : super(key: key);

  final String eventpicture;
  final String? eventname;
  final String? distance;
  final String? details;
  final String? ticketlink;
  final String? conditions;
  final String? date;
  final String? lat;
  final String? eventId;
  final String? long;
  final String? location;
  final String? userName;

  @override
  _DifferentlivesnapsState createState() => _DifferentlivesnapsState();
}

class _DifferentlivesnapsState extends State<Differentlivesnaps> {
  bool issnaps = false;
  File? imagePath;
  String getUpComingEventUrl =
      'https://theeventspotter.com/api/getUserUpcomingEvents';
  String MainUrl = "https://theeventspotter.com/";
  late var totalLike;
  List livefeeds = [];
  // List<Map<String,Dynamic>> = []
  final Dio _dio = Dio();
  late SharedPreferences _sharedPreferences;
  late String _token;
  late var totalComments;

  late String _id;
  late String name1;
  bool _isLoading = true;
  late String followersCount;
  late Eventdetail _eventdetail;
  String? profile_pic;
  String getEventDetailUrl = "https://theeventspotter.com/api/eventsdetails/";
  List comments = [];
  late String name;
  late String userName;
  get index1 => null;
  @override
  void initState() {
    geteventDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   leading: Padding(
          //     padding: const EdgeInsets.only(left: 8.0, top: 8),
          //     child: Smallbutton(
          //       icon: FontAwesomeIcons.arrowLeft,
          //       onpressed: () {
          //         Navigator.of(context).pop();
          //       },
          //     ),
          //   ),
          // ),
          body: Stack(children: [
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF3BADB7)))
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 60,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20.0,
                                left: 2,
                                right: 2,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.black12,
                                  //     spreadRadius: 3,
                                  //     blurRadius: 3,
                                  //     offset: Offset(0, 0),
                                  //   ),
                                  // ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // const Text(
                                      //   "Livefeed",
                                      //   style: TextStyle(
                                      //       fontSize: 18,
                                      //       fontWeight: FontWeight.w400),
                                      // ),
                                      // const SizedBox(
                                      //   height: 20,
                                      // ),
                                      livefeeds.isEmpty
                                          ? const Center(
                                              child: Text("No Live Feeds"))
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(children: [
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Row(
                                                    children: List.generate(
                                                        livefeeds.length,
                                                        (index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 10.0,
                                                    ),
                                                    child: Container(
                                                      height:
                                                          size.height * 0.24,
                                                      width: size.width * 0.3,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        // boxShadow: const [
                                                        //   BoxShadow(
                                                        //     color:
                                                        //         Colors.black12,
                                                        //     spreadRadius: 1,
                                                        //     blurRadius: 1,
                                                        //   )
                                                        // ],
                                                        // borderRadius:
                                                        //     BorderRadius
                                                        //         .circular(15),
                                                        //  color: Colors.red,
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          livefeeds[index][
                                                                          'img']
                                                                      //////////////////////////
                                                                      .toString()
                                                                      .contains(
                                                                          '.mp4') ||
                                                                  livefeeds[index]
                                                                          [
                                                                          'img']
                                                                      //////////////////////////
                                                                      .toString()
                                                                      .contains(
                                                                          '.mov')
                                                              ? VideoPlayerScreen(
                                                                  url: MainUrl +
                                                                      livefeeds[index]
                                                                              [
                                                                              'img']
                                                                          .toString())
                                                              : Container(
                                                                  height:
                                                                      size.height *
                                                                          0.21,
                                                                  width:
                                                                      size.width *
                                                                          0.3,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    // color: Colors.red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  child: ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      child: buildimage(
                                                                          index)),
                                                                ),
                                                          Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: Text(
                                                                widget.distance! +
                                                                    " " +
                                                                    "miles",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        17),
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
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Uploadimage(
                                                                        eventId: int.parse(widget
                                                                            .eventId
                                                                            .toString()),
                                                                      )));
                                                    },
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 10.0,
                                                        ),
                                                        child: Container(
                                                          height: size.height *
                                                              0.22,
                                                          width:
                                                              size.width * 0.2,
                                                          decoration: const BoxDecoration(
                                                              // boxShadow: const [
                                                              //   BoxShadow(
                                                              //     color: Colors.black12,
                                                              //     spreadRadius: 1,
                                                              //     blurRadius: 1,
                                                              //   )
                                                              // ],
                                                              // borderRadius: BorderRadius.circular(15),
                                                              //  color: Colors.red,
                                                              ),
                                                          child: Center(
                                                              child: Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          30),
                                                                  height: 32,
                                                                  width: 32,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xFF3BADB7),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40),
                                                                  ),
                                                                  child:
                                                                      const Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                  ))),
                                                        ))),
                                              ])),
                                      const SizedBox(
                                        height: 40,
                                      ),

                                      // const Text(
                                      //   "Snaps",
                                      //   style: TextStyle(
                                      //       color: Colors.black, fontSize: 19),
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Recent Live Snaps",
                                                  style: TextStyle(
                                                      color: Color(0xFF333333),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                livefeeds.length > 0
                                                    ? Column(
                                                        children: List.generate(
                                                            livefeeds.length,
                                                            (index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 15.0),
                                                          child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                // boxShadow: [
                                                                //   BoxShadow(
                                                                //     color: Colors.black12,
                                                                //     spreadRadius: 1,
                                                                //     blurRadius: 1,
                                                                //   ),
                                                                // ]
                                                              ),
                                                              child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            10.0,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(300.0),
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: MainUrl + profile_pic!,
                                                                                  fit: BoxFit.cover,
                                                                                )),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                          Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  name1,
                                                                                  style: const TextStyle(color: Color(0xFF101010), fontSize: 15),
                                                                                ),
                                                                                // const Spacer(),
                                                                                time1(index),
                                                                              ]),
                                                                          Spacer(),
                                                                          // Delete snap
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 8,
                                                                    ),
                                                                    livefeeds[index]['img']
                                                                                //////////////////////////
                                                                                .toString()
                                                                                .contains('.mp4') ||
                                                                            livefeeds[index]['img']
                                                                                //////////////////////////
                                                                                .toString()
                                                                                .contains('.mov')
                                                                        ? Snapsvideoplayer(url: MainUrl + livefeeds[index]['img'].toString())
                                                                        : SizedBox(
                                                                            height:
                                                                                size.height * 0.55,
                                                                            width:
                                                                                double.infinity,
                                                                            child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: MainUrl + livefeeds[index]["img"],
                                                                                  fit: BoxFit.fill,
                                                                                )),
                                                                          ),
                                                                  ])),
                                                        );
                                                      }))
                                                    : const Center(
                                                        child: Text("No Snaps"),
                                                      ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                              ]))

                                      // livefeeds.length > 0
                                      //     ? Column(
                                      //         children: List.generate(
                                      //             livefeeds.length, (index) {
                                      //         return Padding(
                                      //           padding: const EdgeInsets.only(
                                      //               bottom: 15.0),
                                      //           child: Container(
                                      //               decoration:
                                      //                   const BoxDecoration(
                                      //                       color: Colors.white,
                                      //                       boxShadow: [
                                      //                     BoxShadow(
                                      //                       color:
                                      //                           Colors.black12,
                                      //                       spreadRadius: 1,
                                      //                       blurRadius: 1,
                                      //                     ),
                                      //                   ]),
                                      //               child: Column(children: [
                                      //                 Padding(
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                           .only(
                                      //                     top: 10.0,
                                      //                     left: 10,
                                      //                     right: 10,
                                      //                   ),
                                      //                   child: Row(
                                      //                     children: [
                                      //                       SizedBox(
                                      //                         height: 40,
                                      //                         width: 40,
                                      //                         child: ClipRRect(
                                      //                             borderRadius:
                                      //                                 BorderRadius
                                      //                                     .circular(
                                      //                                         300.0),
                                      //                             child:
                                      //                                 CachedNetworkImage(
                                      //                               imageUrl:
                                      //                                   MainUrl +
                                      //                                       profile_pic!,
                                      //                               fit: BoxFit
                                      //                                   .cover,
                                      //                             )),
                                      //                       ),
                                      //                       const SizedBox(
                                      //                           width: 10),
                                      //                       Text(
                                      //                         name1,
                                      //                         style: const TextStyle(
                                      //                             color: Colors
                                      //                                 .black),
                                      //                       ),
                                      //                       const Spacer(),
                                      //                       time1(index),
                                      //                       // ignore: unrelated_type_equality_checks
                                      //                       // name ==
                                      //                       //         _id
                                      //                       //     ? IconButton(
                                      //                       //         onPressed: () async {
                                      //                       //           await showpopup(index);
                                      //                       //         },
                                      //                       //         icon: const Icon(Icons.delete,
                                      //                       //             size: 20,
                                      //                       //             color: Color(0XFF368890)),
                                      //                       //       )
                                      //                       //     : const SizedBox(),
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //                 const SizedBox(
                                      //                   height: 5,
                                      //                 ),
                                      //                 livefeeds[index]['img']
                                      //                             //////////////////////////
                                      //                             .toString()
                                      //                             .contains(
                                      //                                 '.mp4') ||
                                      //                         livefeeds[index]
                                      //                                 ['img']
                                      //                             //////////////////////////
                                      //                             .toString()
                                      //                             .contains(
                                      //                                 '.mov')
                                      //                     ? Snapsvideoplayer(
                                      //                         url: MainUrl +
                                      //                             livefeeds[index]
                                      //                                     [
                                      //                                     'img']
                                      //                                 .toString())
                                      //                     : SizedBox(
                                      //                         height:
                                      //                             size.height *
                                      //                                 0.6,
                                      //                         width: double
                                      //                             .infinity,
                                      //                         child:
                                      //                             CachedNetworkImage(
                                      //                           imageUrl: MainUrl +
                                      //                               livefeeds[
                                      //                                       index]
                                      //                                   ["img"],
                                      //                           fit:
                                      //                               BoxFit.fill,
                                      //                         ),
                                      //                       ),
                                      //               ])),
                                      //         );
                                      //       }))
                                      //     : const Center(
                                      //         child: Text("No Snaps"),
                                      //       ),
                                      // const SizedBox(
                                      //   height: 15,
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       bottom: 10.0, right: 30, left: 30),
                                      //   child: Elevatedbutton(
                                      //       primary: const Color(0xFF304747),
                                      //       text: "Upload Picture/Video",
                                      //       width: double.infinity,
                                      //       coloring: const Color(0xFF304747),
                                      //       onpressed: () {
                                      //         Navigator.of(context).push(
                                      //             MaterialPageRoute(
                                      //                 builder: (context) =>
                                      //                     Uploadimage(
                                      //                       eventId: int.parse(
                                      //                           widget.eventId
                                      //                               .toString()),
                                      //                     )));
                                      //       }),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
            Topmenu(title: "Live snaps"),
            Positioned(
                bottom: size.height * 0.05,
                right: 20.0,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Uploadimage(
                                eventId: int.parse(widget.eventId.toString()),
                              )));
                    },
                    child: Container(
                      height: 40,
                      width: 123,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 0),
                            ),
                          ],
                          image: const DecorationImage(
                              image: AssetImage("Assets/icons/add-snap.png"),
                              fit: BoxFit.cover)),
                    )))
          ])),
    );
  }

  Widget buildimage(int index) {
    return CachedNetworkImage(
      imageUrl: MainUrl + livefeeds[index]['img'],
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF3BADB7)),
        );
      },
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

  extras(IconData icon, String totalcount, Size size, VoidCallback press) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: 20,
          ),
          onPressed: press,
        ),
        Text(totalcount),
      ],
    );
  }

  String time() {
    DateTime parseDate = DateFormat("yyyy-mm-dd").parse(widget.date!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('mm/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  geteventDetail() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _id = _sharedPreferences.getString('id').toString();
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    print(widget.eventId);
    try {
      Response response = await _dio.get(getEventDetailUrl + widget.eventId!);

      if (response.statusCode == 200) {
        // print(value.data["data"].toString());
        print(response.data["data"].toString());
        // _eventdetail = Eventdetail.fromJson(response);
        name = response.data["data"]["user_id"];
        name1 = response.data["data"]["user"]["name"];
        totalLike = response.data["data"]["like"].length;
        totalComments = response.data["data"]["comment"].length;
        if (response.data["data"]["user"]["profile_picture"] != null) {
          profile_pic =
              response.data["data"]["user"]["profile_picture"]['image'];
        } else {
          profile_pic = "images/user.jpeg";
        }
        if (response.data["data"]["user"]["followers"].length > 0) {
          followersCount =
              response.data["data"]["user"]["followers"].length.toString();
        } else {
          followersCount = "0";
        }
        if (response.data["data"]['livefeed'].length > 0) {
          for (int i = 0; i < response.data["data"]['livefeed'].length; i++) {
            print(response.data["data"]["livefeed"][i]["path"]);
            String vv = response.data["data"]["livefeed"][i]["path"];
            String ss = response.data["data"]["livefeed"][i]["user_id"];
            var ff = {
              'img': vv,
              'userId': ss,
            };
            livefeeds.add(ff);
          }
        }
        if (response.data["data"]["comment"].length > 0) {
          for (int i = 0; i < response.data["data"]["comment"].length; i++) {
            if (response.data["data"]["comment"][i]["user"]
                    ["profile_picture"] !=
                null) {
              String content = response.data["data"]["comment"][i]["comment"];
              String profile_pic = response.data["data"]["comment"][i]["user"]
                  ["profile_picture"]["image"];
              String name = response.data["data"]["comment"][i]["user"]["name"];
              String createdatt =
                  response.data["data"]["comment"][i]["created_at"];

              var js = {
                'content': content,
                'profile_pic': profile_pic,
                'user_name': name,
                'createdAt': createdatt,
              };
              comments.add(js);
            } else {
              String content = response.data["data"]["comment"][i]["comment"];
              String profile_pic = "images/user.jpeg";
              String name = response.data["data"]["comment"][i]["user"]["name"];
              String createdatt =
                  response.data["data"]["comment"][i]["created_at"];
              var js = {
                'content': content,
                'profile_pic': profile_pic,
                'user_name': name,
                'createdAt': createdatt,
              };
              comments.add(js);
            }
          }
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  time1(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          TimeAgo.displayTimeAgoFromTimestamp(widget.date!),
          style: const TextStyle(fontSize: 15, color: Colors.black45),
        ),
      ),
    );
  }

  void urllauncher() async {
    if (widget.ticketlink != null || widget.ticketlink != "") {
      if (widget.ticketlink!.contains("https://")) {
        if (await canLaunch(widget.ticketlink!)) {
          await launch(widget.ticketlink!);
        } else {
          throw 'Could not launch $widget.ticketlink';
        }
      } else {
        if (await canLaunch("https://" + widget.ticketlink!)) {
          await launch("https://" + widget.ticketlink!);
        } else {
          throw 'Could not launch $widget.ticketlink!';
        }
      }
    }
  }
}
