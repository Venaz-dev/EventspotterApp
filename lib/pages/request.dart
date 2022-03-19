import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_spotter/widgets/topmenu.dart';

class Pendingrequests extends StatefulWidget {
  const Pendingrequests({Key? key}) : super(key: key);

  @override
  _PendingrequestsState createState() => _PendingrequestsState();
}

class _PendingrequestsState extends State<Pendingrequests> {
  String pendingUrl = "https://theeventspotter.com/api/pendingRequest";
  String MainUrl = "https://theeventspotter.com/";
  String acceptRequestUrl =
      "https://theeventspotter.com/api/acceptFollowingRequest";
  String declineRequestUrl =
      "https://theeventspotter.com/api/cancelPendingRequest";
  late List request = [];
  bool _isLoading = true;
  bool data = true;
  late String _token;
  late SharedPreferences _sharedPreferences;
  Dio _dio = Dio();

  @override
  void initState() {
    getPendingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   title: const Text(
            //     "Pending requests",
            //     style: TextStyle(color: Colors.black),
            //   ),
            //   centerTitle: true,
            // ),
            body: Stack(children: [
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : data
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 80),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(request.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 1,
                                                spreadRadius: 1,
                                                color: Colors.black12),
                                          ],
                                        ),
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            300),
                                                    child: CachedNetworkImage(
                                                      imageUrl: MainUrl +
                                                          request[index]["img"],
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                    request[index]["name"],
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              const Spacer(),
                                              Column(
                                                children: [
                                                  ElevatedButton(
                                                    child: const Text("Accept"),
                                                    onPressed: () {
                                                      acceptRequest(index);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: const Color(
                                                          0XFF368890),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    child:
                                                        const Text("Decline"),
                                                    onPressed: () {
                                                      declineRequest(index);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Colors
                                                                .redAccent),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text("No Pending Request"),
                        ),
              const Topmenu(title: "Pending Requests"),
            ])));
  }

  getPendingList() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    try {
      Response response = await _dio.get(pendingUrl);
      if (response.statusCode == 200) {
        if (response.data["data"].length > 0) {
          data = true;
          for (int j = 0; j < response.data["data"].length; j++) {
            if (response.data["data"][j]["user"]["profile_picture"] != null) {
              var js = {
                'name': response.data["data"][j]["user"]["name"],
                'img': response.data["data"][j]["user"]["profile_picture"]
                    ["image"],
                'id': response.data["data"][j]["id"]
              };

              request.add(js);
            } else {
              var js = {
                'name': response.data["data"][j]["user"]["name"],
                'img': "images/user.jpeg",
                'id': response.data["data"][j]["id"]
              };

              request.add(js);
            }
          }
        } else {
          data = false;
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  void acceptRequest(int index) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    FormData formData = FormData.fromMap({
      "id": request[index]["id"],
    });
    try {
      Response response = await _dio.post(acceptRequestUrl, data: formData);

      if (response.statusCode == 200) {
        showToaster("Request Accepted");
        request.removeAt(index);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
  }

  void declineRequest(int index) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    FormData formData = FormData.fromMap({
      "id": request[index]["id"],
    });
    try {
      Response response = await _dio.post(declineRequestUrl, data: formData);

      if (response.statusCode == 200) {
        showToaster("Request Rejected");
        request.removeAt(index);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
  }
}
