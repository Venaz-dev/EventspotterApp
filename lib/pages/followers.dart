import 'package:dio/dio.dart';
import 'package:event_spotter/models/getfollowerlistmodel.dart';
import 'package:event_spotter/widgets/more/followers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_spotter/widgets/topmenu.dart';

class Following extends StatefulWidget {
  const Following({Key? key}) : super(key: key);

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  final Dio _dio = Dio();
  late SharedPreferences _sharedPreferences;
  bool _isLoading = true;
  bool test = false;
  late FollowerListModel _followerListModel;
  late String _token;
  final TextEditingController _search = TextEditingController();

  String UrserFollowUrl = "https://theeventspotter.com/api/getUserFollowerList";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFollower();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: const Text(
      //     "Followers",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      // ),
      body: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 80, right: 20, left: 20, bottom: 20),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF3BADB7)))
                : Column(
                    children: [
                      // Textform(
                      //   controller: _search,
                      //   icon: Icons.search,
                      //   label: "Search",
                      //   color: const Color(0XFFECF2F3),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      test != false
                          ? Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 0, left: 0),
                                child: Column(
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     const Text(
                                    //       "Your Followers",
                                    //       style: TextStyle(
                                    //           fontSize: 15,
                                    //           color: Colors.black54),
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Text(
                                    //       _followerListModel.data.length
                                    //           .toString(),
                                    //       style: const TextStyle(
                                    //           fontSize: 16,
                                    //           color: Colors.black,
                                    //           fontWeight: FontWeight.w500),
                                    //     ),
                                    //   ],
                                    // ),
                                    Followerlist(
                                      size: size,
                                      followerListModel: _followerListModel,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const Center(
                              child: Text("You have no followers"),
                            )
                    ],
                  ),
          ),
        ),
        const Topmenu(title: "Followers"),
      ]),
    ));
  }

  getFollower() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    try {
      Response response = await _dio.get(UrserFollowUrl);
      if (response.data["success"] == true) {
        print(response.data);
        if (response.data["data"].length > 0) {
          print(response.data);
          _followerListModel = FollowerListModel.fromJson(response.data);
          test = true;
        }
        print("get follower data");
      } else {
        print("error");
        test = false;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }
}
