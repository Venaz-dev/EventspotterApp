import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/getProfile.dart';
import 'package:event_spotter/pages/settings.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/pages/followers.dart';
import 'package:event_spotter/pages/following.dart';
import 'package:event_spotter/pages/signin.dart';
import 'package:event_spotter/widgets/profile/yourevents.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum scrolling { personal, settings }

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  bool _isReadonly = false;
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
                      ? SizedBox(
                          height: size.height * 0.9,
                          child: const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0XFF3BADB7))))
                      : SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 80.0, right: 10, left: 10, bottom: 20),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      //background color of box
                                      // BoxShadow(
                                      //     color: Colors.black12,
                                      //     blurRadius: 2,
                                      //     spreadRadius: 2.0,
                                      //     offset: Offset(
                                      //       0,
                                      //       0,
                                      //     ))
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0,
                                        right: 0,
                                        left: 0,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        // const Align(
                                        //   alignment: Alignment.topLeft,
                                        //   child: Text(
                                        //     "Profile",
                                        //     style: TextStyle(
                                        //         fontWeight: FontWeight.w500,
                                        //         fontSize: 17),
                                        //   ),
                                        // ),

                                        SizedBox(
                                          height: size.height * 0.006,
                                        ),

                                        Column(
                                          children: [
                                            imagePath == null
                                                ? SizedBox(
                                                    height: size.height * 0.1,
                                                    width: size.width * 0.23,
                                                    child: Stack(children: [
                                                      Container(
                                                        height:
                                                            size.width * 0.23,
                                                        width:
                                                            size.width * 0.23,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        300.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  profile_pic,
                                                              fit: BoxFit.cover,
                                                            )),
                                                      ),
                                                      Positioned(
                                                          top: 0,
                                                          left: 0,
                                                          child: SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              width:
                                                                  size.width *
                                                                      0.23,
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              300.0),
                                                                  child: Container(
                                                                      decoration: const BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            103,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                      ),
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            _selectPhoto();
                                                                          },
                                                                          child: const Center(
                                                                              child: Text(
                                                                            "Change",
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 16),
                                                                          )))))))
                                                    ]),
                                                  )
                                                : SizedBox(
                                                    height: size.height * 0.1,
                                                    width: size.width * 0.2,
                                                    child: Stack(children: [
                                                      Container(
                                                        height:
                                                            size.width * 0.23,
                                                        width:
                                                            size.width * 0.23,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      300.0),
                                                          child: Image.file(
                                                            imagePath!,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: 0,
                                                          left: 0,
                                                          child: SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              width:
                                                                  size.width *
                                                                      0.23,
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              300.0),
                                                                  child: Container(
                                                                      decoration: const BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            103,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                      ),
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            _selectPhoto();
                                                                          },
                                                                          child: const Center(
                                                                              child: Text(
                                                                            "Change",
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 16),
                                                                          )))))))
                                                    ]),
                                                  ),
                                          ],
                                        ),

                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  child: getwidgets(),
                                ),
                                //settings
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFE5E7EB), width: 1))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: const [
                          Spacer(),
                          Text(
                            "Edit profile",
                            style: TextStyle(
                                color: Color(0xff222222),
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                        ],
                      ),
                    )),
              ),
              Positioned(
                  top: 0.0,
                  left: 20.0,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff101010),
                                size: 22.0,
                              ),
                              Text(
                                "Back",
                                style: TextStyle(
                                    color: Color(0xff222222), fontSize: 16),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          )))),
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
    return personaldetails();
    // switch (widgetsscrolling) {
    //   case scrolling.personal:
    //     return personaldetails();

    //   case scrolling.settings:
    //     return settings();
    // }
  }

  Widget personaldetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Email Address"),
            const SizedBox(height: 10),
            Textform(
              isreadonly: _emailinput,
              label: _getProfile.data.email,
              controller: _email,
              isSecure: false,
              color: const Color(0XFFf0F0F0),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Phone number"),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: const Color(0xffE5E5E5))),
                child: Textform(
                  isreadonly: _isReadonly,
                  label: phone,
                  controller: _phonenumber,
                  isSecure: false,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 20,
            ),
            const Text("Address"),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: const Color(0xffE5E5E5))),
                child: Textform(
                  isreadonly: _isReadonly,
                  label: address,
                  controller: _address,
                  isSecure: false,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 20,
            ),
            const Text("City"),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: const Color(0xffE5E5E5))),
                child: Textform(
                  isreadonly: _isReadonly,
                  label: city,
                  controller: _city,
                  isSecure: false,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 20,
            ),
            const Text("Country"),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: const Color(0xffE5E5E5))),
                child: Textform(
                  isreadonly: _isReadonly,
                  label: country,
                  controller: _country,
                  isSecure: false,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Elevatedbuttons(
                sidecolor: Colors.transparent,
                text: _isReadonly ? "Edit Details" : "Update profile",
                textColor: Colors.white,
                coloring: const Color(0XFF3BADB7),
                primary: const Color(0XFF3BADB7),
                onpressed: () {
                  setState(() {
                    _isdisabled = !_isdisabled;
                    _isReadonly = !_isReadonly;
                  });
                  if (_isReadonly == true) {
                    showToaster("Changes Saved");

                    editProfile();
                  } else {
                    showToaster("You Can Now Edit Profile");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  editProfile() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _name = _sharedPreferences.getString('name')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    FormData formData = FormData.fromMap({
      "name": _name,
      "phoneNumber": _phonenumber.text,
      "email": _getProfile.data.email,
      "address": _address.text,
      "city": _city.text,
      "country": _country.text
    });
    try {
      response = await _dio.post(editProfileUrl, data: formData);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print("Data saved ");
        city = _city.text;
        print(response.data);
        country = _country.text;
        address = _address.text;
        phone = _phonenumber.text;
      } else {
        print(response.data);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
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
