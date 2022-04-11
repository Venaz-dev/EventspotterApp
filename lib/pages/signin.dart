import 'package:event_spotter/models/login_model.dart';
import 'package:event_spotter/pages/dashboard.dart';
import 'package:event_spotter/pages/forgetpassword.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
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
  final Dio _dio = Dio();
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 0, left: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(children: const [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xff101010),
                        size: 22.0,
                      ),
                      Text(
                        "Back",
                        style:
                            TextStyle(color: Color(0xff222222), fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ]),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 30, left: 30),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Color(0xff101010),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: const Color(0xffE5E5E5))),
                        child: Textform(
                          label: 'Enter your email',
                          isreadonly: false,
                          isSecure: false,
                          keyboard: TextInputType.emailAddress,
                          controller: _email,
                          color: Colors.white,
                        )),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: const Color(0xffE5E5E5))),
                        child: Textform(
                          isreadonly: false,
                          isSecure: _issecure,
                          label: 'Enter your password',
                          controller: _password,
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
                          color: Colors.white,
                        )),
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
                    SizedBox(
                      height: size.height * 0.27,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (!_isLoading)
                      Elevatedbutton(
                        primary: Color(0xFF3BADB7),
                        textColor: Colors.white,
                        width: double.infinity,
                        text: "Login",

                        // coloring: const Color(0xFF304747),
                        onpressed: () {
                          login();
                        },
                      ),
                    if (_isLoading)
                      const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFF3BADB7))),
                    const SizedBox(
                      height: 25,
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
                            // border: Border(
                            //     top: BorderSide(color: Colors.white),
                            //     left: BorderSide(color: Colors.white),
                            //     right: BorderSide(color: Colors.white),
                            //     bottom: BorderSide(color: Colors.black54)),
                            ),
                        child: const AutoSizeText(
                          "Forgot password?",
                          style:
                              TextStyle(fontSize: 16, color: Color(0XFF808080)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (!_isLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          child: const Text(
                            "Don't have an account?",
                            style: TextStyle(
                                color: Color(0XFF314648),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          // style: ElevatedButton.styleFrom(
                          //   // side: const BorderSide(color: Colors.black),
                          //   // shape: const RoundedRectangleBorder(
                          //   //     borderRadius:
                          //   //         BorderRadius.all(Radius.circular(10))),
                          //   primary: Colors.white,
                          // ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Signup()));
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

  login() async {
    if (_email.text.isEmpty && !RegExp(r'\S+@\S+\.\S+').hasMatch(_email.text)) {
      _isEmailValid = false;
      setState(() {});
    } else {
      _isEmailValid = true;
    }
    if (_password.text.isEmpty) {
      _isPasswordValid = false;
      setState(() {});
      return;
    } else {
      _isPasswordValid = true;
    }
    setState(() {
      _isLoading = true;
    });
    FormData formData = FormData.fromMap({
      "email": _email.text,
      "password": _password.text,
    });
    try {
      await _dio.post(url, data: formData).then((value) {
        if (value.statusCode == 500) {
          _isEverythingValid = false;
          return;
        } else
          _loginResponse = LoginModel.fromJson(value.data);
      });

      if (_isEverythingValid) {
        showToaster('Welcome  ${_loginResponse.user.name}');

        await getInitializedSharedPref();
        await _sharedPreferences.setString('name', _loginResponse.user.name);
        await _sharedPreferences.setString(
            'id', _loginResponse.user.id.toString());
        await _sharedPreferences.setString('email', _loginResponse.user.email);
        await _sharedPreferences.setString(
            'profilePicture', _loginResponse.user.profilePicture!.image);
        await _sharedPreferences.setString('accessToken', _loginResponse.token);
        // await _sharedPreferences.setString(
        //     'Profile_picture', _loginResponse.user.profilePicture.image);
        await _sharedPreferences.setString(
            'phone', _loginResponse.user.phoneNumber);
        String _id = _sharedPreferences.getString('id')!;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Dashboard(
                  id: _id,
                )));
      } else {
        showToaster('Invalid Credentials');
      }
    } catch (error) {
      print(error);
      showToaster('Invalid Credentials');
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  getInitializedSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    if (_sharedPreferences.containsKey('email')) {
      String? _id = _sharedPreferences.getString('id');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Dashboard(
                id: _id!,
              )));
    }
  }
}
