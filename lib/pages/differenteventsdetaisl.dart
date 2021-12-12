import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/widgets/explore/events.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_spotter/widgets/map.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  _DifferenteventsdetailsState createState() => _DifferenteventsdetailsState();
}

class _DifferenteventsdetailsState extends State<Differenteventsdetails> {
  File? imagePath;
  String getUpComingEventUrl =
      "https://theeventspotter.com/api/getUserUpcomingEvents";
  String MainUrl = "https://theeventspotter.com/";
  late var totalLike;
  final Dio _dio = Dio();
  late SharedPreferences _sharedPreferences;
  late String _token;
  late var totalComments;
  List liveFeeds = [];
  bool _isLoading = true;
  late String profile_pic;
  String getEventDetailUrl = "https://theeventspotter.com/api/eventsdetails/";

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
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8,
                                          top: 3,
                                          bottom: 3),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: size.width * 0.4,
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
                                                    FontAwesomeIcons
                                                        .mapMarkerAlt,
                                                    size: 15,
                                                    color: Colors.black54,
                                                  ),
                                                  Text(
                                                      widget.distance! +
                                                          " " +
                                                          "away",
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black87)),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      color: Colors.black54, fontSize: 16),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    : Text(
                                        widget.ticketlink!,
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
                          child: Map(lat: widget.lat!, long: widget.long),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.location!,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                      ]),
                ),
              ),
            ),
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

    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    try {
      await _dio.get(getEventDetailUrl + widget.eventId!).then((value) {
        if (value.statusCode == 200) {
          totalLike = value.data["data"]["like"].length;
          totalComments = value.data["data"]["comment"].length;
          if (value.data["data"]["user"]["profile_picture"] != null) {
            profile_pic =
                value.data["data"]["user"]["profile_picture"]['image'];
          } else {
            profile_pic = "images/user.jpeg";
          }
          if (value.data["data"]['livefeed'].length > 0) {
            for (int i = 0; i < value.data["data"]['livefeed'].length; i++) {
              var js = {
                'img': value.data["data"]["livefeed"][i]["path"],
              };
              liveFeeds.add(js);
            }
          }
        }
      });
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
    }
  }
}
