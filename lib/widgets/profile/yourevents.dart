import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_spotter/constant/json/post.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum yourevent { upcoming, pastevents, drafts }

class Yourevents extends StatefulWidget {
  const Yourevents({
    Key? key,
    required this.images,
    required this.size,
  }) : super(key: key);

  final List images;
  final Size size;

  @override
  State<Yourevents> createState() => _YoureventsState();
}

class _YoureventsState extends State<Yourevents> {


  yourevent eventshuffling = yourevent.upcoming;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(
                      0,
                      0,
                    )),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Your Events",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              eventstype(),
            ]),
          ),
        ),
      ],
    );
  }

  Widget eventstype() {
    switch (eventshuffling) {
      case yourevent.upcoming:
        return upcoming();

      case yourevent.pastevents:
        return past();

      case yourevent.drafts:
        return drafts();
    }
  }

  Widget upcoming() {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: Row(
            children: [
              Elevatedbuttons(
                sidecolor: Colors.white,
                primary: const Color(0XFF38888F),
                text: "Upcoming",
                textColor: Colors.white,
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    setState(() {
                      eventshuffling = yourevent.upcoming;
                    });
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Past Events",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.pastevents;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Drafts",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.drafts;
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
          children: List.generate(widget.images.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: FittedBox(
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
                        // Container(
                        //   height: widget.size.height * 0.17,
                        //   width: widget.size.width * 0.3,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(15),
                        //       image: DecorationImage(
                        //           image: CachedNetworkImageProvider(
                        //               widget.images[index]['eventimage']),
                        //           fit: BoxFit.cover)),
                        // ),
                        SizedBox(
                        
                        height: widget.size.height*0.17,
                        width: widget.size.width*0.3,
                        child: ClipRRect(
                        
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            
                            imageUrl: widget.images[index]['eventimage'],
                            fit: BoxFit.cover,
                          placeholder: (context , url)
                          {
                            return 
                            const Center(child: CircularProgressIndicator(),);
                          },
                          ),
                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "New year party\nat local park",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
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
                                    posts[1]['takingPlace'],
                                    style:
                                        const TextStyle(color: Colors.black87),
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
                                  Text(posts[1]['distance'] + " " + "away",
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
        ),
      ],
    );
  }

  Widget past() {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: Row(
            children: [
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Upcoming",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.upcoming;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
             Elevatedbuttons(
                sidecolor: Colors.white,
                primary: const Color(0XFF38888F),
                text: "Past Events",
                textColor: Colors.white,
                coloring: const Color(0XFF38888F),
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.pastevents;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Drafts",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.drafts;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

       const  Center(child: Text('No past events'),)
        // Column(
        //   children: List.generate(widget.images.length, (index) {
        //     return Padding(
        //       padding: const EdgeInsets.only(top: 20.0),
        //       child: FittedBox(
        //         child: Container(
        //           // width: double.infinity,
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(15),
        //               boxShadow: const [
        //                 BoxShadow(
        //                     color: Colors.black12,
        //                     blurRadius: 10,
        //                     spreadRadius: 2)
        //               ]),
        //           child: Padding(
        //             padding: const EdgeInsets.only(
        //                 top: 20.0, right: 15, left: 15, bottom: 15),
        //             child: Row(
        //               children: [
        //                 Container(
        //                   height: widget.size.height * 0.17,
        //                   width: widget.size.width * 0.3,
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(15),
        //                       image: DecorationImage(
        //                           image: NetworkImage(
        //                               widget.images[index]['eventimage']),
        //                           fit: BoxFit.cover)),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(left: 10.0),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       const Text(
        //                         "New year party\nat local park",
        //                         style: TextStyle(
        //                             color: Colors.black,
        //                             fontWeight: FontWeight.w500,
        //                             fontSize: 20),
        //                       ),
        //                       const SizedBox(
        //                         height: 10,
        //                       ),
        //                       Row(
        //                         children: [
        //                           const Icon(
        //                             FontAwesomeIcons.calendar,
        //                             size: 15,
        //                             color: Colors.black54,
        //                           ),
        //                           Text(
        //                             posts[1]['takingPlace'],
        //                             style:
        //                                 const TextStyle(color: Colors.black87),
        //                           ),
        //                         ],
        //                       ),
        //                       const SizedBox(
        //                         height: 10,
        //                       ),
        //                       Row(
        //                         children: [
        //                           const Icon(
        //                             FontAwesomeIcons.mapMarkerAlt,
        //                             size: 15,
        //                             color: Colors.black54,
        //                           ),
        //                           Text(posts[1]['distance'] + " " + "away",
        //                               style: const TextStyle(
        //                                   color: Colors.black87)),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   }),
        // ),
      ],
    );
  }

  Widget drafts() {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: Row(
            children: [
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Upcoming",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.upcoming;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: const Color(0XFF38888F),
                primary: Colors.white,
                text: "Past Events",
                textColor: const Color(0XFF38888F),
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    eventshuffling = yourevent.pastevents;
                  });
                },
              ),
              const SizedBox(
                width: 30,
              ),
              Elevatedbuttons(
                sidecolor: Colors.white,
                primary: const Color(0XFF38888F),
                text: "Drafts",
                textColor: Colors.white,
                coloring: Colors.white,
                onpressed: () {
                  setState(() {
                    setState(() {
                      eventshuffling = yourevent.upcoming;
                    });
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        const Text("No Drafts"),
        // Column(
        //   children: List.generate(widget.images.length, (index) {
        //     return Padding(
        //       padding: const EdgeInsets.only(top : 20.0),
        //       child: FittedBox(
        //         child: Container(
        //           // width: double.infinity,
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(15),
        //               boxShadow: const [
        //                 BoxShadow(
        //                     color: Colors.black12,
        //                     blurRadius: 10,
        //                     spreadRadius: 2)
        //               ]),
        //           child: Padding(
        //             padding: const EdgeInsets.only(
        //                 top: 20.0,
        //                 right: 15,
        //                 left: 15,
        //                 bottom: 15),
        //             child: Row(
        //               children: [
        //                 Container(
        //                   height: widget.size.height * 0.17,
        //                   width: widget.size.width * 0.3,
        //                   decoration: BoxDecoration(
        //                       borderRadius:
        //                           BorderRadius.circular(15),
        //                       image: DecorationImage(
        //                           image: NetworkImage(
        //                               widget.images[index]['eventimage']),
        //                           fit: BoxFit.cover)),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(left  : 10.0),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                      const  Text(
        //                         "New year party\nat local park",
        //                         style: TextStyle(
        //                             color: Colors.black,
        //                             fontWeight: FontWeight.w500,
        //                             fontSize: 20),
        //                       ),
        //                       const SizedBox(height: 10,),
        //                       Row(
        //                         children: [
        //                           const Icon(
        //                             FontAwesomeIcons.calendar,
        //                             size: 15,
        //                             color: Colors.black54,
        //                           ),
        //                           Text(
        //                             posts[1]['takingPlace'],
        //                             style: const TextStyle(
        //                                 color: Colors.black87),
        //                           ),
        //                         ],
        //                       ),

        //                       const SizedBox(height: 10,),
        //                       Row(
        //                         children: [
        //                           const Icon(
        //                             FontAwesomeIcons.mapMarkerAlt,
        //                             size: 15,
        //                             color: Colors.black54,
        //                           ),
        //                           Text(
        //                               posts[1]['distance'] +
        //                                   " " +
        //                                   "away",
        //                               style: const TextStyle(
        //                                   color: Colors.black87)),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   }),
        // ),
      ],
    );
  }
}
