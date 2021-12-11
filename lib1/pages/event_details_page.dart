import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/timeago.dart';
import 'package:event_spotter/pages/uploadimage.dart';
import 'package:event_spotter/pages/userprofile.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/explore/comment.dart';
import 'package:event_spotter/widgets/explore/events.dart';
import 'package:event_spotter/widgets/explore/livefeed.dart';
import 'package:event_spotter/widgets/map.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
        child:
        
         GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);

        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
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
        body: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
 Padding(
   padding: const EdgeInsets.only(right : 8.0 , left : 8),
   child: Container(
      width: size.width * double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 0.5,
                            blurRadius: 0.5,
                            color: Colors.black12,
                            
                            offset: Offset(2,-2)
                            ),
                            BoxShadow(
                            spreadRadius: 0.5,
                            blurRadius: 0.5,
                            color: Colors.black12,
                            
                            offset: Offset(0, 2)
                            )
                      ],
                    ),
       child: Column(children: [
         Padding(
           padding:
               const EdgeInsets.only(right: 5, left: 2,top : 2),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Button(

                   
                   onpressed: (){},
                   title: 
                   widget.model!.data[widget.indexs!].events.user.name,
                   // widget.eventsModel.data[index].events
                   //     .user.name, //new
                   radiusofbutton: BorderRadius.circular(20),
                   profileImage: MainUrl +
                       widget.model!.data[widget.indexs!].events.user
                           .profilePicture!.image
                           
                           ),
              
             ],
           ),
         ),
         Padding(
           padding: const EdgeInsets.only(
               left: 8.0, right: 8, top: 3, bottom: 3),
           child: Container(
             alignment: Alignment.centerLeft,
             child: AutoSizeText(
               widget.model!.data[widget.indexs!].events
                   .eventName,
               style: const TextStyle(
                   color: Colors.black, fontWeight: FontWeight.w400,fontSize: 17),
               maxFontSize: 17,
               minFontSize: 10,
               maxLines: 5,
             ),
           ),
         ),
         Container(
         
           decoration: const BoxDecoration(
               //borderRadius: BorderRadius.circular(15),
               ),
           width: size.width * double.infinity,
           child: 
             widget.model!.data[widget.indexs!].events.eventPictures[0]
                         .imagePath
                         .toString()
                         .contains('.mp4') ||
                     widget.model!.data[widget.indexs!].events
                         .eventPictures[0].imagePath
                         .toString()
                         .contains('.mov')
                 ? VideoPlayerScreenn(
                     url: MainUrl +
                         widget.model!.data[widget.indexs!].events
                             .eventPictures[0].imagePath)
                 : Container(
                     height: size.height * 0.4,
                     width: double.infinity,
                     decoration: const BoxDecoration(
                         // borderRadius: BorderRadius.circular(20)
                         ),
                     child: ClipRRect(
                       //  borderRadius: BorderRadius.circular(15),
                       child: CachedNetworkImage(
                         imageUrl: MainUrl +
                             widget.model!.data[widget.indexs!].events
                                 .eventPictures[0].imagePath,
                         fit: BoxFit.fill,
                         placeholder: (context, url) {
                           return const Center(
                             child: CircularProgressIndicator(),
                           );
                         },
                       ),
                     ),
                   ),
            
          
         ),
         Container(
           width: double.infinity,
           decoration: const BoxDecoration(),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              //  const SizedBox(
              //    height: 2,
              //  ),
               Container(
                 decoration: const BoxDecoration(
                   color: Colors.white,
                   border: Border(top : BorderSide( color : Colors.black12),
                 
                   ),
                  
                ),
                 child: Padding(
                   padding:
                       const EdgeInsets.only(right: 8, left: 8),
                   child: Row(
                     mainAxisAlignment:
                         MainAxisAlignment.spaceBetween,
                     children: [
                       Buttonicon(
                         radiusofbutton: BorderRadius.circular(20),
                         icon: FontAwesomeIcons.userPlus,
                         title: widget.model!.data[widget.indexs!]
                                 .events.user.followers.length
                                 .toString() +
                             " " "Followers",
                             
                       ),
                       const SizedBox(
                         width: 10,
                       ),
                       const Icon(
                         FontAwesomeIcons.calendar,
                         size: 13,
                         color: Colors.black54,
                       ),
                       Text(
                         time(widget.indexs!),
                         style: const TextStyle(
                             color: Colors.black87),
                       ),
                       const SizedBox(
                         width: 10,
                       ),
                       const Icon(
                         FontAwesomeIcons.mapMarkerAlt,
                         size: 15,
                         color: Colors.black54,
                       ),
                       Text(
                           widget.model!.data[widget.indexs!].km
                                   .toString() +
                               " " +
                               "away",
                           style: const TextStyle(
                               color: Colors.black87)),
                     ],
                   ),
                 ),
               ),
              
               const SizedBox(
                 height: 5,
               ),
               Container(
                 decoration:const BoxDecoration(
                     border: Border(top : BorderSide( color : Colors.black12),
                     
                   ),
                 ),
                 child: IntrinsicHeight(
                   child: Row(
                     mainAxisAlignment:
                         MainAxisAlignment.spaceAround,
                     children: [
                      extras(
                                FontAwesomeIcons.thumbsUp,
                                widget.model!.data[widget.indexs!].totalLikes
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
                           size, () {
                         Navigator.of(context)
                             .push(MaterialPageRoute(
                                 builder: (context) => Commentofuser(
                                       eventsModel:
                                           widget.model!,
                                       index: widget.indexs!,
                                     )));
                       }),
                       divider(),

                       // extras(MdiIcons.share,
                       //     posts[1]['share'], size),
                       // divider(),                           //no inculded
                       extras(
                           Icons.play_arrow_sharp,
                           widget.model!.data[widget.indexs!].events
                               .liveFeed.length
                               .toString(),
                           size,
                           () {
                               setState(() {
                       swapping = livefeed.livesnaps;
                     });
                           }
                           
                           ),
                     ],
                   ),
                 ),
               ),
             ],
           ),
         ),
         
      
       ]),
     
   ),
 ),

              Padding(
                padding: const EdgeInsets.only(right : 8.0 , left : 8.0 , top : 20),
                child: calloflivesnaps(size),
              ),
            
            
          ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width : double.infinity,
          decoration: const BoxDecoration( 
            color: Colors.white,
            boxShadow:  [
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
            ],),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
              ],
            ),
          ),
        ),
       
        const SizedBox(
          height: 7,
        ),

Container(
          width : double.infinity,
          decoration: const BoxDecoration( 
            color: Colors.white,
            boxShadow:  [
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
            ],),

           
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ticket link",
                  style: TextStyle(
                      color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                ),
                 const SizedBox(
            height: 10,
        ),
        Text(
            widget.model!.data[widget.indexs!].events.ticketLink!,
            style: const TextStyle(color: Colors.black54, fontSize: 16),
        ),
              ],
            ),
          ),
        ),
 const SizedBox(height: 7,),
       Container(
         width: double.infinity,
         decoration: const BoxDecoration( 
        color: Colors.white,
        boxShadow:  [
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
             0,0,
            ),
          )
        ],),

       child : Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
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
           ],
         ),
       )
       ),
        const SizedBox(
          height: 7,
        ),


        const Text(
          "Location",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
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
    return Padding(
      padding: const EdgeInsets.only(bottom : 20.0),
      child: Container(
        decoration: const BoxDecoration(
       
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: Offset(0, 0),
            ),
             BoxShadow(
              color: Colors.black12,
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5 , top : 5),
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
                                        url: MainUrl + Live[index].toString())
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
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Snaps",
                style: TextStyle(color: Colors.black, fontSize: 19),
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
                                    top: 15.0, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(300.0),
                                          child: CachedNetworkImage(
                                            imageUrl: MainUrl +
                                                widget
                                                    .model!
                                                    .data[widget.indexs!]
                                                    .events
                                                    .user
                                                    .profilePicture!
                                                    .image
                                                    .toString(),
                                            fit: BoxFit.cover,
                                          )),
                                    ),

                                  
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 20,
                                      child: Text(
                                        widget.model!.data[widget.indexs!].events
                                            .user.name,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      child: time1(widget.indexs!, index),
                                    ),
                                    widget.model!.data[widget.indexs!].events
                                                .userId ==
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
                              Live[index]
                                          //////////////////////////
                                          .toString()
                                          .contains('.mp4') ||
                                      Live[index]
                                          //////////////////////////
                                          .toString()
                                          .contains('.mov')
                                  ? VideoPlayerScreen(
                                      url: MainUrl + Live[index].toString())
                                  : SizedBox(
                                      height: size.height * 0.3,
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: MainUrl + Live[index]["img"],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ])),
                      );
                    }))
                  : Center(
                      child: Text("No Snaps"),
                    ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 30, left: 30),
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
              )
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
      if (widget.model!.data[widget.indexs!].events.liveFeed.length > 0) {
        for (int i = 0;
            widget.model!.data[widget.indexs!].events.liveFeed.length > i;
            i++) {
          var js = {
            'img': widget.model!.data[widget.indexs!].events.liveFeed[i].path,
            'id': widget.model!.data[widget.indexs!].events.liveFeed[i].id,
            'createdAt':
                widget.model!.data[widget.indexs!].events.liveFeed[i].createdAt
          };
          Live.add(js);
        }
        test1 = true;
      } else {
        test1 = false;
      }
    } else {
      print(widget.eventId);
      var ss = widget.model!.data.indexWhere((element) {
        return element.events.id.toString() == widget.eventId;
      });

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
          child: CircularProgressIndicator(),
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

  String time(int index) {
    DateTime parseDate = DateFormat("yyyy-mm-dd")
        .parse(widget.model!.data[index].events.eventDate);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }
}