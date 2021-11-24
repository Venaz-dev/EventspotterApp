import 'package:event_spotter/pages/chat.dart';
import 'package:event_spotter/pages/explore.dart';
import 'package:event_spotter/pages/more.dart';
import 'package:event_spotter/pages/notification.dart';
import 'package:event_spotter/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:event_spotter/constant/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageindex = 0;
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
              children: const [
                Icon(FontAwesomeIcons.commentDots,
                    color: Colors.white, size: 40),
                Text("chat", style: TextStyle(color: bottom_navigationitems))
              ],
            )
          : Column(
              children: const [
                Icon(
                  FontAwesomeIcons.commentDots,
                  color: bottom_navigationitems,
                  size: 30,
                ),
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
        bottomNavigationBar: 
        
        
        Container(
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

getbody(int pageindex) {
  List<Widget> pages = [
    const Explore(),
    const Notifications(),
    const Noti(),
    const Profile(),
    const More(),
  ];

  return IndexedStack(
    index: pageindex,
    children: pages,
  );
}
