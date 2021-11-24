import 'package:event_spotter/models/login_model.dart';
import 'package:event_spotter/pages/dashboard.dart';
import 'package:event_spotter/pages/forgetpassword.dart';
import 'package:event_spotter/pages/signup.dart';
import 'package:event_spotter/pallets.dart';
import 'package:event_spotter/widgets/downdecoration.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';

import 'package:event_spotter/widgets/updecoration.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  Dio _dio = Dio();
  late Response response;
  late SharedPreferences _sharedPreferences;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isEverythingValid = true;
  bool _issecure = true;
  bool _isLoading = false;
  String url = "https://theeventspotter.com/api/login";
  String url2 = "https://theeventspotter.com/api/logged-in";
  late LoginModel _loginResponse;
  @override
  void initState() {
    getInitializedSharedPref();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentfocus = FocusScope.of(context);

            if (!currentfocus.hasPrimaryFocus) {
              currentfocus.unfocus();
            }
          },
          child: ListView(
            children: [
              Updecoration(size: size),
              Image(
                image: const AssetImage('Assets/images/welcome.png'),
                height: size.height * 0.1,
              ),
              const Center(
                  child: Text(
                "Explore events around you",
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0XFF364351),
                    fontWeight: FontWeight.w500),
              )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                  height: size.height * 0.16,
                  width: size.width * 0.3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/images/logo.png")))),
              Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sign In",
                          style:
                              TextStyle(color: Color(0XFF6BC1C9), fontSize: 30),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Textform(
                      label: 'Email',
                      isSecure: false,
                      keyboard: TextInputType.emailAddress,
                      controller: _email,
                      icon: Icons.email,
                      color: const Color(0XFFEBF2F2),
                    ),
                    !_isEmailValid
                        ? const SizedBox(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Email is not valid",
                                style: errorTextStyle,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 15,
                          ),
                    Textform(
                      isSecure: _issecure,
                      label: 'Password',
                      controller: _password,
                      icon: Icons.lock,
                      suffix: _issecure == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onPressed: () {
                        setState(() {
                          if (_issecure) {
                            _issecure = false;
                          } else {
                            _issecure = true;
                          }
                        });
                      },
                      color: const Color(0XFFEBF2F2),
                    ),
                    !_isPasswordValid
                        ? const SizedBox(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Password is not correct",
                                style: errorTextStyle,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 15,
                          ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Forgetpassword()));
                      },
                      child: Container(
                        height: size.height * 0.04,
                        width: size.width * 0.4,
                        decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.white),
                              left: BorderSide(color: Colors.white),
                              right: BorderSide(color: Colors.white),
                              bottom: BorderSide(color: Colors.black54)),
                        ),
                        child: const AutoSizeText(
                          "Forgot password?",
                          style:
                              TextStyle(fontSize: 19, color: Color(0XFF74ABB0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (!_isLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            primary: const Color(0xFF304747),
                          ),
                          onPressed: () {
                            login();
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
                            "Don't have an account? Sign Up",
                            style: TextStyle(
                                color: Color(0XFF314648),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Singup()));
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
        bottomNavigationBar: Downdecoration(size: size),
      ),
    );
  }

  login() async {
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(_email.text)) {
      setState(() {
        _isEmailValid = false;
      });
    } else if (_email.text.isEmpty) {
      setState(() {
        _isEmailValid = false;
      });
    } else {
      setState(() {
        _isEmailValid = true;
      });
    }
    if (_password.text.isEmpty) {
      setState(() {
        _isPasswordValid = false;
      });
      return;
    } else {
      setState(() {
        _isPasswordValid = true;
      });
    }
    setState(() {
      _isLoading = true;
    });
    // ignore: unnecessary_new
    FormData formData = new FormData.fromMap({
      "email": _email.text,
      "password": _password.text,
    });
    try {
      await _dio.post(url, data: formData).then((value) {
        if (value.data['status'] == false) _isEverythingValid = false;
        _loginResponse = LoginModel.fromJson(value.data);
      });

      if (_isEverythingValid) {
        showToaster('Welcome  ${_loginResponse.user.name}');

        getInitializedSharedPref();
        await _sharedPreferences.setString('name', _loginResponse.user.name);
        await _sharedPreferences.setString('email', _loginResponse.user.email);
        await _sharedPreferences.setString('accessToken', _loginResponse.token);
        await _sharedPreferences.setString('Profile_picture', _loginResponse.user.profilePicture.image);
        await _sharedPreferences.setString('phone', _loginResponse.user.phoneNumber);


        _dio.options.headers["Authorization"] =
            "Bearer ${_loginResponse.token}";
        response = await _dio.get(url2);
        print(response.data.toString());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    } catch (error) {
      showToaster('Invalid Credentials');
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  getInitializedSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.containsKey('email')) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Dashboard()));
    }
  }
}
