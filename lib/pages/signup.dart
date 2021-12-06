import 'package:event_spotter/pages/signin.dart';
import 'package:event_spotter/widgets/downdecoration.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:event_spotter/widgets/updecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Dio _dio = Dio();
  bool _isLoading = false;

  String Url = "https://theeventspotter.com/api/create-account";
  late SharedPreferences _sharedPreferences;
  bool _isPSecure = true;
  bool _isCPSecure = true;

  bool _isPHSecure = true;

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  void dispose() {
    _fullname.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _key,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GestureDetector(
                  onTap: () {
                    FocusScopeNode currentfocus = FocusScope.of(context);

                    if (!currentfocus.hasPrimaryFocus) {
                      currentfocus.unfocus();
                    }
                  },
                  child: ListView(
                    children: [
                      Updecoration(size: size),
                      Center(
                        child: Container(
                          height: size.height * 0.2,
                          width: size.width * 0.6,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("Assets/images/logo.png"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Column(
                            children: [
                              Textform(
                                isSecure: false,
                                isreadonly: false,
                                label: 'Full Name',
                                controller: _fullname,
                                icon: Icons.person,
                                color: const Color(0XFFEBF2F2),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your name";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Textform(
                                isreadonly: false,
                                isSecure: false,
                                label: 'Email',
                                controller: _email,
                                icon: Icons.email,
                                color: const Color(0XFFEBF2F2),
                                validator: (email) {
                                  if (!RegExp(r'\S+@\S+\.\S+')
                                      .hasMatch(email!)) {
                                    return "Please enter a valid email address";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Textform(
                                isSecure: _isPSecure,
                                isreadonly: false,
                                color: const Color(0XFFEBF2F2),
                                label: 'Password',
                                controller: _password,
                                icon: Icons.lock,
                                suffix: _isPSecure == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onPressed: () {
                                  setState(() {
                                    if (_isPSecure) {
                                      _isPSecure = false;
                                    } else {
                                      _isPSecure = true;
                                    }
                                  });
                                },
                                validator: (password) {
                                  if (password!.isEmpty) {
                                    return 'Please enter the password';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Textform(
                                isSecure: _isCPSecure,
                                color: const Color(0XFFEBF2F2),
                                label: 'Confirm Password',
                                isreadonly: false,
                                controller: _confirmPassword,
                                icon: Icons.lock,
                                suffix: _isCPSecure == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onPressed: () {
                                  setState(() {
                                    if (_isCPSecure) {
                                      _isCPSecure = false;
                                    } else {
                                      _isCPSecure = true;
                                    }
                                  });
                                },
                                validator: (confirmPassword) {
                                  if (confirmPassword!.isEmpty) {
                                    return "Please confirm your password";
                                  } else if (_password.text !=
                                      confirmPassword) {
                                    return 'Password do not match';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Textform(
                                keyboard: TextInputType.number,
                                color: const Color(0XFFEBF2F2),
                                label: 'Phone Number',
                                controller: _phoneNumber,
                                isreadonly: false,
                                icon: Icons.phone_android,
                                isSecure: _isPHSecure,
                                suffix: _isPHSecure == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onPressed: () {
                                  setState(() {
                                    if (_isPHSecure) {
                                      _isPHSecure = false;
                                    } else {
                                      _isPHSecure = true;
                                    }
                                  });
                                },
                                validator: (phonenumber) {
                                  if (phonenumber!.isEmpty) {
                                    return 'Please enter your number';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              Elevatedbutton(
                                primary: const Color(0xFF304747),
                                textColor: Colors.white,
                                width: double.infinity,
                                text: "Signup",
                                coloring: const Color(0xFF304747),
                                onpressed: () {
                                  final form = _key.currentState!;
                                  if (!form.validate()) {
                                    return;
                                  }

                                  acceptancenote(context, size);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  child: const Text(
                                    "Already have an account? sigin",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(color: Colors.black),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    primary: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const FittedBox(
                                child: AutoSizeText(
                                    "By signing up you have to agree with terms and conditions"),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
          bottomNavigationBar: Downdecoration(size: size),
        ),
      ),
    );
  }

  Future<dynamic> acceptancenote(BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: size.height * 0.35,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Terms and Conditions",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("By singin up or logging in, i accept the",
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        termsandcondtions();
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Color(0XFF368890)))),
                          child: const Text(
                            "EventSpotter Term of Services "
                            " ",
                            style: TextStyle(
                                color: Color(0XFF368890), fontSize: 17),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(" and have read the ",
                        style: TextStyle(fontSize: 17)),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        privacypoilicy();
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Color(0XFF368890)))),
                          child: const Text("Privacy Policy",
                              style: TextStyle(
                                color: Color(0XFF368890),
                                fontSize: 17,
                              ))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        createAccount();
                      },
                      child: const Text("Accept"),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0XFF368890)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black38),
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  privacypoilicy() async {
    const url = 'https://theeventspotter.com/privacy_policy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  termsandcondtions() async {
    const url = 'https://theeventspotter.com/terms_of_service';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  createAccount() async {
    Navigator.pop(context);

    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    // ignore: unnecessary_new
    FormData formData = new FormData.fromMap({
      "name": _fullname.text,
      "phone_number": _phoneNumber.text,
      "email": _email.text,
      "confirm_password": _confirmPassword.text,
      "password": _password.text
    });
    Response response = await _dio.post(Url, data: formData);
    if (response.data['access_token'].toString().isEmpty) {
    } else {
      print("hello g");
      showToaster('Account created successfully');
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  dynamic doesntReturn() {
    // do nothing
  }
}
