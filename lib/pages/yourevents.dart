import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/userDraftEvents.dart';
import 'package:event_spotter/models/userPastEvents.dart';
import 'package:event_spotter/models/userUpcomingEvent.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/profile/yourevents.dart';
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
        test
            ? Column(
                children:
                    List.generate(_getUserUpcomingEvents.data.length, (index) {
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
                            // Positioned(
                            //   right: 0,
                            //   top: 0,
                            //  // child: likebutton(),
                            // ),
                            _getUserUpcomingEvents.data[index].events
                                        .eventPictures[0].imagePath
                                        .toString()
                                        .contains('.mp4') ||
                                    _getUserUpcomingEvents.data[index].events
                                        .eventPictures[0].imagePath
                                        .toString()
                                        .contains('.mov')
                                ? VideoPlayerScreennn(
                                    url: MainUrl +
                                        _getUserUpcomingEvents.data[index]
                                            .events.eventPictures[0].imagePath)
                                : SizedBox(
                                    height: size.height * 0.17,
                                    width: size.width * 0.3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: MainUrl +
                                            _getUserUpcomingEvents
                                                .data[index]
                                                .events
                                                .eventPictures[0]
                                                .imagePath,
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
                              right: 20,
                              left: size.width * 0.33,
                              top: size.height * 0.02,
                              child: Text(
                                _getUserUpcomingEvents.data[0].events.eventName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              left: size.width * 0.33,
                              top: size.height * 0.05,
                              child: Text(
                                _getUserUpcomingEvents
                                    .data[0].events.eventDescription,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
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
                                  Text(
                                      _getUserUpcomingEvents
                                          .data[index].events.location,
                                      style: const TextStyle(
                                          color: Colors.black87),
                                      // ignore: deprecated_member_use
                                      overflow: TextOverflow.ellipsis),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    size: 15,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),

                            // Positioned(
                            //   top: size.height * 0.18,
                            //   child: Row(
                            //     children: const [
                            //       Icon(
                            //         LineAwesomeIcons.user_plus,
                            //         size: 20,
                            //         color: Colors.black54,
                            //       ),
                            //       SizedBox(
                            //         width: 5,
                            //       ),
                            //       Text(_getUserUpcomingEvents.data[index].events.f),
                            //     ],
                            //   ),
                            // ),

                            // Positioned(
                            //   bottom: 0,
                            //   child: Row(
                            //     children: [
                            //       IntrinsicHeight(
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceAround,
                            //           children: [
                            //             extras(FontAwesomeIcons.thumbsUp,
                            //                 _getUserUpcomingEvents.data[index], size),
                            //             divider(),
                            //             extras(
                            //                 Icons.comment, posts[1]['comment'], size),
                            //             divider(),
                            //             extras(
                            //                 MdiIcons.share, posts[1]['share'], size),
                            //             divider(),
                            //             extras(
                            //                 Icons.live_tv, posts[1]['viewers'], size),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            : const Center(
                child: Text("No Upcoming Events"),
              )
      ],
    ); ////
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
        test1
            ? Column(
                children: List.generate(_userPastEvents.data.length, (index) {
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
                            // Positioned(
                            //   right: 0,
                            //   top: 0,
                            //  // child: likebutton(),
                            // ),
                            _userPastEvents.data[index].events.eventPictures[0]
                                        .imagePath
                                        .toString()
                                        .contains('.mp4') ||
                                    _userPastEvents.data[index].events
                                        .eventPictures[0].imagePath
                                        .toString()
                                        .contains('.mov')
                                ? VideoPlayerScreennn(
                                    url: MainUrl +
                                        _userPastEvents.data[index].events
                                            .eventPictures[0].imagePath)
                                : SizedBox(
                                    height: size.height * 0.17,
                                    width: size.width * 0.3,
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
                            Positioned(
                              right: 20,
                              left: size.width * 0.33,
                              top: size.height * 0.02,
                              child: Text(
                                _userPastEvents.data[0].events.eventName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              left: size.width * 0.33,
                              top: size.height * 0.05,
                              child: Text(
                                _userPastEvents.data[0].events.eventDescription,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
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
                                  Text(
                                      _userPastEvents
                                          .data[index].events.location,
                                      style: const TextStyle(
                                          color: Colors.black87),
                                      // ignore: deprecated_member_use
                                      overflow: TextOverflow.ellipsis),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    size: 15,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),

                            // Positioned(
                            //   top: size.height * 0.18,
                            //   child: Row(
                            //     children: const [
                            //       Icon(
                            //         LineAwesomeIcons.user_plus,
                            //         size: 20,
                            //         color: Colors.black54,
                            //       ),
                            //       SizedBox(
                            //         width: 5,
                            //       ),
                            //       Text(_getUserUpcomingEvents.data[index].events.f),
                            //     ],
                            //   ),
                            // ),

                            // Positioned(
                            //   bottom: 0,
                            //   child: Row(
                            //     children: [
                            //       IntrinsicHeight(
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceAround,
                            //           children: [
                            //             extras(FontAwesomeIcons.thumbsUp,
                            //                 _getUserUpcomingEvents.data[index], size),
                            //             divider(),
                            //             extras(
                            //                 Icons.comment, posts[1]['comment'], size),
                            //             divider(),
                            //             extras(
                            //                 MdiIcons.share, posts[1]['share'], size),
                            //             divider(),
                            //             extras(
                            //                 Icons.live_tv, posts[1]['viewers'], size),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            : const Center(
                child: Text("No Upcoming Events"),
              )
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
        test2
            ? Column(
                children:
                    List.generate(_getUserDraftEvents.data.length, (index) {
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
                            // Positioned(
                            //   right: 0,
                            //   top: 0,
                            //  // child: likebutton(),
                            // ),
                            _getUserDraftEvents.data[index].events
                                        .eventPictures[0].imagePath
                                        .toString()
                                        .contains('.mp4') ||
                                    _getUserDraftEvents.data[index].events
                                        .eventPictures[0].imagePath
                                        .toString()
                                        .contains('.mov')
                                ? VideoPlayerScreennn(
                                    url: MainUrl +
                                        _getUserDraftEvents.data[index].events
                                            .eventPictures[0].imagePath)
                                : SizedBox(
                                    height: size.height * 0.17,
                                    width: size.width * 0.3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: MainUrl +
                                            _getUserDraftEvents
                                                .data[index]
                                                .events
                                                .eventPictures[0]
                                                .imagePath,
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
                              right: 20,
                              left: size.width * 0.33,
                              top: size.height * 0.02,
                              child: Text(
                                _getUserDraftEvents.data[0].events.eventName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              left: size.width * 0.33,
                              top: size.height * 0.05,
                              child: Text(
                                _getUserDraftEvents
                                    .data[0].events.eventDescription,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
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
                                  Text(
                                      _getUserDraftEvents
                                          .data[index].events.location,
                                      style: const TextStyle(
                                          color: Colors.black87),
                                      // ignore: deprecated_member_use
                                      overflow: TextOverflow.ellipsis),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    size: 15,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),

                            // Positioned(
                            //   top: size.height * 0.18,
                            //   child: Row(
                            //     children: const [
                            //       Icon(
                            //         LineAwesomeIcons.user_plus,
                            //         size: 20,
                            //         color: Colors.black54,
                            //       ),
                            //       SizedBox(
                            //         width: 5,
                            //       ),
                            //       Text(_getUserUpcomingEvents.data[index].events.f),
                            //     ],
                            //   ),
                            // ),

                            // Positioned(
                            //   bottom: 0,
                            //   child: Row(
                            //     children: [
                            //       IntrinsicHeight(
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceAround,
                            //           children: [
                            //             extras(FontAwesomeIcons.thumbsUp,
                            //                 _getUserUpcomingEvents.data[index], size),
                            //             divider(),
                            //             extras(
                            //                 Icons.comment, posts[1]['comment'], size),
                            //             divider(),
                            //             extras(
                            //                 MdiIcons.share, posts[1]['share'], size),
                            //             divider(),
                            //             extras(
                            //                 Icons.live_tv, posts[1]['viewers'], size),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            : const Center(
                child: Text("No Upcoming Events"),
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
