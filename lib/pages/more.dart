import 'dart:ffi';

import 'package:event_spotter/pages/favouritesevents.dart';
import 'package:event_spotter/pages/followers.dart';
import 'package:event_spotter/pages/following.dart';
import 'package:event_spotter/pages/request.dart';
import 'package:event_spotter/pages/yourevents.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'notification.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 80.0, left: 15, right: 15),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   height: size.height * 0.06,
                    //   width: size.width * 0.8,
                    //   decoration: BoxDecoration(

                    //       color: const Color(0XFF38888F),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: const Align(
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //         "Explore events",
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w500),
                    //         textAlign: TextAlign.center,
                    //       )),
                    // ),
                    Container(
                      height: size.height * 0.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Containers(
                            background: Colors.white,
                            icon: FontAwesomeIcons.ticketAlt,
                            showBorder: true,
                            name: "Your events",
                            onPresses: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Yevents()));
                            },
                          ),
                          Containers(
                            background: Colors.white,
                            icon: FontAwesomeIcons.solidStar,
                            showBorder: true,
                            name: "Favorite events",
                            onPresses: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Fevents()));
                            },
                          ),
                          Containers(
                            background: Colors.white,
                            icon: FontAwesomeIcons.users,
                            showBorder: true,
                            name: "Followers",
                            onPresses: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Following()));
                            },
                          ),
                          Containers(
                            background: Colors.white,
                            icon: FontAwesomeIcons.userFriends,
                            name: "Following",
                            showBorder: true,
                            onPresses: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Follower()));
                            },
                          ),
                          Containers(
                              background: Colors.white,
                              icon: FontAwesomeIcons.userPlus,
                              name: "Pending requests",
                              onPresses: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Pendingrequests()));
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                  height: 58,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFE5E7EB), width: 1))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 5),
                    child: Row(
                      children: [
                        const SizedBox(
                            width: 35.0,
                            child: Image(
                                image: AssetImage(
                                    "Assets/images/logo-no-text.png"))),
                        const Spacer(),
                        SizedBox(
                          width: 55,
                          height: 50,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Noti()),
                              );
                            },
                            child: Container(
                                child: const Center(
                                    child: SizedBox(
                                        width: 30.0,
                                        child: Image(
                                            image: AssetImage(
                                                "Assets/icons/notification.png"))))),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ])),
    );
  }
}

class Containers extends StatelessWidget {
  const Containers(
      {Key? key,
      this.background,
      this.icon,
      this.showBorder,
      required this.name,
      this.onPresses})
      : super(key: key);

  final Color? background;
  final IconData? icon;
  final String name;
  final VoidCallback? onPresses;
  final bool? showBorder;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
        color: background,
        border: Border(
          bottom: BorderSide(
              color:
                  showBorder != null ? Color(0xFFE5E7EB) : Colors.transparent,
              width: 1),
        ),
      ),
      child: MaterialButton(
        onPressed: onPresses,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            // const  Spacer(),
            const SizedBox(
              width: 30,
            ),
            Expanded(
                child: AutoSizeText(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              textAlign: TextAlign.start,
            ))
          ],
        ),
      ),
    );
  }
}
