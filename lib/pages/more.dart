import 'package:event_spotter/pages/eventsattended.dart';
import 'package:event_spotter/pages/favouritesevents.dart';
import 'package:event_spotter/pages/followers.dart';
import 'package:event_spotter/pages/following.dart';
import 'package:event_spotter/pages/yourevents.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';


class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top : 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.06,
                width: size.width * 0.8,
                decoration:  BoxDecoration(color:const  Color(0XFF38888F) , borderRadius: BorderRadius.circular(10)),
                child:const  Align(
                  alignment: Alignment.center,
                  child:  Text("Explore events" , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.w500), textAlign: TextAlign.center,)),
              ),
              Container(
                height: size.height * 0.4,
                width: size.width * 0.8,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                    children:   [
                      Containers(background: Colors.white , icon: FontAwesomeIcons.calendarTimes ,name: "Your events",onPresses: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Yevents()));},),
                     Containers(background: Colors.white ,icon: FontAwesomeIcons.heart ,name: "Favorite events",onPresses: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Fevents()));},),
                      Containers(background: Colors.white ,icon: FontAwesomeIcons.userPlus ,name: "Followers",onPresses: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Following()));},),
                    Containers(background: Colors.white ,icon: FontAwesomeIcons.userCheck, name: "Following", onPresses: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const   Followers()));
                    }),
                    // Containers(background: Colors.white , icon: FontAwesomeIcons.calendarCheck, name: "Events you attended",onPresses: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Eventsattended()));},),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class Containers extends StatelessWidget {
const  Containers({Key? key, this.background, this.icon, required this.name, this.onPresses}) : super(key: key);

  final Color? background;
  final IconData ? icon;
  final String name;
  final VoidCallback ? onPresses;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap:onPresses,
      child: Container(
        height: size.height * 0.066,
        width: size.width * 0.6,
        decoration: BoxDecoration(
          color: background,
          border: const Border(
              top: BorderSide(color: Colors.white),
              left: BorderSide(color: Colors.white),
              right: BorderSide(color: Colors.white),
              bottom: BorderSide(color: Colors.black26)),
        ),
    
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
              Icon(icon , color: Colors.black,),
            // const  Spacer(),
         const SizedBox(width: 30,),
              Expanded(child: AutoSizeText(name ,style:const  TextStyle(fontWeight: FontWeight.w500 , fontSize: 18), textAlign: TextAlign.start,))
          ],
        ),
      ),
    );
  }
}


//0XFF38888F