import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/models/getUserFollowingStatusModel.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Eventposterprofile extends StatefulWidget {
  int id;
  Eventposterprofile({Key? key, required this.id}) : super(key: key);

  @override
  _EventposterprofileState createState() => _EventposterprofileState();
}

class _EventposterprofileState extends State<Eventposterprofile> {
  bool isloading = false;
  bool isfollow = false;
  String? value;
  late SharedPreferences _sharedPreferences;
  Dio _dio = Dio();
  late String gg;
  late String _token;
  bool datanull = true;
  var Address;
  var city;
  var country;
  var primaryid;
  late String pending;
  bool _isLoading = true;
  final languages = ["English", "Spanish"];
  String MainUrl = "https://theeventspotter.com/";
  String GetUSerStatusUrl =
      "https://theeventspotter.com/api/getUserFollowingStatus";
  String FollowingUrl = "https://theeventspotter.com/api/following";
  String unfollow = "https://theeventspotter.com/api/unfollow";
  late GetUserFollowingStatus _getUserFollowingStatus;
  late Response response;
  late String _id1;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUserFollowingStatus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 30, left: 30, bottom: 20),
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              //background color of box
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 2.0,
                                  offset: Offset(
                                    0,
                                    0,
                                  ))
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Profile",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  children: [
                                    Container(
                                      height: size.height * 0.12,
                                      width: size.width * 0.12,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  MainUrl +
                                                      _getUserFollowingStatus
                                                          .data
                                                          .profilePicture!
                                                          .image),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              _getUserFollowingStatus.data.name,
                                              style: const TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            button(),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                                Expanded(
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        container(
                                            size,
                                            _getUserFollowingStatus
                                                .data.followers.length,
                                            'Followers'),
                                        container(
                                            size,
                                            _getUserFollowingStatus
                                                .data.following.length,
                                            'Following'),
                                        container(
                                            size,
                                            _getUserFollowingStatus
                                                .data.events.length,
                                            'Events'),
                                      ],
                                    ),
                                  ),
                                ),

                                // ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        personaldetails(),
                        const SizedBox(
                          height: 30,
                        ),

                        //settings
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  container(Size size, int count, String textType) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10.0),
      child: Container(
        height: size.height * 0.06,
        //width: size.width*0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0XFFECF2F3),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              children: [
                AutoSizeText(
                  count.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                AutoSizeText(
                  textType,
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget personaldetails() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(
                  0,
                  0,
                )),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Row(
                children: [
                  Elevatedbuttons(
                    sidecolor: Colors.transparent,
                    text: "Personal Details",
                    textColor: Colors.white,
                    coloring: const Color(0XFF38888F),
                    onpressed: () {},
                    primary: const Color(0XFF38888F),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Email"),
            const SizedBox(height: 10),
            Textform(
              label: _getUserFollowingStatus.data.email,
              controller: _email,
              isSecure: false,
              color: const Color(0XFFEBF2F2),
            ),
            const SizedBox(
              height: 20,
            ),
            _getUserFollowingStatus.data.mobileIsPrivate == "0"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Phone number"),
                      const SizedBox(height: 10),
                      Textform(
                        label: _getUserFollowingStatus.data.phoneNumber,
                        controller: _phonenumber,
                        isSecure: false,
                        color: const Color(0XFFEBF2F2),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : SizedBox(),
            const Text("Address"),
            const SizedBox(height: 10),
            Textform(
              label: Address,
              controller: _address,
              isSecure: false,
              color: const Color(0XFFEBF2F2),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("City"),
            const SizedBox(height: 10),
            Textform(
              label: city,
              controller: _city,
              isSecure: false,
              color: const Color(0XFFEBF2F2),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Country"),
            const SizedBox(height: 10),
            Textform(
              label: country,
              controller: _country,
              isSecure: false,
              color: const Color(0XFFEBF2F2),
            ),
          ],
        ),
      ),
    );
  }

  getUserFollowingStatus() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _id1 = _sharedPreferences.getString('id')!;
    FormData formData = new FormData.fromMap({
      "following_id": widget.id,
    });

    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    response = await _dio.post(GetUSerStatusUrl, data: formData);
    print(response.data);
    {
      if (response.data["success"] == true) {
        _getUserFollowingStatus =
            GetUserFollowingStatus.fromJson(response.data);
        if (response.data["data"]["address"] != null) {
          Address = response.data["data"]["address"]["address"] ?? "";
          city = response.data["data"]["address"]["city"] ?? "";
          country = response.data["data"]["address"]["country"] ?? "";
        } else {
          Address = "not available";
          city = "not available";
          country = "not available";
        }
        if (response.data["status"] == "Following") {
          primaryid = response.data["data"]["id"];
        }
        setState(() {
          pending = response.data["status"];
          print(pending);
          _isLoading = false;
        });
      } else {
        print("error while getting the status of user");
        pending = "error";
        _isLoading = false;
      }
    }
  }

  button() {
    if (pending != "error") {
      if (pending == "Pending") {
        gg = "pending";
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton(
            onPressed: () {
              print("clicking /////////////////");
              following();
              setState(() {
                gg = "Follow";
                pending = "nothing";
                isfollow = true;
              });
            },
            style: ElevatedButton.styleFrom(
                primary: isfollow ? Colors.blue : const Color(0XFF9CC4C6)),
            child: Text(gg),
          ),
        );
      } else if (pending == "nothing") {
        gg = "Follow";
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton(
              onPressed: () {
                print("clicking /////////////////");
                following();
                //following();
                setState(() {
                  gg = "pending";
                  pending = "Pending";
                });
              },
              style: ElevatedButton.styleFrom(
                  primary: isfollow ? Colors.blue : const Color(0XFF9CC4C6)),
              child: Text(gg)),
        );
      } else if (pending == "Following") {
        gg = "Un-Follow";
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton(
              onPressed: () {
                postUnfollow();
                setState(() {
                  isfollow = !isfollow;
                  gg = "Follow";
                  pending = "nothing";
                });
              },
              style: ElevatedButton.styleFrom(
                  primary: isfollow ? Colors.blue : const Color(0XFF9CC4C6)),
              child: Text(gg)),
        );
      }
    } else {
      return const SizedBox();
    }
  }

  following() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    FormData formData = new FormData.fromMap({
      "following_id": widget.id,
    });
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      response = await _dio.post(FollowingUrl, data: formData);
      print(response.data);
      {
        if (response.data["success"] == true) {
          print(response.data);
          showToaster(response.data["message"]);
        } else {
          print("error while sending request");
          pending = "error";
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  postUnfollow() async {
    late String id2;
    for (int i = 0; i < _getUserFollowingStatus.data.followers.length; i++) {
      if (_id1 == _getUserFollowingStatus.data.followers[i].followerId) {
        id2 = _getUserFollowingStatus.data.followers[i].followingId;
      }
    }
    print(id2);
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    FormData formData = FormData.fromMap({"id": id2});
    try {
      _dio.options.headers["Authorization"] = "Bearer ${_token}";
      response = await _dio.post(unfollow, data: formData);
      print(response.data);
      {
        if (response.data["success"] == true) {
          print(response.data);
          showToaster(response.data["message"]);
        } else {
          print("error while sending request");
          pending = "error";
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }
}
