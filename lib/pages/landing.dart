import 'package:event_spotter/models/login_model.dart';
import 'package:event_spotter/pages/dashboard.dart';
import 'package:event_spotter/pages/forgetpassword.dart';
import 'package:event_spotter/pages/signup.dart';
import 'package:event_spotter/pages/signin.dart';
import 'package:event_spotter/pallets.dart';
import 'package:event_spotter/widgets/downdecoration.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:event_spotter/widgets/updecoration.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    getInitializedSharedPref();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff101010),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentfocus = FocusScope.of(context);

            if (!currentfocus.hasPrimaryFocus) {
              currentfocus.unfocus();
            }
          },
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Container(
                      width: 190,
                      child: new Image(
                          image: new AssetImage('Assets/images/logo_dark.png')),
                    ),
                  )),
              Container(
                  height: size.height * 0.40,
                  width: size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("Assets/images/launch_image.png")))),
              Padding(
                // child:  Text("Explore events around you.",
                //             style: TextStyle(color: Colors.white, fontSize: 28),
                //             textAlign: TextAlign.center)
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Text(
                        "Explore events around you.",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (!_isLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: const Text(
                            "Create an account",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            primary: Color(0xff3BADB7),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()),
                            );
                          },
                        ),
                      ),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator()),
                    const SizedBox(
                      height: 20,
                    ),
                    if (!_isLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                                color: Color(0XFF314648),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            primary: Color(0xffC8FBFF),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                        ),
                      ),
                    if (_isLoading) Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getInitializedSharedPref() async {}
}
