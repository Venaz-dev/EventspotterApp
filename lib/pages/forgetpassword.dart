import 'package:event_spotter/widgets/downdecoration.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/updecoration.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _forgetPassword = TextEditingController();
    return GestureDetector(
      onTap: ()
      {
         FocusScopeNode currentfocus = FocusScope.of(context);

            if (!currentfocus.hasPrimaryFocus) {
              currentfocus.unfocus();
            }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Updecoration(size: size),
                
                Center(child: Image.asset("Assets/images/logo.png")),
                const SizedBox(
                  height: 20,
                ),
                const AutoSizeText(
                  "Forget Password",
                  style: TextStyle(color: Color(0XFF6BC1C9), fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Textform(
                  controller: _forgetPassword,
                  isSecure: false,
                  keyboard: TextInputType.emailAddress,
                  icon: Icons.email,
                  color: const Color(0XFFEBF2F2),
                  label: "Email",
                  width: size.width * 0.06,
                ),
                const SizedBox(
                  height: 30,
                ),
                Elevatedbutton(
                  width: double.infinity,
                  text: "Reset Password",
                  textColor: Colors.white,
                  coloring: const Color(0xFF304747),
                  primary: const Color(0xFF304747),
                  onpressed: () {
    //dialoguebox( "re" , context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Elevatedbutton(
                  width: double.infinity,
                  text: "or Login instead",
                  textColor: Colors.black,
                  coloring: Colors.white,
                  primary: Colors.white,
                  onpressed: () {
                    Navigator.of(context).pop();
                  },
                ),

                Downdecoration(size: size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //  dialoguebox(String text , BuildContext context)
  // {
  //    AlertDialog(

  //     content: Text(text),
  //     actions: [
  //       TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("Ok"))
  //     ],

  //);
}
