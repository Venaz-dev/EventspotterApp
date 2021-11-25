import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_spotter/constant/json/live_feed.dart';
import 'package:event_spotter/constant/json/post.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/smallbutton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

class Fevents extends StatefulWidget {
  const Fevents({Key? key}) : super(key: key);

  @override
  State<Fevents> createState() => _FeventsState();
}

class _FeventsState extends State<Fevents> {
   bool isupcoming = true;
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
          final color =isliked ?  Colors.red  : Colors.grey;
        });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _search = TextEditingController();
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
            padding:  EdgeInsets.only(top: 20.0, left: size.width*0.05),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                     padding:  EdgeInsets.only(top : size.height * 0.02  , ),
                     child: Row(
                        children: [
                           SizedBox(
                             //height: size.height*0.1,
                             width: size.width*0.8 ,
                             child: Textform(
                                controller: _search,
                                icon: Icons.search,
                                label: "Search",
                                color: const Color(0XFFECF2F3),
                              
                          ),
                           ),
                           SizedBox(
                            width: size.width*0.01,
                          ),
                         Smallbutton(
                             

                              
                              icon: FontAwesomeIcons.slidersH,

                              onpressed: () {
                                setState(() {
                                  //swap = screens.filter;
                                });
                              },
                            
                          ),
                        ],
                      ),
                   ),
                  
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Elevatedbuttons(
                        sidecolor: isupcoming == true  ? Colors.transparent :Colors.black ,
                        text: "Upcoming",
                        textColor: isupcoming == true ?  Colors.white :Colors.black ,
                        coloring:isupcoming == true ? const Color(0XFF38888F) : Colors.white,
                        
                        primary:isupcoming == true ?  const Color(0XFF38888F) : Colors.white,
                        onpressed: () {
                          setState(() {
                            isupcoming = true;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Elevatedbuttons(
                        sidecolor: isupcoming == false  ? Colors.transparent :Colors.black ,
                        text: "Past Events",
                        textColor: isupcoming == false ?  Colors.white :Colors.black ,
                        coloring:isupcoming == false ? const Color(0XFF38888F) : Colors.white,
                        onpressed: () {
                          setState(() {
                            isupcoming  = false;
                          });
                        },
                        primary:isupcoming == false ?  const Color(0XFF38888F) : Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isupcoming?
                  Padding(
                    padding:  EdgeInsets.only(right : size.width*0.05),
                    child: Column(
                      children: List.generate(feed.length, (index) {
                        return Padding(
                          padding:  EdgeInsets.only(top: size.height*.01),
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
                              padding:  EdgeInsets.only(top: size.height*0.02,right: size.width*0.02 , bottom: size.height*0.02, left:  size.width*0.02),
                              child: Stack(
                                children: [
                                   Positioned(
                                    right: 0,
                                    top: 0,
                                   child :  likebutton(),
                                  ),
                                  SizedBox(
                          
                          height: size.height*0.17,
                          width: size.width*0.3,
                          child: ClipRRect(
                          
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              
                              imageUrl: feed[index]['picture'],
                              fit: BoxFit.cover,
                            placeholder: (context , url)
                            {
                              return 
                              const Center(child: CircularProgressIndicator(),);
                            },
                            ),
                          ),
                        ),
                                  Positioned(
                                    right: 20,
                                    left: size.width * 0.33,
                                    top: size.height * 0.02,
                                    child: const Text(
                                      "New year party at local park",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17),
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
                                          posts[1]['takingPlace'],
                                          style: const TextStyle(
                                              color: Colors.black87),
                                        ),
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
                                        Text(
                                              posts[1]['distance'] +
                                                  " " +
                                                  " " +
                                                  "away",
                                              style: const TextStyle(
                                                  color: Colors.black87)),
                                        
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
                                              extras(Icons.comment,
                                                  posts[1]['comment'], size),
                                              divider(),
                                              extras(MdiIcons.share,
                                                  posts[1]['share'], size),
                                              divider(),
                                              extras(Icons.live_tv,
                                                  posts[1]['viewers'], size),
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
                  )

                  :

                 const  Center(
                    child: Text("No Past events"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
