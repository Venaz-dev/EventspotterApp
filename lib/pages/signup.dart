import 'package:event_spotter/pages/signin.dart';
import 'package:event_spotter/widgets/downdecoration.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/updecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                                  createAccount();
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
                                    Navigator.of(context).push(
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

  createAccount() async {
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
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  dynamic doesntReturn() {
    // do nothing
  }
}