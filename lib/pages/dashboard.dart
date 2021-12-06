import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:event_spotter/models/ChatModel.dart';
import 'package:event_spotter/pages/chat.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/more.dart';
import 'package:event_spotter/pages/notification.dart';
import 'package:event_spotter/pages/profile.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:event_spotter/constant/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
   String id;
  Dashboard({
    Key? key,required this.id
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageindex = 0;
  bool hasMessaged = false;
  late PusherClient pusher;
  late SharedPreferences _sharedPreferences;
  late String id;
  Channel? channel;
  StreamController<dynamic> chatStream = StreamController<dynamic>.broadcast();
  @override
  void initState() {
    intiliaziePusher();
    // TODO: implement initState
    // channel.bind('send', (event) {
    //   //  if(event!.data!['data']['to_user_id'] == '3')
    //   if (jsonDecode(event!.data!)['data']['to_user_id'] == '3') {
    //     hasMessaged = true;
    //     setState(() {});
    //   }
    // });
    super.initState();
  }

  intiliaziePusher() {
    pusher = PusherClient(
      "d472b6d313e1bef33bb2",
      PusherOptions(
        host: 'https://theeventspotter.com',
        encrypted: true,
        cluster: 'ap2',
      ),
      enableLogging: true,
    );
    channel = pusher.subscribe("chat");

    // channel!.bind(
    //   'send',
    //   (event) {
    //     // ignore: avoid_print
    //     print('hgkjhkjhkljhkljhkjhkjh');
    //     log("SEND Event" + event!.data.toString());
    //     var ss = (jsonDecode(event.data!));
    //     ChatModel _chatModel = ChatModel.fromJson(ss);
    //     if (ss['data']['to_user_id'] == widget.id) {
    //       hasMessaged = true;
    //       setState(() {});
    //       print("Done inside //////////////////");
    //       chatStream.sink.add(event.data);

    //       showToaster1("${_chatModel.data.fromUserName} Send Message");
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    List bottomitems = [
      pageindex == 0
          ? Column(
              children: const [
                Icon(Icons.explore, color: Colors.white, size: 40),
                Text("Explore", style: TextStyle(color: bottom_navigationitems))
              ],
            )
          : Column(
              children: const [
                Icon(
                  Icons.explore,
                  color: bottom_navigationitems,
                  size: 30,
                ),
                Text("Explore", style: TextStyle(color: bottom_navigationitems))
              ],
            ),
      pageindex == 1
          ? Column(
              children: [
                Stack(children: [
                  const Icon(FontAwesomeIcons.commentDots,
                      color: Colors.white, size: 40),
                ]),
                Text("chat", style: TextStyle(color: bottom_navigationitems))
              ],
            )
          : Column(
              children: [
                Stack(children: [
                  Icon(
                    FontAwesomeIcons.commentDots,
                    color: bottom_navigationitems,
                    size: 30,
                  ),
                  hasMessaged
                      ? Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: Icon(Icons.brightness_1,
                              size: 8.0, color: Colors.redAccent),
                        )
                      : SizedBox(),
                ]),
                Text("chat", style: TextStyle(color: bottom_navigationitems))
              ],
            ),
      pageindex == 2
          ? Column(
              children: const [
                Icon(Icons.notifications_none, color: Colors.white, size: 40),
                Text("notifications",
                    style: TextStyle(color: bottom_navigationitems))
              ],
            )
          : Column(
              children: const [
                Icon(
                  Icons.notifications_none,
                  color: bottom_navigationitems,
                  size: 30,
                ),
                Text("notifications",
                    style: TextStyle(color: bottom_navigationitems))
              ],
            ),
      pageindex == 3
          ? Column(
              children: const [
                Icon(Icons.person, color: Colors.white, size: 40),
                Text("profile", style: TextStyle(color: bottom_navigationitems))
              ],
            )
          : Column(
              children: const [
                Icon(
                  Icons.person,
                  color: bottom_navigationitems,
                  size: 30,
                ),
                Text("profile", style: TextStyle(color: bottom_navigationitems))
              ],
            ),
      pageindex == 4
          ? Column(
              children: const [
                Icon(Icons.more_horiz, color: Colors.white, size: 40),
                Text("more", style: TextStyle(color: bottom_navigationitems))
              ],
            )
          : Column(
              children: const [
                Icon(
                  Icons.more_horiz,
                  color: bottom_navigationitems,
                  size: 30,
                ),
                Text("more", style: TextStyle(color: bottom_navigationitems))
              ],
            )
    ];
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: getbody(pageindex, channel!),
        bottomNavigationBar: Container(
          height: size.height * 0.08,
          width: size.width * double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: bottom_navigationbg),
          child: Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(bottomitems.length, (index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          pageindex = index;
                          if (pageindex == 1) hasMessaged = false;
                          print(pageindex);
                        });
                      },
                      child: FittedBox(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [bottomitems[index]]),
                      ));
                })),
          ),
        ),
        //getfotter(pageindex , size),
      ),
    );
  }
}

// getfotter(int pageindex , Size size) {

//return

//}

getbody(
  int pageindex,
  Channel channel1,
) {
  List<Widget> pages = [
    const Explore(),
    Notifications(
      channel: channel1,
    ),
    const Noti(),
    const Profile(),
    const More(),
  ];

  return IndexedStack(
    index: pageindex,
    children: pages,
  );
}
