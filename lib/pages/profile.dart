import 'package:dio/dio.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/pages/signin.dart';
import 'package:event_spotter/widgets/profile/yourevents.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum scrolling { personal, settings }

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? value;
  int index = 0;
  late SharedPreferences _sharedPreferences;
  Dio _dio = Dio();
  bool _isLoading = false;
  late Response response;
  late String _name;
  late String _token;
  late String _email1;
  String url2 = "https://theeventspotter.com/api/logout";
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();

  final languages = ["English", "Spanish"];

  //Text Controllers

  List images = [
    {
      'eventimage':
          'https://images.pexels.com/photos/976866/pexels-photo-976866.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
    },
    {
      'eventimage':
          'https://images.pexels.com/photos/2263436/pexels-photo-2263436.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
    },
    {
      'eventimage':
          'https://images.pexels.com/photos/2747449/pexels-photo-2747449.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
    },
  ];

  scrolling widgetsscrolling = scrolling.personal;
  @override
  void initState() {
    getInitializedSharedPref();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);

        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 5, right: 30),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const LoginScreen()),
                                //     (route) => false);
                                // _sharedPreferences.clear();
                                setState(() {
                                  _isLoading = true;
                                });
                                LogoutapiCall();
                                _sharedPreferences.clear();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                    (route) => false);
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Logout",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ),
                      ]),
                ],
                body: SingleChildScrollView(
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
                                        height: size.height * 0.08,
                                        width: size.width * 0.1,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        children: const [
                                          Text(
                                            "Jhone Doe",
                                            style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "New York City",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      )
                                    ],
                                  ),

                                  Expanded(
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          container(size, 2340, 'Followers'),
                                          container(size, 234, 'Following'),
                                          container(size, 4, 'Events'),
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
                          Yourevents(images: images, size: size),
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
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(color: Color(0XFF74AAB0), fontSize: 16),
      ));

  Settings(bool isSwitched, String text) {
    return Container(
      child: Row(
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
          ),
        ],
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

  Widget getwidgets() {
    switch (widgetsscrolling) {
      case scrolling.personal:
        return personaldetails();

      case scrolling.settings:
        return settings();
    }
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
                    onpressed: () {
                      setState(() {
                        widgetsscrolling = scrolling.personal;
                      });
                    },
                    primary: const Color(0XFF38888F),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Elevatedbuttons(
                      sidecolor: Colors.black,
                      text: "Settings",
                      textColor: Colors.black,
                      coloring: Colors.white,
                      onpressed: () {
                        setState(() {
                          widgetsscrolling = scrolling.settings;
                        });
                      },
                      primary: Colors.white),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Email"),
            const SizedBox(height: 10),
            Textform(
              label: 'Joendoe@gmail.com',
              controller: _email,
              isSecure: false,
              color: const Color(0XFFEBF2F2),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Phone number"),
            const SizedBox(height: 10),
            Textform(
              label: '+412536748',
              controller: _phonenumber,
              isSecure: false,
              color: const Color(0XFFEBF2F2),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Address"),
            const SizedBox(height: 10),
            Textform(
              label: 'Lorem 21 , street 24, 23466 CA',
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
              label: 'New York City',
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
              label: 'United States',
              controller: _country,
              isSecure: false,
              color: const Color(0XFFEBF2F2),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Elevatedbuttons(
                sidecolor: Colors.transparent,
                text: "Edit Details",
                textColor: Colors.white,
                coloring: const Color(0XFF304747),
                onpressed: () {},
                primary: const Color(0XFF304747),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget settings() {
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
                    const SizedBox(
                      width: 10,
                    ),
                    Elevatedbuttons(
                        sidecolor: Colors.black,
                        text: "Personal Details",
                        textColor: Colors.black,
                        coloring: Colors.white,
                        onpressed: () {
                          setState(() {
                            widgetsscrolling = scrolling.personal;
                          });
                        },
                        primary: Colors.white),
                    const SizedBox(
                      width: 10,
                    ),
                    Elevatedbuttons(
                      sidecolor: Colors.transparent,
                      text: "Settings",
                      textColor: Colors.white,
                      coloring: const Color(0XFF38888F),
                      onpressed: () {
                        setState(() {
                          widgetsscrolling = scrolling.settings;
                        });
                      },
                      primary: const Color(0XFF38888F),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Settings(true, 'Recieve push notification'),
              Settings(true, 'Use your location'),
              Settings(true, 'Recieve email notification'),
              Settings(true, 'Allow direct messages'),
              Settings(false, 'Make your profile private'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Change language",
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  //  margin:  EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.06,
                  //width: size.width*0.5,
                  decoration: BoxDecoration(
                    color: const Color(0XFFECF2F2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: DropdownButton<String>(
                          isExpanded: true,
                          value: value,
                          items: languages.map(buildMenuItem).toList(),
                          onChanged: (value) {
                            setState(() {
                              this.value = value;
                            });
                          }),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  LogoutapiCall() async {
    //_sharedPreferences = await SharedPreferences.getInstance();

    print(_sharedPreferences.getString('accessToken'));
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    response = await _dio.get(url2);
    print(response.data.toString());
    if (response.data["success"] == true) {
      showToaster('Logged out');
      setState(() {
        _isLoading = false;
      });
    } else {
      print("error with logout");
      showToaster('Error!');
    }
  }

  getInitializedSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _name = _sharedPreferences.getString('name')!;
    _email1 = _sharedPreferences.getString('email')!;
    _token = _sharedPreferences.getString('accessToken')!;
    setState(() {
      _isLoading = false;
    });
  }
}
