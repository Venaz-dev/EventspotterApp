import 'package:dio/dio.dart';
import 'package:event_spotter/constant/json/live_feed.dart';
import 'package:event_spotter/constant/json/post.dart';
import 'package:event_spotter/models/userDraftEvents.dart';
import 'package:event_spotter/models/userPastEvents.dart';
import 'package:event_spotter/models/userUpcomingEvent.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum yourevents { upcoming, past, draft }

class Yevents extends StatefulWidget {
  const Yevents({Key? key}) : super(key: key);

  @override
  State<Yevents> createState() => _YeventsState();
}

class _YeventsState extends State<Yevents> {
  final TextEditingController _search = TextEditingController();

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

  yourevents scroll = yourevents.upcoming;

  @override
  void dispose() {
    // TODO: implement dispose
    _search.dispose();
    super.dispose();
  }

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
  var profile_pic;
  var time;
  var away;
  var title;
  late String _token;
  var profile_pic1;
  var time1;
  var away1;
  var title1;
  var profile_pic2;
  var time2;
  var away2;
  var title2;
  bool test = false;

  @override
  void initState() {
    super.initState();

    getUpComingEvents();
    //getPastEvents();
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
          body: Padding(
            padding: EdgeInsets.only(top: 20.0, left: size.width * 0.05),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Row(
                        children: [
                          SizedBox(
                            //height: size.height*0.1,
                            width: size.width * 0.8,
                            child: Textform(
                              controller: _search,
                              icon: Icons.search,
                              label: "Search",
                              color: const Color(0XFFECF2F3),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Smallbutton(
                            icon: FontAwesomeIcons.slidersH,
                            onpressed: () {
                              setState(() {
                                // swap = screens.filter;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.05),
                      child: getwidgets(size),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  getUpComingEvents() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    print("Inside the Get upcomming function");
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(getUpComingEventUrl);
      if (response.statusCode == 200) {
        print("ssssss");
        if (response.data["data"].toString().isNotEmpty) {
          _getUserUpcomingEvents =
              GetUserUpcomingEvents.fromJson(response.data);
          setState(() {
            test = true;
          });
          print(test);
        } else {
          print(test);
          print("heeee");
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  getPastEvents() async {}

  Widget getwidgets(Size size) {
    switch (scroll) {
      case yourevents.upcoming:
        return upcoming(size);

      case yourevents.past:
        return past(size);

      case yourevents.draft:
        return draft(size);
    }
  }

  Widget upcoming(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Row(
            children: [
              Elevatedbuttons(
                sidecolor: Colors.transparent,
                text: "Upcoming",
                textColor: Colors.white,
                coloring: const Color(0XFF38888F),
                primary: const Color(0XFF38888F),
                onpressed: () {
                  setState(() {
                    scroll = yourevents.upcoming;
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Elevatedbuttons(
                sidecolor: Colors.black,
                text: "Past Events",
                textColor: Colors.black,
                coloring: Colors.white,
                primary: Colors.white,
                onpressed: () {
                  setState(() {
                    scroll = yourevents.past;
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Elevatedbuttons(
                sidecolor: Colors.black,
                text: "Drafts",
                textColor: Colors.black,
                coloring: Colors.white,
                primary: Colors.white,
                onpressed: () {
                  setState(() {
                    scroll = yourevents.draft;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: List.generate(feed.length, (index) {
            return Padding(
              padding: EdgeInsets.only(top: size.height * .01),
              child: Container(
                height: size.height * 0.3,
                width: size.width,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0.5,
                        blurRadius: 0.5,
                        // offset: Offset(2, 2)
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.02,
                      right: size.width * 0.02,
                      bottom: size.height * 0.02,
                      left: size.width * 0.02),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        child: likebutton(),
                      ),
                      // SizedBox(
                      //   height: size.height * 0.17,
                      //   width: size.width * 0.3,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(10),
                      //     child: CachedNetworkImage(
                      //       imageUrl: feed[index]['picture'],
                      //       fit: BoxFit.cover,
                      //       placeholder: (context, url) {
                      //         return const Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // Positioned(
                      //   right: 20,
                      //   left: size.width * 0.33,
                      //   top: size.height * 0.02,
                      //   child: Text(
                      //     _getUserUpcomingEvents.data[0].events.eventName,
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w400, fontSize: 17),
                      //   ),
                      // ),
                      Positioned(
                        top: size.height * 0.14,
                        left: size.width * 0.33,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              MdiIcons.calendarRange,
                              size: 15,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            // Text(
                            //   posts[1]['takingPlace'],
                            //   style: const TextStyle(color: Colors.black87),
                            // ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              size: 15,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(posts[1]['distance'] + " " + " " + "away",
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.18,
                        child: Row(
                          children: const [
                            Icon(
                              LineAwesomeIcons.user_plus,
                              size: 20,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('120 Followers'),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Row(
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  extras(FontAwesomeIcons.thumbsUp,
                                      posts[1]['likes'], size),
                                  divider(),
                                  extras(
                                      Icons.comment, posts[1]['comment'], size),
                                  divider(),
                                  extras(
                                      MdiIcons.share, posts[1]['share'], size),
                                  divider(),
                                  extras(
                                      Icons.live_tv, posts[1]['viewers'], size),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget past(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Row(
            children: [
              Elevatedbuttons(
                sidecolor: Colors.black,
                text: "Upcomingg",
                textColor: Colors.black,
                coloring: Colors.white,
                primary: Colors.white,
                onpressed: () {
                  setState(() {
                    scroll = yourevents.upcoming;
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Elevatedbuttons(
                sidecolor: Colors.transparent,
                text: "Past Events",
                textColor: Colors.white,
                coloring: const Color(0XFF38888F),
                primary: const Color(0XFF38888F),
                onpressed: () {
                  setState(() {
                    scroll = yourevents.past;
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Elevatedbuttons(
                sidecolor: Colors.black,
                text: "Drafts",
                textColor: Colors.black,
                coloring: Colors.white,
                primary: Colors.white,
                onpressed: () {
                  setState(() {
                    scroll = yourevents.draft;
                  });
                },
              ),
            ],
          ),
        ),
        const Center(
          child: Text("No past eventsss"),
        ),
      ],
    );
  }

  Widget draft(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Row(
            children: [
              Elevatedbuttons(
                sidecolor: Colors.black,
                text: "Upcoming",
                textColor: Colors.black,
                coloring: Colors.white,
                primary: Colors.white,
                onpressed: () {
                  setState(() {
                    scroll = yourevents.upcoming;
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Elevatedbuttons(
                sidecolor: Colors.black,
                text: "Past Events",
                textColor: Colors.black,
                coloring: Colors.white,
                primary: Colors.white,
                onpressed: () {
                  setState(() {
                    scroll = yourevents.past;
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Elevatedbuttons(
                sidecolor: Colors.transparent,
                text: "Drafts",
                textColor: Colors.white,
                coloring: const Color(0XFF38888F),
                primary: const Color(0XFF38888F),
                onpressed: () {
                  setState(() {
                    scroll = yourevents.draft;
                  });
                },
              ),
            ],
          ),
        ),
        const Center(
          child: Text("No Drafts"),
        )
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
}
