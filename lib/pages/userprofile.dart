import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/getUserFollowingStatusModel.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:event_spotter/widgets/topmenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Color(0xFF3BADB7),
                    ))
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 65.0,
                              right: size.width * 0.03,
                              left: size.width * 0.03,
                              bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),

                                      FittedBox(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: size.width * 0.20,
                                              width: size.width * 0.20,
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
                                              width: 10,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.4,
                                                  child: AutoSizeText(
                                                    _getUserFollowingStatus
                                                        .data.name,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF101010),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    maxFontSize: 20,
                                                    minFontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                button(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        child: FittedBox(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFF0F0F0))),
                                              padding: EdgeInsets.all(17),
                                              child: SizedBox(
                                                  height: 40,
                                                  child: IntrinsicHeight(
                                                      child: Row(
                                                    children: [
                                                      container(
                                                          size,
                                                          _getUserFollowingStatus
                                                              .data
                                                              .followers
                                                              .length,
                                                          'Followers'),
                                                      const VerticalDivider(
                                                          thickness: 1,
                                                          color: Color(
                                                              0xFFAfafaf)),
                                                      container(
                                                          size,
                                                          _getUserFollowingStatus
                                                              .data
                                                              .following
                                                              .length,
                                                          'Following'),
                                                      const VerticalDivider(
                                                          thickness: 1,
                                                          color: Color(
                                                              0xFFAfafaf)),
                                                      container(
                                                          size,
                                                          _getUserFollowingStatus
                                                              .data
                                                              .events
                                                              .length,
                                                          'Events'),
                                                    ],
                                                  )))),
                                        ),
                                      ),

                                      // ),
                                    ],
                                  ),
                                ),
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
              _isLoading
                  ? const Topmenu(title: "")
                  : Topmenu(title: _getUserFollowingStatus.data.name),
              // _isLoading
              //     ? SizedBox()
              //     : Positioned(
              //         bottom: size.height * 0.05,
              //         right: 20.0,
              //         child: GestureDetector(
              //             onTap: () {
              //               Navigator.pop(context);
              //             },
              //             child: Container(
              //               height: 40,
              //               width: 102,
              //               decoration: const BoxDecoration(
              //                   image: DecorationImage(
              //                       image: AssetImage(
              //                           "Assets/icons/start-chat.png"),
              //                       fit: BoxFit.cover)),
              //             )))
            ])));
  }

  container(Size size, int count, String textType) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10.0),
      child: Container(
        height: size.height * 0.06,
        //width: size.width*0.3,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10),
            // color: const Color(0XFFECF2F3),
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
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("PERSONAL DETAILS",
                style: TextStyle(color: Color(0xFF101010), fontSize: 17)),
            const SizedBox(
              height: 20,
            ),
            // const Text("Email"),
            // const SizedBox(height: 10),
            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: const Color(0xffE5E7EB), width: 2)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    FontAwesomeIcons.solidEnvelope,
                    size: 20,
                    color: Color(0xFF3BADB7),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    _getUserFollowingStatus.data.email,
                    style:
                        const TextStyle(color: Color(0xff101010), fontSize: 16),
                  )
                ])),
            const SizedBox(
              height: 20,
            ),

            _getUserFollowingStatus.data.mobileIsPrivate == "0"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  color: const Color(0xffE5E7EB), width: 2)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  size: 20,
                                  color: Color(0xFF3BADB7),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  _getUserFollowingStatus.data.phoneNumber,
                                  style: const TextStyle(
                                      color: Color(0xff101010), fontSize: 16),
                                )
                              ])),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : SizedBox(),
            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: const Color(0xffE5E7EB), width: 2)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    FontAwesomeIcons.home,
                    size: 20,
                    color: Color(0xFF3BADB7),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    Address,
                    style:
                        const TextStyle(color: Color(0xff101010), fontSize: 16),
                  )
                ])),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: const Color(0xffE5E7EB), width: 2)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    FontAwesomeIcons.mapMarker,
                    size: 20,
                    color: Color(0xFF3BADB7),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    city,
                    style:
                        const TextStyle(color: Color(0xff101010), fontSize: 16),
                  )
                ])),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: const Color(0xffE5E7EB), width: 2)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    FontAwesomeIcons.globe,
                    size: 20,
                    color: Color(0xFF3BADB7),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    country,
                    style:
                        const TextStyle(color: Color(0xff101010), fontSize: 16),
                  )
                ])),
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
          Address = "Address not available";
          city = "City not available";
          country = "Country not available";
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
    if (pending != null) {
      if (pending != "error") {
        if (pending == "Pending") {
          gg = "Pending";
          return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
                  print("clicking /////////////////");
                  following();
                  //following();
                  setState(() {
                    gg = "Follow";
                    pending = "nothing";
                    isfollow = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFC8FBFF),
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  child: Text(
                    gg,
                    style:
                        const TextStyle(fontSize: 15, color: Color(0xFF101010)),
                  ),
                ),
              ));
        } else if (pending == "nothing") {
          gg = "Follow";
          return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
                  print("clicking /////////////////");
                  following();
                  //following();
                  setState(() {
                    gg = "pending";
                    pending = "Pending";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF3BADB7),
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    gg,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ));
        } else if (pending == "Following") {
          gg = "UnFollow";
          return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
                  postUnfollow();
                  setState(() {
                    isfollow = !isfollow;
                    gg = "Follow";
                    pending = "nothing";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFAFAFAF),
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    gg,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ));
        }
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
