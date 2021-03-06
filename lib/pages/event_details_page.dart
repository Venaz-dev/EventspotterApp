import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:event_spotter/pages/uploadimage.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/explore/comment.dart';
import 'package:event_spotter/widgets/explore/events.dart';
import 'package:event_spotter/widgets/explore/livefeed.dart';
import 'package:event_spotter/pages/livesnaps.dart';
import 'package:event_spotter/widgets/map.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:event_spotter/widgets/topmenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

enum livefeed { details, livesnaps }

class Eventdetailing extends StatefulWidget {
  EventsModel? model;
  final int? indexs;
  String? eventId;
  String id;

  Eventdetailing({
    Key? key,
    //  this.networkImage, this.isfollow, this.uploaderName, this.uploaderimage, this.followers, this.takingplace, this.distance, required this.description, this.like, this.comment, this.share, this.views
    @required this.model,
    required this.id,
    this.eventId,
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
  late int index1;

  String MainUrl = "https://theeventspotter.com/";

  @override
  void initState() {
    super.initState();
    livefeedList();
  }

  String MainUrl1 = "https://theeventspotter.com/";
  String deleteEventUrl = "https://theeventspotter.com/api/delete-event";
  String deletesnapUrl = "https://theeventspotter.com/api/deleteSnap";
  bool active = false;
  // String description = widget.model!.data[widget.indexs!].events.eventName;

  //TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.model!.data[0].events.eventName.toString());

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
          body: Stack(children: [
            ListView(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Container(
                  decoration: const BoxDecoration(
                      //borderRadius: BorderRadius.circular(15),
                      ),
                  width: size.width * double.infinity,
                  child: widget.model!.data[index1].events.eventPictures[0]
                              .imagePath
                              .toString()
                              .contains('.mp4') ||
                          widget.model!.data[index1].events.eventPictures[0]
                              .imagePath
                              .toString()
                              .contains('.mov')
                      ? VideoPlayerScreenn(
                          url: MainUrl +
                              widget.model!.data[index1].events.eventPictures[0]
                                  .imagePath)
                      : Container(
                          decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(20)
                              ),
                          child: ClipRRect(
                            //  borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              width: double.infinity,
                              imageUrl: MainUrl +
                                  widget.model!.data[index1].events
                                      .eventPictures[0].imagePath,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                      color: Color(0xFF3BADB7)),
                                );
                              },
                            ),
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.black12),
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        extras(
                          FontAwesomeIcons.heart,
                          widget.model!.data[index1].totalLikes.toString(),
                          size,
                          () {},
                        ),

                        //
                        extras(
                            FontAwesomeIcons.commentDots,
                            widget.model!.data[index1].events.comment.length
                                .toString(),
                            size, () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Commentofuser(
                                    eventsModel: widget.model!,
                                    index: index1,
                                  )));
                        }),
                        // divider(),
                        // divider(),

                        extras(MdiIcons.share, "", size, () {
                          share(widget.model!.data[widget.indexs!].events.id
                              .toString());
                        }),
                        // divider(), //

                        // extras(MdiIcons.share,
                        //     posts[1]['share'], size),
                        // divider(),                           //no inculded
                        // extras(
                        //     Icons.play_arrow_sharp,
                        //     widget.model!.data[index1].events
                        //         .liveFeed.length
                        //         .toString(),
                        //     size, () {
                        //   setState(() {
                        //     swapping = livefeed.livesnaps;
                        //   });
                        // }),
                        extras(
                            FontAwesomeIcons.playCircle,
                            widget.model!.data[index1].events.liveFeed.length
                                    .toString() +
                                " " +
                                "Live snaps",
                            size, () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Livesnaps(
                                    model: widget.model,
                                    indexs: widget.indexs,
                                    id: widget.id,
                                  )));
                          //  Navigator.of(context).push(MaterialPageRoute(
                          // builder: (context) => Livesnaps(

                          //     )));
                          setState(() {
                            // swapping = livefeed.livesnaps;
                          });
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 15, right: 15),
                    width: size.width * double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: const Color(0xffE5E7EB), width: 2)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     spreadRadius: 3,
                    //     blurRadius: 3,
                    //     color: Colors.black12,
                    //   ),
                    // ],

                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 5, left: 2, top: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Button(
                                    size: 48,
                                    onpressed: () {},
                                    title: widget
                                        .model!.data[index1].events.user.name,
                                    // widget.eventsModel.data[index].events
                                    //     .user.name, //new
                                    radiusofbutton: BorderRadius.circular(50),
                                    profileImage: MainUrl +
                                        widget.model!.data[index1].events.user
                                            .profilePicture!.image),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.model!.data[index1].events.eventDescription,
                            style: const TextStyle(
                                color: Color(0xFF333333), fontSize: 16),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Event Details",
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                  width: 35.0,
                                  child: Image(
                                      image: AssetImage(
                                          "Assets/icons/details-distance.png"))),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(children: [
                                SizedBox(
                                  width: size.width * 0.7,
                                  child: Text(
                                    widget.model!.data[index1].km +
                                        " " +
                                        "miles away",
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Color(0xFF242424), fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.7,
                                  child: const Text(
                                    "Distance from your location",
                                    style: TextStyle(
                                        color: Color(0xFF707070), fontSize: 14),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                  width: 35.0,
                                  child: Image(
                                      image: AssetImage(
                                          "Assets/icons/details-date.png"))),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(children: [
                                SizedBox(
                                  width: size.width * 0.7,
                                  child: Text(
                                    time(index1),
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Color(0xFF242424), fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.7,
                                  child: const Text(
                                    "Event date",
                                    style: TextStyle(
                                        color: Color(0xFF707070), fontSize: 14),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                  width: 35.0,
                                  child: Image(
                                      image: AssetImage(
                                          "Assets/icons/details-link.png"))),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(children: [
                                SizedBox(
                                  width: size.width * 0.7,
                                  child: InkWell(
                                    onTap: () {
                                      urllaundher();
                                    },
                                    child: Text(
                                      widget.model!.data[index1].events
                                                  .ticketLink! !=
                                              ""
                                          ? widget.model!.data[index1].events
                                              .ticketLink!
                                          : "No ticket link",
                                      style: const TextStyle(
                                          color: Color(0xFF242424),
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.7,
                                  child: const Text(
                                    "Ticket link",
                                    style: TextStyle(
                                        color: Color(0xFF707070), fontSize: 14),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ]),
                  ),
                )),
                const SizedBox(
                  height: 30,
                ),

                // Event location container
                Padding(
                  padding: EdgeInsets.only(
                      right: size.width * 0.03,
                      left: size.width * 0.03,
                      top: 20),
                  child: calloflivesnaps(size),
                ),
              ],
            ),
            Topmenu(
              title: widget.model!.data[index1].events.eventName,
            )
          ])),
    ));
  }

  share(String ff) {
    Share.share(
        'check out my post https://theeventspotter.com/eventDetails/' + ff);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Padding(
          padding: const EdgeInsets.only(
            right: 2,
            left: 2,
          ),
          child: Container(
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
            width: size.width * double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xffE5E7EB), width: 2)),
            // boxShadow: [
            //   BoxShadow(
            //     spreadRadius: 3,
            //     blurRadius: 3,
            //     color: Colors.black12,
            //   ),
            // ],

            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Event Location",
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
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
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Map(
                      lat: widget.model!.data[index1].events.lat.toString(),
                      long: widget.model!.data[index1].events.lng.toString(),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.model!.data[index1].events.location.toString(),
                style: const TextStyle(color: Color(0xFF333333), fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        )),
        const SizedBox(
          height: 30,
        ),
        // Event Conditions container
        Container(
            child: Padding(
          padding: const EdgeInsets.only(
            right: 2,
            left: 2,
          ),
          child: Container(
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
            width: size.width * double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xffE5E7EB), width: 2)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Event conditions",
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      widget.model!.data[index1].events.conditions.length,
                      (index) {
                    return widget
                                .model!.data[index1].events.conditions[index] !=
                            ''
                        ? Padding(
                            padding:
                                const EdgeInsets.only(right: 6.0, bottom: 10),
                            child: Container(
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                              FontAwesomeIcons.infoCircle,
                                              size: 18,
                                              color: Color(0xFFFF8080)),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            (index + 1).toString(),
                                            style: const TextStyle(
                                              color: Color(0xFF101010),
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          widget.model!.data[index1].events
                                              .conditions[index]
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ])),
                          )
                        : const SizedBox();
                  })),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        )),
        const SizedBox(
          height: 30,
        ),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF3BADB7)))
            : widget.model!.data[index1].events.userId == widget.id
                ? Elevatedbutton(
                    primary: Colors.redAccent,
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
        const SizedBox(
          height: 20,
        ),
      ],
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
              widget.model!.data[index1].events.id.toString())
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
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
        left: 2,
        right: 2,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xffE5E7EB), width: 2)
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
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Livefeed",
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
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
                            height: size.height * 0.24,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                              //  color: Colors.red,
                            ),
                            child: Stack(
                              children: [
                                Live[index]['img']
                                            //////////////////////////
                                            .toString()
                                            .contains('.mp4') ||
                                        Live[index]['img']
                                            //////////////////////////
                                            .toString()
                                            .contains('.mov')
                                    ? VideoPlayerScreen(
                                        url: MainUrl +
                                            Live[index]['img'].toString())
                                    : Container(
                                        height: size.height * 0.21,
                                        width: size.width * 0.3,
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: buildimage(index)),
                                      ),
                                widget.model!.data[index1].events.userId ==
                                        widget.id
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () async {
                                            await showpopup(index);
                                            //setState(() {});
                                          },
                                          icon: const Icon(Icons.delete,
                                              size: 20,
                                              color: Color(0XFF368890)),
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          widget.model!.data[index1].km +
                                              " " +
                                              "miles",
                                          style: const TextStyle(
                                              color: Colors.black,
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
              const Text(
                "Snaps",
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Live.length > 0
                  ? Column(
                      children: List.generate(Live.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                  ),
                                ]),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10.0,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(300.0),
                                          child: CachedNetworkImage(
                                            imageUrl: MainUrl +
                                                widget
                                                    .model!
                                                    .data[index1]
                                                    .events
                                                    .user
                                                    .profilePicture!
                                                    .image
                                                    .toString(),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      widget
                                          .model!.data[index1].events.user.name,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    const Spacer(),
                                    time1(index1, index),
                                    widget.model!.data[index1].events.userId ==
                                            widget.id
                                        ? IconButton(
                                            onPressed: () async {
                                              await showpopup(index);
                                            },
                                            icon: const Icon(Icons.delete,
                                                size: 20,
                                                color: Color(0XFF368890)),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Live[index]['img']
                                          //////////////////////////
                                          .toString()
                                          .contains('.mp4') ||
                                      Live[index]['img']
                                          //////////////////////////
                                          .toString()
                                          .contains('.mov')
                                  ? Snapsvideoplayer(
                                      url: MainUrl +
                                          Live[index]['img'].toString())
                                  : SizedBox(
                                      height: size.height * 0.6,
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: MainUrl + Live[index]["img"],
                                        fit: BoxFit.fill,
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
                padding: const EdgeInsets.only(bottom: 10.0, right: 0, left: 0),
                child: Elevatedbutton(
                    primary: const Color(0xFF304747),
                    text: "Upload Picture/Video",
                    width: double.infinity,
                    coloring: const Color(0xFF304747),
                    onpressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Uploadimage(
                                eventId: widget.model!.data[index1].events.id,
                              )));
                    }),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Color(0xFF101010),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      primary: const Color(0xFFC8FBFF),
                    ),
                    onPressed: () {
                      setState(() {
                        swapping = livefeed.details;
                      });
                    },
                  )),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10.0, right: 0, left: 0),
              //   child: Elevatedbutton(
              //       primary: const Color(0xFFC8FBFF),
              //       text: "Cancel",
              //       width: double.infinity,
              //       shadowColor: Colors.transparent,
              //       coloring: const Color(0xFFC8FBFF),
              //       textColor: const Color(0XFF101010),

              //       onpressed: () {
              //         setState(() {
              //           swapping = livefeed.details;
              //         });
              //       }),
              // )
            ],
          ),
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
            size: 20,
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
    if (widget.eventId == null) {
      index1 = widget.indexs!;
      if (widget.model!.data[index1].events.liveFeed.length > 0) {
        for (int i = 0;
            widget.model!.data[index1].events.liveFeed.length > i;
            i++) {
          var js = {
            'img': widget.model!.data[index1].events.liveFeed[i].path,
            'id': widget.model!.data[index1].events.liveFeed[i].id,
            'createdAt': widget.model!.data[index1].events.liveFeed[i].createdAt
          };
          Live.add(js);
        }
        test1 = true;
      } else {
        test1 = false;
      }
    } else {
      // print(widget.eventId);
      var ss = widget.model!.data.indexWhere((element) {
        return element.events.id.toString() == widget.eventId;
      });
      index1 = ss;

      if (widget.model!.data[ss].events.liveFeed.length > 0) {
        for (int i = 0;
            widget.model!.data[ss].events.liveFeed.length > i;
            i++) {
          var js = {
            'img': widget.model!.data[ss].events.liveFeed[i].path,
            'id': widget.model!.data[ss].events.liveFeed[i].id,
            'createdAt': widget.model!.data[ss].events.liveFeed[i].createdAt
          };
          Live.add(js);
        }
        test1 = true;
        swapping = livefeed.livesnaps;
        setState(() {});
      } else {
        test1 = false;
      }
    }
  }

  Widget buildimage(int index) {
    return CachedNetworkImage(
      imageUrl: MainUrl + Live[index]['img'],
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF3BADB7)),
        );
      },
    );
  }

  time1(int index, int index1) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          TimeAgo.displayTimeAgoFromTimestamp(Live[index1]['createdAt']),
          style: const TextStyle(fontSize: 15, color: Colors.black45),
        ),
      ),
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
              onPressed: () async {
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
    // ignore: avoid_print
    print("inside delete snap");
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer $_token";
    FormData formData = FormData.fromMap({
      "id": Live[index]["id"],
    });
    try {
      await _dio.post(deletesnapUrl, data: formData).then((value) {
        // ignore: avoid_print
        print(value.data);
        if (value.statusCode == 200) {
          Live.removeAt(index);
          // print(Live[index]);
          showToaster("Event Snap deleted");
        } else {
          // ignore: avoid_print
          print("error");
        }
      });
    } catch (e) {
      print(e.toString());
      _isLoading = false;
      setState(() {});
    }
  }

  String time(int index) {
    DateTime parseDate = DateFormat("yyyy-mm-dd")
        .parse(widget.model!.data[index].events.eventDate);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('mm/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  void urllaundher() async {
    if (widget.model!.data[widget.indexs!].events.ticketLink != null ||
        widget.model!.data[widget.indexs!].events.ticketLink != "") {
      if (widget.model!.data[widget.indexs!].events.ticketLink!
          .contains("https://")) {
        if (await canLaunch(
            widget.model!.data[widget.indexs!].events.ticketLink!)) {
          await launch(widget.model!.data[widget.indexs!].events.ticketLink!);
        } else {
          throw 'Could not launch $widget.model!.data[widget.indexs!].events.ticketLink!';
        }
      } else {
        if (await canLaunch("https://" +
            widget.model!.data[widget.indexs!].events.ticketLink!)) {
          await launch("https://" +
              widget.model!.data[widget.indexs!].events.ticketLink!);
        } else {
          throw 'Could not launch $widget.model!.data[widget.indexs!].events.ticketLink!';
        }
      }
    }
  }
}

class Snapsvideoplayer extends StatefulWidget {
  Snapsvideoplayer({Key? key, required this.url}) : super(key: key);
  late String url;

  @override
  _SnapsvideoplayerState createState() => _SnapsvideoplayerState();
}

class _SnapsvideoplayerState extends State<Snapsvideoplayer> {
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
    _controller.setLooping(false);
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
              // _controller.play();

              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return SizedBox(
                height: size.height * 0.6,
                width: double.infinity,
                child: ClipRRect(
                  //  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(_controller),
                      ControlsOverlay(controller: _controller),
                      VideoProgressIndicator(_controller, allowScrubbing: true),
                    ],
                  ),
                ),
                //borderRadius: BorderRadius.circular(20),
                //    child: VideoPlayer(_controller),
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

class ControlsOverlay extends StatefulWidget {
  ControlsOverlay({Key? key, required this.controller}) : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  VideoPlayerController controller;

  @override
  State<ControlsOverlay> createState() => ControlsOverlayState();
}

class ControlsOverlayState extends State<ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
            setState(() {});
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: widget.controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              widget.controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in ControlsOverlay._examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${widget.controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
