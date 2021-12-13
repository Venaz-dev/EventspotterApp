import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventdetail.dart';
import 'package:event_spotter/pages/comments.dart';
import 'package:event_spotter/pages/event_details_page.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:event_spotter/pages/uploadimage.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/explore/comment.dart';
import 'package:event_spotter/widgets/explore/events.dart';
import 'package:event_spotter/widgets/explore/livefeed.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_spotter/widgets/map.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Differenteventsdetails extends StatefulWidget {
  const Differenteventsdetails({
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
  _DifferenteventsdetailsState createState() => _DifferenteventsdetailsState();
}

class _DifferenteventsdetailsState extends State<Differenteventsdetails> {
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
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Smallbutton(
                    icon: FontAwesomeIcons.arrowLeft,
                    onpressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.03,
                  left: size.width * 0.03,
                  top: 10,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 3,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 8, top: 3, bottom: 3),
                                    child: Button(
                                      onpressed: () {},
                                      title: widget.eventname!,
                                      // widget.eventsModel.data[index].events
                                      //     .user.name, //new
                                      radiusofbutton: BorderRadius.circular(20),
                                      profileImage: MainUrl + profile_pic!,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 3, bottom: 3),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    widget.eventname!,
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
                              (widget.eventpicture.contains('.mp4') ||
                                      widget.eventpicture.contains('.mov'))
                                  ? VideoPlayerScreenn(
                                      url: MainUrl + widget.eventpicture)
                                  : SizedBox(
                                      //color: Colors.red,
                                      height: size.height * 0.3,
                                      width: size.width * double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: MainUrl + widget.eventpicture,
                                        //  getUpComingEventUrl + imagePath!.path
                                      ),
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 3.0, left: 3),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Buttonicon(
                                        radiusofbutton:
                                            BorderRadius.circular(20),
                                        icon: FontAwesomeIcons.userPlus,
                                        title: followersCount + " " "Followers",
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.calendar,
                                              size: 13,
                                              color: Colors.black54,
                                            ),
                                            Text(
                                              time(),
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.mapMarkerAlt,
                                              size: 15,
                                              color: Colors.black54,
                                            ),
                                            Text(
                                                widget.distance! + " " + "away",
                                                style: const TextStyle(
                                                    color: Colors.black87)),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                              const SizedBox(
                                height: 5,
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
                                      extras(
                                        FontAwesomeIcons.thumbsUp,
                                        totalLike.toString(),
                                        size,
                                        () {},
                                      ),

                                      divider(),
                                      extras(Icons.comment,
                                          comments.length.toString(), size, () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => comment(
                                                      eventPicture:
                                                          widget.eventpicture,
                                                      userName: name1,
                                                      userProfile: profile_pic,
                                                      date: widget.date,
                                                      distance: widget.distance,
                                                      eventName:
                                                          widget.eventname,
                                                      likeTotal:
                                                          totalLike.toString(),
                                                      commentTotal: comments
                                                          .length
                                                          .toString(),
                                                      totalLive: livefeeds
                                                          .length
                                                          .toString(),
                                                      eventId: widget.eventId,
                                                      commentList: comments,
                                                    )));
                                      }),
                                      divider(),

                                      // extras(MdiIcons.share,
                                      //     posts[1]['share'], size),
                                      // divider(),                           //no inculded
                                      extras(
                                          Icons.play_arrow_sharp,
                                          livefeeds.length.toString(),
                                          size, () {
                                        setState(() {
                                          issnaps = !issnaps;
                                        });
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        !issnaps
                            ? Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 0.5,
                                          blurRadius: 0.5,
                                          offset: Offset(
                                            0,
                                            0,
                                          ),
                                        ),
                                        BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 0.5,
                                          blurRadius: 0.5,
                                          offset: Offset(
                                            0,
                                            0,
                                          ),
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Details",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.details!,
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 0.5,
                                          blurRadius: 0.5,
                                          offset: Offset(
                                            0,
                                            0,
                                          ),
                                        ),
                                        BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 0.5,
                                          blurRadius: 0.5,
                                          offset: Offset(
                                            0,
                                            0,
                                          ),
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Ticket link",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          widget.ticketlink == null
                                              ? const Text("")
                                              : InkWell(
                                                  onTap: () {
                                                    urllauncher();
                                                  },
                                                  child: Text(
                                                    widget.ticketlink!,
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
                                    "Location",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
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
                                        lat: widget.lat!, long: widget.long),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.location!,
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Livefeed",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        livefeeds.isEmpty
                                            ? const Center(
                                                child: Text("No Live Feeds"))
                                            : SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
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
                                                          size.height * 0.23,
                                                      width: size.width * 0.3,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
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
                                                                          0.2,
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
                                              ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          "Snaps",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        livefeeds.length > 0
                                            ? Column(
                                                children: List.generate(
                                                    livefeeds.length, (index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 15.0),
                                                  child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black12,
                                                              spreadRadius: 1,
                                                              blurRadius: 1,
                                                            ),
                                                          ]),
                                                      child: Column(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 10.0,
                                                            left: 10,
                                                            right: 10,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                width: 40,
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                300.0),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              MainUrl + profile_pic!,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                              ),
                                                              const Spacer(),
                                                              Text(
                                                                name1,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const Spacer(),
                                                              time1(index),
                                                              // ignore: unrelated_type_equality_checks
                                                              // name ==
                                                              //         _id
                                                              //     ? IconButton(
                                                              //         onPressed: () async {
                                                              //           await showpopup(index);
                                                              //         },
                                                              //         icon: const Icon(Icons.delete,
                                                              //             size: 20,
                                                              //             color: Color(0XFF368890)),
                                                              //       )
                                                              //     : const SizedBox(),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        livefeeds[index]['img']
                                                                    //////////////////////////
                                                                    .toString()
                                                                    .contains(
                                                                        '.mp4') ||
                                                                livefeeds[index]
                                                                        ['img']
                                                                    //////////////////////////
                                                                    .toString()
                                                                    .contains(
                                                                        '.mov')
                                                            ? Snapsvideoplayer(
                                                                url: MainUrl +
                                                                    livefeeds[index]
                                                                            [
                                                                            'img']
                                                                        .toString())
                                                            : SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.6,
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: MainUrl +
                                                                      livefeeds[
                                                                              index]
                                                                          [
                                                                          "img"],
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0,
                                              right: 30,
                                              left: 30),
                                          child: Elevatedbutton(
                                              primary: const Color(0xFF304747),
                                              text: "Upload Picture/Video",
                                              width: double.infinity,
                                              coloring: const Color(0xFF304747),
                                              onpressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Uploadimage(
                                                              eventId:
                                                                  widget.eventId
                                                                      as int,
                                                            )));
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ]),
                ),
              ),
            ),
    );
  }

  Widget buildimage(int index) {
    return CachedNetworkImage(
      imageUrl: MainUrl + livefeeds[index]['img'],
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(),
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
    var outputFormat = DateFormat('MM/dd/yyyy');
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
    if (widget.ticketlink != null ||
        widget.ticketlink != "") {
      if (widget.ticketlink!
          .contains("https://")) {
        if (await canLaunch(
           widget.ticketlink!)) {
          await launch(widget.ticketlink!);
        } else {
          throw 'Could not launch $widget.ticketlink';
        }
      }else{
         if (await canLaunch(
           "https://"+widget.ticketlink!)) {
          await launch( "https://"+widget.ticketlink!);
        } else {
          throw 'Could not launch $widget.ticketlink!';
        }
      }
    }
  }
}
