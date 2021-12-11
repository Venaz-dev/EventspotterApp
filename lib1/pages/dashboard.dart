import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:event_spotter/pages/chat.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/more.dart';
import 'package:event_spotter/pages/notification.dart';
import 'package:event_spotter/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:event_spotter/constant/colors.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  String id;
  Dashboard({Key? key, required this.id}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageindex = 0;
  //bool test = false;
  final StreamController<bool> isLoading = StreamController<bool>();
  final TextEditingController _writemessage = TextEditingController();
  late List<Map<String, dynamic>> chatList = [];
  late PusherClient pusher;
  bool test = false;
  StreamController<dynamic> chatStream1 = StreamController<dynamic>.broadcast();
  late String _token;
  late String _id;
  late String id;
  late SharedPreferences _sharedPreferences;

  Channel? channel;
  StreamController<dynamic> chatStream = StreamController<dynamic>.broadcast();
  @override
  void initState() {
    intiliaziePusher();

    super.initState();
  }

  intiliaziePusher() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _id = _sharedPreferences.getString('id')!;
    pusher = PusherClient(
      "d472b6d313e1bef33bb2",
      PusherOptions(
        host: 'https://theeventspotter.com',
        encrypted: true,
        cluster: 'ap2',
      ),
      enableLogging: true,
    );
    channel = pusher.subscribe('chat');
    channel!.bind(
      'send',
      (event) {
        // ignore: avoid_print
        print('hgkjhkjhkljhkljhkjhkjh');
        log("SEND Event" + event!.data.toString());
        var ss = (jsonDecode(event.data!));
        if (ss['data']['to_user_id'] == _id) {
          Map<String, dynamic> ssq = {
            'content': ss['data']['content'],
            'toUserId': _id,
          };
          FlutterBeep.playSysSound(iOSSoundIDs.MailReceived);
          test = true;
          chatStream1.sink.add(jsonEncode(ssq));
          setState(() {});
        }
      },
    );
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
                  const Icon(
                    FontAwesomeIcons.commentDots,
                    color: bottom_navigationitems,
                    size: 30,
                  ),
                  test
                      ? const Positioned(
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
        body: getbody(pageindex),
        bottomNavigationBar: Container(
          height: size.height * 0.08,
          width: size.width * double.infinity,
          decoration: const BoxDecoration(color: bottom_navigationbg),
          child: Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(bottomitems.length, (index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          pageindex = index;
                          if (pageindex == 1) test = false;
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
) {
  List<Widget> pages = [
    const Explore(),
    Notifications(),
    const Noti(),
    const Profile(),
    const More(),
  ];

  return IndexedStack(
    index: pageindex,
    children: pages,
  );
}
