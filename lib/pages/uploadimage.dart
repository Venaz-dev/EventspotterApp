import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/smallButton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Uploadimage extends StatelessWidget {
  const Uploadimage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _snapdescription = TextEditingController();
    TextEditingController _names = TextEditingController();

    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);

        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
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
            size: size.height * 0.06,
            icon: FontAwesomeIcons.arrowLeft,
            onpressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 40.0, left: 40, top: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: size.height * 0.22,
                      child: Image.asset('Assets/images/upload.jpeg')),
                  const SizedBox(
                    height: 10,
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
                       
                      }),
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Textform(
              label: "Snap Description",
              controller: _snapdescription,
              color: const Color(0XFFEBF2F2),
            ),
            const SizedBox(
              height: 20,
            ),
            const AutoSizeText(
              "Tag People in Snap",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Textform(
                label: "Write Names",
                isSecure: false,
                maxlines: 2,
                controller: _snapdescription,
                color: const Color(0XFFEBF2F2),
                width: size.width * 0.1),
            const SizedBox(
              height: 20,
            ),
            Elevatedbutton(
                primary: const Color(0xFF304747),
                text: "Upload",
                width: double.infinity,
                coloring: const Color(0xFF304747),
                onpressed: () {
                 
                }),
          ]),
        ),
      ),
    );
  }
}
