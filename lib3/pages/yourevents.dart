import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/userDraftEvents.dart';
import 'package:event_spotter/models/userPastEvents.dart';
import 'package:event_spotter/models/userUpcomingEvent.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/pages/differenteventsdetaisl.dart';
import 'package:event_spotter/pages/draft.dart';
import 'package:event_spotter/widgets/profile/yourevents.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum yourevents { upcoming, past, draft }

class Yevents extends StatefulWidget {
  const Yevents({Key? key}) : super(key: key);

  @override
  State<Yevents> createState() => _YeventsState();
}

class _YeventsState extends State<Yevents> {
  final TextEditingController _search = TextEditingController();

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
          backgroundColor: Colors.white,
          // appBar: PreferredSize(
          //  child: getAppBar(), preferredSize: Size.fromHeight(100)),
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

  // Widget getAppBar() {
  //   return AppBar(
  //     // elevation:,
  //     backgroundColor: Colors.red,
  //     actions : [

  //     ]
  //   );
  // }

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
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Differenteventsdetails(
                                  eventpicture: _getUserUpcomingEvents
                                      .data[index]
                                      .events
                                      .eventPictures[0]
                                      .imagePath
                                      .toString(),
                                  eventname: _getUserUpcomingEvents
                                      .data[index].events.eventName,
                                  conditions: _getUserUpcomingEvents
                                      .data[index].events.conditions
                                      .toString(),
                                  details: _getUserUpcomingEvents
                                      .data[index].events.eventDescription,
                                  ticketlink: _getUserUpcomingEvents
                                      .data[index].events.ticketLink,
                                  distance:
                                      _getUserUpcomingEvents.data[index].km,
                                  date: _getUserUpcomingEvents
                                      .data[index].events.eventDate,
                                  lat: _getUserUpcomingEvents
                                      .data[index].events.lat,
                                  long: _getUserUpcomingEvents
                                      .data[index].events.lng,
                                  location: _getUserUpcomingEvents
                                      .data[index].events.location,
                                  eventId: _getUserUpcomingEvents
                                      .data[index].events.id
                                      .toString(),
                                  
                                )));
                      },
                      child: Container(
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
                              top: 20.0, left: 15, bottom: 15),
                          child: Row(
                            children: [
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
                                          _getUserUpcomingEvents
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
                                              _getUserUpcomingEvents
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
                                        _getUserUpcomingEvents
                                            .data[index].events.eventName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                        maxFontSize: 16,
                                        minFontSize: 15,
                                        overflow: TextOverflow.fade,
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
                                        AutoSizeText(
                                          _getUserUpcomingEvents
                                              .data[index].events.eventDate,
                                          style: const TextStyle(
                                              color: Colors.black87),
                                          //overflow: TextOverflow.ellipsis,
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
                                            _getUserUpcomingEvents
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
                      ),
                    ),
                  );
                }),
              )
            : const Center(child: Text("No upcoming events")),
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
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Differenteventsdetails(
                                  eventpicture: _userPastEvents.data[index]
                                      .events.eventPictures[0].imagePath
                                      .toString(),
                                  eventname: _userPastEvents
                                      .data[index].events.eventName,
                                  conditions: _userPastEvents
                                      .data[index].events.conditions
                                      .toString(),
                                  details: _userPastEvents
                                      .data[index].events.eventDescription,
                                  ticketlink: _userPastEvents
                                      .data[index].events.ticketLink,
                                  distance: _userPastEvents.data[index].km,
                                  date: _userPastEvents
                                      .data[index].events.eventDate,
                                  eventId: _userPastEvents.data[index].events.id
                                      .toString(),
                                  lat: _userPastEvents.data[index].events.lat,
                                  long: _userPastEvents.data[index].events.lng,
                                  location: _userPastEvents
                                      .data[index].events.location,
                                )));
                      },
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
                              _userPastEvents.data[index].events
                                          .eventPictures[0].imagePath
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
                                        _userPastEvents
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
                                          _userPastEvents
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
                                            _userPastEvents.data[index].km +
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
                      ),
                    ),
                  );
                }),
              )
            : const Center(
                child: Text("No Past Events"),
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
                    child: InkWell(
                      onTap: () {
                        print("object");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Draftsedit(
                                  eventname:
                                      _getUserDraftEvents.data[index].eventName,
                                  date:
                                      _getUserDraftEvents.data[index].eventDate,
                                  placename:
                                      _getUserDraftEvents.data[index].location,
                                  imagepath: _getUserDraftEvents
                                      .data[index].eventPictures[0].imagePath,
                                  videopath: _getUserDraftEvents
                                      .data[index].eventPictures[0].imagePath,
                                  eventdescription: _getUserDraftEvents
                                      .data[index].eventDescription,
                                  conditions: _getUserDraftEvents
                                      .data[index].conditions,
                                  eventprivaacy:
                                      _getUserDraftEvents.data[index].isPublic,
                                  lat: _getUserDraftEvents.data[index].lat,
                                  log: _getUserDraftEvents.data[index].lng,
                                  type:
                                      _getUserDraftEvents.data[index].eventType,
                                  ticketlink: _getUserDraftEvents
                                      .data[index].ticketLink,
                                )));
                      },
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
                              _getUserDraftEvents.data[index].eventPictures[0]
                                          .imagePath
                                          .toString()
                                          .contains('.mp4') ||
                                      _getUserDraftEvents.data[index]
                                          .eventPictures[0].imagePath
                                          .toString()
                                          .contains('.mov')
                                  ? VideoPlayerScreennn(
                                      url: MainUrl +
                                          _getUserDraftEvents.data[index]
                                              .eventPictures[0].imagePath)
                                  : SizedBox(
                                      height: size.height * 0.17,
                                      width: size.width * 0.3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: MainUrl +
                                              _getUserDraftEvents.data[index]
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
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.35,
                                      child: AutoSizeText(
                                        _getUserDraftEvents
                                            .data[index].eventName,
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
                                          _getUserDraftEvents
                                              .data[index].eventDate,
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
                                        SizedBox(
                                          width: size.width * 0.35,
                                          child: AutoSizeText(
                                            _getUserDraftEvents
                                                    .data[index].location +
                                                " " +
                                                " " +
                                                "away",
                                            style: const TextStyle(
                                                color: Colors.black87),
                                            maxFontSize: 17,
                                            minFontSize: 14,
                                          ),
                                        ),
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
              )
            : const Center(
                child: Text("No Draft Events"),
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
