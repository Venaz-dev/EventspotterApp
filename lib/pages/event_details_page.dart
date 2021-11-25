import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/map.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

class Eventdetailing extends StatefulWidget {
  EventsModel? model;
  final int? indexs;
  Eventdetailing({
    Key? key,
    //  this.networkImage, this.isfollow, this.uploaderName, this.uploaderimage, this.followers, this.takingplace, this.distance, required this.description, this.like, this.comment, this.share, this.views
    @required this.model,
    this.indexs,
  }) : super(key: key);

  @override
  State<Eventdetailing> createState() => _EventdetailingState();
}

class _EventdetailingState extends State<Eventdetailing> {
  @override
  void initState() {
    super.initState();
  }

  String MainUrl1 = "https://theeventspotter.com/";
  @override
  Widget build(BuildContext context) {
    print(widget.model!.data[0].events.eventName.toString());
    bool active = false;

    String description =
        widget.model!.data[widget.indexs!].events.eventDescription;
    TextEditingController _search = TextEditingController();
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
          padding:
              const EdgeInsets.only(right: 30.0, left: 30, top: 20, bottom: 30),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Smallbutton(
                    //   size: size.height * 0.,
                    icon: FontAwesomeIcons.arrowLeft,
                    onpressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: size.width * 0.5),
                    child: Textform(
                      controller: _search,
                      icon: Icons.search,
                      label: "Search",
                      color: const Color(0XFFECF2F3),
                    ),
                  ),
                  const Smallbutton(
                    // size: size.height * 0.08,
                    icon: FontAwesomeIcons.slidersH,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
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
                      Container(
                        height: size.height * 0.25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: MainUrl1 +
                                widget.model!.data[widget.indexs!].events
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
                        right: 10,
                        top: size.height * 0.02,
                        child: SizedBox(
                          height: size.height * 0.04,
                          width: size.width * 0.25,
                          // decoration: const BoxDecoration(color: Color(0XFF38888E)),
                          child: ElevatedButton(
                              onPressed: () {},
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
                        top: size.height * 0.07,
                        right: size.width * 0.02,
                        child: Column(children: [
                          LikeButton(
                              size: 20,
                              isLiked: active,
                              likeBuilder: (isliked) {
                                final color =
                                    isliked ? Colors.red : Colors.grey;
                                return Icon(Icons.favorite,
                                    color: color, size: 20);
                              },
                              countBuilder: (count, isliked, text) {
                                final color =
                                    isliked ? Colors.red : Colors.grey;
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          LikeButton(
                              size: 20,
                              isLiked: active,
                              likeBuilder: (isliked) {
                                final color =
                                    isliked ? Colors.green : Colors.grey;
                                return Icon(Icons.flag, color: color, size: 20);
                              },
                              countBuilder: (count, isliked, text) {
                                final color =
                                    isliked ? Colors.green : Colors.grey;
                              }),
                        ]),
                      ),
                      Positioned(
                        bottom: 0,
                        right: size.width * 0.02,
                        left: size.width * 0.02,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Button(
                            //     title: widget.model!.data[widget.indexs!].events
                            //         .user.name,
                            //     radiusofbutton: BorderRadius.circular(20),
                            //     profileImage: MainUrl1 +
                            //         widget.model!.data[widget.indexs!].events
                            //             .user.profilePicture.image) ,
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Buttonicon(
                              radiusofbutton: BorderRadius.circular(20),
                              icon: FontAwesomeIcons.userPlus,
                              title: widget
                                      .model!.data[widget.indexs!].Following
                                      .toString() +
                                  " " "Followers",
                            ),
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
                              const SizedBox(width: 2,),
                              Text(
                                widget.model!.data[widget.indexs!].events
                                    .eventDate,
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
                                  widget.model!.data[widget.indexs!].km +
                                      " " +
                                      "away",
                                  style:
                                      const TextStyle(color: Colors.black87)),
                            ],
                          ),
                        ),
                        Positioned(
                            top: size.height * 0.04,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                description,
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
                          child: Row(
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    extras(
                                        FontAwesomeIcons.thumbsUp,
                                        widget
                                            .model!.data[widget.indexs!].isLiked
                                            .toString(),
                                        size),
                                    divider(),
                                    extras(
                                        Icons.comment,
                                        widget.model!.data[widget.indexs!]
                                            .events.comment.length
                                            .toString(),
                                        size),
                                    // divider(),
                                    // extras(MdiIcons.share, posts[1]['share'],
                                    //     size),
                                    divider(),
                                    extras(
                                        Icons.live_tv,
                                        widget.model!.data[widget.indexs!]
                                            .events.liveFeed.length
                                            .toString(),
                                        size),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white10,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(
                        4,
                        8,
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        widget.model!.data[widget.indexs!].events
                            .eventDescription,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Conditions",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      Wrap(
                          children: List.generate(
                              widget.model!.data[widget.indexs!].events
                                  .conditions.length, (index) {
                        return widget.model!.data[widget.indexs!].events
                                    .conditions[index] !=
                                ''
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(right: 6.0, top: 10),
                                child: Elevatedbuttons(
                                  sidecolor: Colors.black,
                                  coloring: Colors.white,
                                  text: widget.model!.data[widget.indexs!]
                                      .events.conditions[index]
                                      .toString(),
                                  textColor: Colors.black,
                                  primary: Colors.white,
                                  onpressed: () {},
                                ),
                              )
                            : const SizedBox();
                      })),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Location",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
                          lat: widget.model!.data[widget.indexs!].events.lat
                              .toString(),
                          long: widget.model!.data[widget.indexs!].events.lng
                              .toString(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.model!.data[widget.indexs!].events.location
                            .toString(),
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Elevatedbutton(
                        text: "Create",
                        width: double.infinity,
                        coloring: Color(0xFF304747),
                        textColor: Color(0XFFFFFFFF),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
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

  VerticalDivider divider() {
    return const VerticalDivider(
      thickness: 1,
      color: Colors.black26,
      indent: 13,
      endIndent: 13,
    );
  }
}

// body: Padding(
//   padding: const EdgeInsets.only(right : 30.0 , left : 30),
//   child: Column(
//     children: [
//       Row(
//       //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [

//           Smallbutton(
//         size: size.height * 0.06, icon :  FontAwesomeIcons.arrowLeft , onpressed: (){
//           Navigator.of(context).pop();
//         },
//   ),

//  const  SizedBox(width: 5,),
//            ConstrainedBox(
//                     constraints:
//                         BoxConstraints.tightFor(width: size.width * 0.5),
//                     child: Textform(
//                       controller: _search,
//                       icon: Icons.search,
//                       label: "Search",
//                       color: const Color(0XFFECF2F3),
//                     ),
//                   ),
//                 const SizedBox(width: 5,),
//                   Expanded(
//                     child: Smallbutton(size:size.height*0.08  , icon: FontAwesomeIcons.slidersH,),
//                   ),
//         ],
//       ),

//       Container(
//             height: size.height * 0.38,
//             width: size.width * double.infinity,
//             decoration: BoxDecoration(
//               color: const Color(0XFFFFFFFF),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Column(children: [
//               Container(
//                 height: size.height * 0.25,
//                 width: size.width * double.infinity,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     image: DecorationImage(
//                         image: NetworkImage(widget.networkImage!),
//                         fit: BoxFit.cover)),
//                 child: Stack(children: [
//                   Positioned(
//                     right: 20,
//                     top: 10,
//                     child: Container(
//                       height: size.height * 0.04,
//                       width: size.width * 0.25,
//                       // decoration: const BoxDecoration(color: Color(0XFF38888E)),
//                       child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             primary: const Color(0XFF38888E),
//                           ),
//                           child: Row(
//                             children: [
//                               const Icon(
//                                 FontAwesomeIcons.userPlus,
//                                 size: 10,
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(widget.isfollow!),
//                             ],
//                           )),
//                     ),
//                   ),
//                   Positioned(
//                     top: 70,
//                     right: 20,
//                     child: Column(children: [
//                       flaggedOrLiked(size, FontAwesomeIcons.heart),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       flaggedOrLiked(size, FontAwesomeIcons.flag),
//                     ]),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             right: 10.0, left: 10, bottom: 10),
//                         child: Row(
//                           mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                           children: [
//                             Button(
//                                 title: widget.uploaderName!,
//                                 radiusofbutton:
//                                     BorderRadius.circular(10),
//                                 profileImage: widget.uploaderimage!),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Button(
//                               radiusofbutton: BorderRadius.circular(10),
//                               icon: FontAwesomeIcons.userPlus,
//                               title:widget.followers!,
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   )
//                 ]),
//               ),
//               Container(
//                 height: size.height * 0.12,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(),
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: 10,
//                       right: 10,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           const Icon(
//                             FontAwesomeIcons.calendar,
//                             size: 15,
//                             color: Colors.black54,
//                           ),
//                           Text(
//                            widget.takingplace!,
//                             style:
//                                 const TextStyle(color: Colors.black87),
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           const Icon(
//                             FontAwesomeIcons.mapMarkerAlt,
//                             size: 15,
//                             color: Colors.black54,
//                           ),
//                           Text(widget.distance!,
//                               style: const TextStyle(
//                                   color: Colors.black87)),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                         top: 40,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             widget.description,
//                             style: const TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         )),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               left: 20.0, right: 50),
//                           child: Row(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                             children: [
//                               extras(FontAwesomeIcons.thumbsUp,
//                                  widget.like!, size),
//                               Container(
//                                 height: size.height * 0.02,
//                                 width: size.width * 0.003,
//                                 color: Colors.black26,
//                               ),
//                               extras(FontAwesomeIcons.commentAlt,
//                                  widget.comment!, size),
//                               Container(
//                                 height: size.height * 0.02,
//                                 width: size.width * 0.003,
//                                 color: Colors.black26,
//                               ),
//                               extras(FontAwesomeIcons.share,
//                                  widget.share!, size),
//                               Container(
//                                 height: size.height * 0.02,
//                                 width: size.width * 0.003,
//                                 color: Colors.black26,
//                               ),
//                               extras(FontAwesomeIcons.tv,
//                                   widget.views!, size),
//                             ],
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               )
//             ]),
//           ),
//     ],
//   ),
// ),
// ),