import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;
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
import 'package:event_spotter/pages/create_new_event.dart';

class Dashboard extends StatefulWidget {
  String id;
  Dashboard({Key? key, required this.id}) : super(key: key);
//
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
          test = true;
          if (Platform.isIOS) {
            FlutterBeep.playSysSound(iOSSoundIDs.MailReceived);
          } else {
            FlutterBeep.playSysSound(AndroidSoundIDs.TONE_SUP_PIP);
          }

          chatStream1.sink.add(jsonEncode(ssq));
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List bottomitems = [
      Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                      color: pageindex == 0 ? Colors.black : Colors.transparent,
                      width: 2),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 12),
              child: SizedBox(
                  width: 24.0,
                  child: Image(
                      image: pageindex == 0
                          ? const AssetImage("Assets/icons/explore.png")
                          : const AssetImage(
                              "Assets/icons/explore-inactive.png")))),
        ],
      ),
      Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                      color: pageindex == 1 ? Colors.black : Colors.transparent,
                      width: 2),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 12),
              child: SizedBox(
                  width: 22.0,
                  child: Image(
                      image: pageindex == 1
                          ? const AssetImage("Assets/icons/chat.png")
                          : const AssetImage(
                              "Assets/icons/chat-inactive.png")))),
        ],
      ),

      Column(
        children: [
          Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              child: const SizedBox(
                  width: 35.0,
                  child: Image(image: AssetImage("Assets/icons/plus.png")))),
        ],
      ),
      // Profile Icon Here
      Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                      color: pageindex == 3 ? Colors.black : Colors.transparent,
                      width: 2),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 12),
              child: SizedBox(
                  width: 20.0,
                  child: Image(
                      image: pageindex == 3
                          ? const AssetImage("Assets/icons/profile.png")
                          : const AssetImage(
                              "Assets/icons/profile-inactive.png")))),
        ],
      ),

      // More Icon Here
      Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 12),
              decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                  top: BorderSide(
                      color: pageindex == 4 ? Colors.black : Colors.transparent,
                      width: 2),
                ),
              ),
              child: SizedBox(
                  width: 22.0,
                  child: Image(
                      image: pageindex == 4
                          ? const AssetImage("Assets/icons/more.png")
                          : const AssetImage(
                              "Assets/icons/more-inactive.png")))),
        ],
      ),
      // pageindex == 4
      //     ? Column(
      //         children: [
      //           Container(
      //               color: Colors.white,
      //               padding: const EdgeInsets.all(12),
      //               child: const SizedBox(
      //                   width: 22.0,
      //                   child:
      //                       Image(image: AssetImage("Assets/icons/more.png")))),
      //         ],
      //       )
      //     : Column(
      //         children: [
      //           Container(
      //               padding: const EdgeInsets.symmetric(
      //                   vertical: 21, horizontal: 12),
      //               decoration: const BoxDecoration(
      //                 // color: Colors.red,
      //                 border: Border(
      //                   top: BorderSide(color: Colors.black, width: 2),
      //                 ),
      //               ),
      //               child: const SizedBox(
      //                   width: 22.0,
      //                   child:
      //                       Image(image: AssetImage("Assets/icons/more.png")))),
      //         ],
      //       ),
    ];
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: getbody(pageindex),
        bottomNavigationBar: Container(
          height: size.height * 0.08,
          width: size.width * double.infinity,
          decoration: const BoxDecoration(
              color: bottom_navigationbg,
              border: Border(top: BorderSide(color: Color(0xFFE5E7EB)))),
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
    // const Noti(),s
    Notifications(),
    const Createevent(),
    const Profile(),
    const More(),
  ];

  return IndexedStack(
    index: pageindex,
    children: pages,
  );
}
