import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/getProfile.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/pages/followers.dart';
import 'package:event_spotter/pages/following.dart';
import 'package:event_spotter/pages/signin.dart';
import 'package:event_spotter/pages/landing.dart';
import 'package:event_spotter/widgets/profile/yourevents.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_spotter/widgets/topmenu.dart';

enum scrolling { personal, settings }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool iswitched = true;
  int index = 0;
  late SharedPreferences _sharedPreferences;
  Dio _dio = Dio();
  bool _isLoading = true;
  late Response response;
  late String _name;
  bool _isdisabled = true;
  final bool _emailinput = true;
  File? imagePath;
  final ImagePicker _picker = ImagePicker();
  late String _token;
  late String _email1;
  bool _isReadonly = true;
  late bool phonenumber;
  late bool profileprivate;
  var totalEvents;
  late GetProfile _getProfile;

  late int lenght;
  String url2 = "https://theeventspotter.com/api/logout";
  String profileprivateUrl =
      "https://theeventspotter.com/api/makeProfilePrivate";

  String getuser = "https://theeventspotter.com/api/profile";
  String editProfileUrl = "https://theeventspotter.com/api/edit-profile";
  String phonenumberprivateUrl =
      "https://theeventspotter.com/api/makeNoPrivate";

  String postProfilePicture =
      "https://theeventspotter.com/api/update-profile-picture";

  String MainUrl = "https://theeventspotter.com/";

  final TextEditingController _email = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();
  var city;
  var country;
  var profile_pic;
  var phone;
  bool directMessage = true;
  // ignore: prefer_typing_uninitialized_variables
  var address;
  final languages = ["English", "Spanish"];

  //Text Controllers

  scrolling widgetsscrolling = scrolling.personal;

  @override
  void initState() {
    getProfileDetails();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _phonenumber.dispose();
    _address.dispose();
    _city.dispose();
    _country.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);

        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 10.0, left: 10, top: 0, bottom: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _isLoading
                      ? Container(
                          // color: Colors.red,
                          margin: const EdgeInsets.only(top: 120),
                          height: size.height * 0.7,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: size.height * 0.65,
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      color: Color(0xFF3BADB7),
                                    ))),
                                //Log out
                                InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   _isLoading = true;
                                    // });
                                    LogoutapiCall();
                                    _sharedPreferences.clear();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LandingScreen()),
                                        (route) => false);
                                  },
                                  child: const Text(
                                    "Log out",
                                    style: TextStyle(
                                        color: Color(0xFfEB5757),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ]))
                      : SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 60.0, right: 10, left: 10, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  child: getwidgets(),
                                ),
                                //settings

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    // border: const Border(
                                    //     bottom: BorderSide(
                                    //         color: Color(0xFFE5E7EB),
                                    //         width: 1)),
                                  ),
                                  child: getOtherMenu(),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                //Log out
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    LogoutapiCall();
                                    _sharedPreferences.clear();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LandingScreen()),
                                        (route) => false);
                                  },
                                  child: const Text(
                                    "Log out",
                                    style: TextStyle(
                                        color: Color(0xFfEB5757),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  height: 80,
                                ),
                                Center(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: size.width * 0.5,
                                        child: const Image(
                                            image: AssetImage(
                                                "Assets/images/logo-text.png"))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Version 1.0.0",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF101010)),
                                    )
                                  ],
                                )),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              const Topmenu(title: "Settings"),
            ],
          )),
    ));
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('Camera'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      }),
                  ListTile(
                      leading: const Icon(Icons.filter),
                      title: const Text('Pick a file'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      }),
                  // ListTile(
                  //     leading: const Icon(Icons.camera),
                  //     title: const Text('video'),
                  //     onTap: () {
                  //       Navigator.of(context).pop();
                  //       _pickvideo(ImageSource.gallery);
                  //     }),
                ],
              ),
              onClosing: () {},
            ));
  }

  PostProfilePicture() async {
    String fileName = imagePath!.path.split('/').last;

    var file =
        await MultipartFile.fromFile(imagePath!.path, filename: fileName);
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    FormData formData = FormData.fromMap({
      'image': file,
    });
    response = await _dio.post(postProfilePicture, data: formData);
    try {
      if (response.data["success"] == true) {
        print(response.data);
        print("Data Send");

        showToaster("Profile Picture Updated");
      } else {
        print("Error while uploading picture");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
  }

  Future _pickvideo(ImageSource mediasource) async {
    final pickedFile = await _picker.pickVideo(source: mediasource);
    setState(() {
      imagePath = File(pickedFile!.path);
    });
    if (pickedFile == null) {
      return;
    }
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    setState(() {
      imagePath = File(pickedFile!.path);
    });
    print('object$imagePath');

    if (pickedFile == null) {
      print("null in picture");
      return;
    } else {
      PostProfilePicture();
      print("ssssssss");
    }
  }

  Settings(bool isSwitched, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
          activeColor: const Color(0xFF324748),
          //inactiveTrackColor: Colors.white
        ),
      ],
    );
  }

  container(Size size, int count, String textType, VoidCallback ontap) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: size.height * 0.06,
          width: size.width * 0.3,
          //width: size.width*0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: const Color(0XFFECF2F3),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                children: [
                  AutoSizeText(
                    count.toString(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF101010)),
                  ),
                  AutoSizeText(
                    textType,
                    style:
                        const TextStyle(color: Color(0xFF707070), fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getwidgets() {
    return settings();
    // switch (widgetsscrolling) {
    //   case scrolling.personal:
    //     return personaldetails();

    //   case scrolling.settings:
    //     return settings();
    // }
  }

  Widget getOtherMenu() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "OTHER MENU",
          style: TextStyle(
              color: Color(0xFF707070),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              "Privacy policy",
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF101010),
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff707070),
              size: 22.0,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              "Terms of service",
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF101010),
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff707070),
              size: 22.0,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              "Disclaimer",
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF101010),
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff707070),
              size: 22.0,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              "Cookies Policy",
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF101010),
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff707070),
              size: 22.0,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
    ));
  }

  Widget settings() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),

          // border: const Border(
          //     bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
          // boxShadow: const [
          //   BoxShadow(
          //       color: Colors.black12,
          //       spreadRadius: 2,
          //       blurRadius: 2,
          //       offset: Offset(
          //         0,
          //         0,
          //       )),
          // ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              // Settings(true, 'Recieve push notification'),
              // Settings(true, 'Allow direct messages'),
              //  Settings(false, 'Make your profile private'),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Recieve push notification",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF101010),
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: iswitched,
                    onChanged: (value) {
                      setState(() {
                        iswitched = value;
                      });
                    },
                    activeColor: const Color(0xFF3BADB7),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Allow direct messages",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF101010),
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: directMessage,
                    onChanged: (value) {
                      setState(() {
                        directMessage = value;
                      });
                    },
                    activeColor: const Color(0xFF3BADB7),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Make your profile private",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF101010),
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: profileprivate,
                    onChanged: (value) {
                      if (profileprivate == true) {
                        sendprofileprivate(0);
                      } else {
                        sendprofileprivate(1);
                      }
                      setState(() {
                        profileprivate = value;
                      });
                    },
                    activeColor: const Color(0xFF3BADB7),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Make your phone number private",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF101010),
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: phonenumber,
                    onChanged: (value) {
                      if (phonenumber == true) {
                        phonenumberpost(0);
                      } else {
                        phonenumberpost(1);
                      }
                      setState(() {
                        phonenumber = value;
                      });
                    },
                    activeColor: const Color(0xFF3BADB7),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  sendprofileprivate(int i) async {
    _dio.options.headers["Authorization"] = "Bearer ${_token}";

    FormData formData = FormData.fromMap({
      "profile_private": i,
    });

    response = await _dio.post(profileprivateUrl, data: formData);
    if (response.statusCode == 200) {
      showToaster("Changes Saved");
    } else {
      print("Error");
    }
  }

  phonenumberpost(int i) async {
    _dio.options.headers["Authorization"] = "Bearer ${_token}";

    FormData formData = FormData.fromMap({
      "isPrivate": i,
    });

    response = await _dio.post(phonenumberprivateUrl, data: formData);
    if (response.statusCode == 200) {
      print(response.data);
      showToaster("Changes Saved");
    } else {
      print("Error");
    }
  }

  LogoutapiCall() async {
    //_sharedPreferences = await SharedPreferences.getInstance();

    print(_sharedPreferences.getString('accessToken'));
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    response = await _dio.get(url2);
    print(response.data.toString());
    if (response.data["success"] == true) {
      showToaster('Logged out');

      _isLoading = false;
    } else {
      print("error with logout");
      showToaster('Error!');
    }
  }

  getProfileDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    print("Inside the Get Event function");
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      Response response = await _dio.get(getuser);
      if (response.data["data"]["events"].length > 0) {
        totalEvents = response.data["data"]["events"].length;
      } else {
        totalEvents = 0;
      }
      if (response.statusCode == 200) {
        _getProfile = GetProfile.fromJson(response.data);
        if (response.data['data']['mobile_is_private'].toString() == '0') {
          phonenumber = false;
        } else {
          phonenumber = true;
        }
        if (response.data['data']['profile_private'].toString() == '0') {
          profileprivate = false;
        } else {
          profileprivate = true;
        }
        if (response.data["data"]["address"] != null) {
          _city.text = city = response.data["data"]["address"]["city"] ?? '';
          _country.text =
              country = response.data["data"]["address"]["country"] ?? '';
          _address.text =
              address = response.data["data"]["address"]["address"] ?? '';
        } else {
          city = "not available ";
          country = "not available ";
          address = "not available ";
        }
        if (response.data["data"]['phone_number'] != null) {
          _phonenumber.text = phone = response.data["data"]['phone_number'];
        } else {
          phone = "not available";
        }
        if (response.data["data"]["profile_picture"] != null) {
          profile_pic =
              MainUrl + response.data["data"]["profile_picture"]["image"];
        } else {
          profile_pic =
              "https://imgr.search.brave.com/agcf_54hKLs35Jr3YaOMycn250z6b8N8p1HEYsRqi8Q/fit/980/980/ce/1/aHR0cDovL2Nkbi5v/bmxpbmV3ZWJmb250/cy5jb20vc3ZnL2lt/Z18yMTgwOTAucG5n";
        }

        // print(MainUrl + _eventsModel.data[0].events.user.profilePicture.image);
      }
    } catch (e) {
      print(e.toString() + "Catch");
    } finally {
      _isLoading = false;
    }
    setState(() {});
  }
}
