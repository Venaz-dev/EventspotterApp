import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventsModel.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/explore/events.dart';
import 'package:event_spotter/widgets/explore/livefeed.dart';
import 'package:event_spotter/widgets/smallButton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String? latlong;
  String? Lat;
  String? _name;
  String? _email1;
  String? _token;
  late Response response;

  Dio _dio = Dio();
  String urlLocation = "https://theeventspotter.com/api/saveLatLng";

  late String long;
  late SharedPreferences _sharedPreferences;
  Geolocator geolocator = Geolocator();
  //late Map<String, double> userLocation;
  @override
  void initState() {
    super.initState();
    getInitializedSharedPref();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _search = TextEditingController();
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0XFFF4F4F4),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentfocus = FocusScope.of(context);

          if (!currentfocus.hasPrimaryFocus) {
            currentfocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.tightFor(width: size.width * 0.7),
                          child: Textform(
                            controller: _search,
                            icon: Icons.search,
                            label: "Search",
                            color: const Color(0XFFECF2F3),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: Smallbutton(
                            size: size.height * 0.08,
                            icon: FontAwesomeIcons.slidersH,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Createevent()));
                      },
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGV2ZW50fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'),
                            fit: BoxFit.cover,
                            //  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop)
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              FontAwesomeIcons.plusCircle,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "create a new event",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Eventss(),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      Lat = position.latitude.toString();
      long = position.longitude.toString();
      latlong = Lat! + "," + long;
    });
    print(latlong);
    await locationpost();
  }

  void getInitializedSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _name = _sharedPreferences.getString('name')!;
    _email1 = _sharedPreferences.getString('email')!;

    setState(() {
      _token = _sharedPreferences.getString('accessToken')!;
    });
    print(_token);
  }

  locationpost() async {
    // ignore: avoid_print
    print("Location section ");
    print(_token);
    // FormData formData = new FormData.fromMap({
    //   "lat_lng": latlong,
    // });
    _dio.options.headers["Authorization"] = "Bearer ${_token}";

    response = await _dio.post(
      urlLocation,
      data: {'lat_lng': latlong},
    );
    print(response.toString());
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.radiusofbutton,
    this.profileImage = '',
    required this.title,
  }) : super(key: key);

  final BorderRadiusGeometry? radiusofbutton;
  final String profileImage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: radiusofbutton!,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(profileImage), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class Buttonicon extends StatelessWidget {
  const Buttonicon(
      {Key? key, this.radiusofbutton, required this.title, this.icon})
      : super(key: key);

  final BorderRadiusGeometry? radiusofbutton;

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: radiusofbutton!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 15,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
