import 'package:event_spotter/pages/uploadimage.dart';
import 'package:event_spotter/widgets/conditions.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/smallButton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Createevent extends StatelessWidget {
  const Createevent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    TextEditingController eventname = TextEditingController();
    TextEditingController eventDescription = TextEditingController();

    TextEditingController venue = TextEditingController();

    TextEditingController link = TextEditingController();

    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);

        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Create a new event",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              onPressed: () {},
              color: Colors.black38,
            )
          ],
          leading: Smallbutton(
              height: size.height * 0.06, icon :  FontAwesomeIcons.arrowLeft , onpressed: (){
                Navigator.of(context).pop();
              },
        ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 40.0, left: 40, top: 20 , bottom : 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.35,
                  width: size.width * double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54),
                        left: BorderSide(color: Colors.black54),
                        right: BorderSide(color: Colors.black54),
                        bottom: BorderSide(color: Colors.black54)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20),
                    child: Column(
                      children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: size.height * 0.2,
                          child: Image.asset('Assets/images/upload.jpeg')),
                      const SizedBox(
                        height: 10,
                      ),
                      const AutoSizeText(
                        "Upload a catchy event picture or a video",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Elevatedbutton(
                        primary: const Color(0xFF304747),
                          text: "Upload Picture/Video",
                          width: double.infinity,
                          coloring: const Color(0xFF304747),
                          onpressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Uploadimage()));
                          }),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Textform(
                  controller: eventname,
                  maxlines: 1,
                  label: "Event name",
                  color: const Color(0XFFEBF2F2),
                  isSecure: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Textform(
                  controller: eventDescription,
                  maxlines: 4,
                  label: "Event Description",
                  isSecure: false,
                  color: const Color(0XFFEBF2F2),
                  width: 30,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("Event date"),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: Row(
                      children: const [
                        Icon(FontAwesomeIcons.calendar),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Event date",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      primary: const Color(0XFF368890),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Textform(
                  controller: venue,
                  suffix: FontAwesomeIcons.crosshairs,
                  icon: FontAwesomeIcons.mapMarkerAlt,
                  label: "Venue",
                  color: const Color(0XFFEBF2F2),
                ),
                const SizedBox(
                  height: 10,
                ),
                Textform(
                  controller: link,
                  icon: FontAwesomeIcons.link,
                  label: "Ticket link",
                  color: const Color(0XFFEBF2F2),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Event Conditions"),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                    children: List.generate(eventconditions.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 6.0, top: 10),
                    child: Elevatedbuttons(
                      sidecolor: Colors.white,
                      width: size.width * 0.4,
                      coloring: const Color(0XFF368890),
                      text: eventconditions[index]['consitions'],
                      textColor: const Color(0XFFFFFFFF),
                    ),
                  );
                })),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Icon(Icons.visibility),
                    SizedBox(
                      width: 10,
                    ),
                    AutoSizeText("Event Privacy"),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Elevatedbuttons(
                      sidecolor: Colors.white,
                      textColor: const Color(0XFFFFFFFF),
                      text: "Public",
                      coloring: const Color(0XFF368890),
                      width: size.width * double.infinity,
                      primary: const Color(0XFF368890),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    
                    Elevatedbuttons(
                      onpressed: (){},
                      sidecolor: Colors.black,
                      coloring: const Color(0XFFFFFFFF),
                      width: size.width * double.infinity,
                      text: "Private",
                      textColor: Colors.black,
                      primary: const Color(0XFFFFFFFF),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const AutoSizeText(
                  "This Event is public. Everyone on \n Event Spotter will be able to see this event \n details",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              const   Elevatedbutton(
                  text: "Create",
                  width: double.infinity,
                  coloring:  Color(0xFF304747),
                  textColor:   Color(0XFFFFFFFF),

                ),
                const SizedBox(
                  height: 10,
                ),
                 Elevatedbutton(
                  onpressed: (){},
                  textColor : const Color(0XFF74ABB0),
                  coloring:  Colors.white,
                  text: "Save as draft",
                  width: double.infinity,
                  primary:  Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Elevatedbuttons extends StatelessWidget {
  final String text;
  final Color? coloring;
  final Color? textColor;
  final VoidCallback? onpressed;
  final double width;
  final Color? primary;
  final Color ? sidecolor;

  const Elevatedbuttons({
    required this.text,
    Key? key,
    this.coloring,
    this.textColor,
    this.onpressed,
    this.width = 0, this.primary,  this.sidecolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration :  BoxDecoration(color: coloring,
      borderRadius: BorderRadius.circular(10),
     
      ),
      child: ElevatedButton(
        child: Text(
          text,
          style:  TextStyle(color: textColor, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          shape:  RoundedRectangleBorder(
              side:   BorderSide(color: sidecolor!),
             borderRadius:const  BorderRadius.all(Radius.circular(10))
            ),
         primary: primary,
        ),
        onPressed: onpressed,
      ),
    );
  }
}
