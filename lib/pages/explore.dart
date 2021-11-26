import 'package:dio/dio.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/conditions.dart';
import 'package:event_spotter/widgets/explore/events.dart';
import 'package:event_spotter/widgets/smallButton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum screens { explore, filter }

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
  final TextEditingController _search = TextEditingController();
  final TextEditingController _distance = TextEditingController();

  screens swap = screens.explore;
  String? value;

  final dropdown = ['interest', 'no interest'];

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
  void dispose() {
    // TODO: implement dispose
    _search.dispose();
    _distance.dispose();
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding:  EdgeInsets.only(top: size.height*0.02 , left: size.width*0.05),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                     padding:  EdgeInsets.only(top : size.height * 0.02 ),
                     child: Row(
                        children: [
                           SizedBox(
                             //height: size.height*0.1,
                             width: size.width*0.8 ,
                             child: Textform(
                                controller: _search,
                                icon: Icons.search,
                                label: "Search",
                                color: const Color(0XFFECF2F3),
                              
                          ),
                           ),
                           SizedBox(
                            width: size.width*0.01,
                          ),
                         Smallbutton(
                             

                              
                              icon: FontAwesomeIcons.slidersH,

                              onpressed: () {
                                setState(() {
                                  swap = screens.filter;
                                });
                              },
                            
                          ),
                        ],
                      ),
                   ),
                  
                 
                  getpages(size),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget getpages(Size size) {
    switch (swap) {
      case screens.explore:
        return exploringfeeds(size);

      case screens.filter:
        return filter(size);
    }
  }

  Widget exploringfeeds(Size size) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(right: size.width*0.05 , top: size.height*0.03),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Createevent()));
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
    );
  }

  Widget filter(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(right: size.width * 0.08, top: size.height * 0.04),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.1, bottom: size.height * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: const Text(
                            "Filter Events",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                swap = screens.explore;
                              });
                            },
                            icon: const Icon(Icons.close)),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right : size.width*0.16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sort by",
                            style: TextStyle(color: Colors.black38),
                          ),
                          
                          Container(
                            //  margin:  EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                              color: const Color(0XFFECF2F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0, left: 10),
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: value,
                                    items: dropdown.map(buildMenuItem).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        this.value = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  SizedBox(height: size.height*0.02,),
    
                  Padding(
                    padding:  EdgeInsets.only(right: size.width * 0.16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          const Text(
                            "Distance",
                            style: TextStyle(color: Colors.black38),
                          ),
                         
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                            width: size.width * 0.35,
                            decoration : BoxDecoration(
                               color: const Color(0XFFECF2F2),
                               borderRadius: BorderRadius.circular(10),
                              //border: Border.all(color : Colors.black38),
                            ),
                          child: Flexible(
                            child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(borderSide: BorderSide.none)
                                ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
    
                  SizedBox(height: size.height*0.02,),
    
                  Padding(
                    padding:  EdgeInsets.only(right : size.width*0.16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         
                      
                            const Text(
                              "From",
                              style: TextStyle(color: Colors.black38),
                            ),
                            Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                              width: size.width * 0.35,
                              decoration : BoxDecoration(
                                 color: const Color(0XFFECF2F2),
                                 borderRadius: BorderRadius.circular(10),
                                //border: Border.all(color : Colors.black38),
                              ),
                            ),
                      ],
                    ),
                  ),
    SizedBox(height: size.height*0.02,),
                   Padding(
                    padding:  EdgeInsets.only(right : size.width*0.16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         
                      
                            const Text(
                              "To",
                              style: TextStyle(color: Colors.black38),
                            ),
                            Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                              width: size.width * 0.35,
                              decoration : BoxDecoration(
                                 color: const Color(0XFFECF2F2),
                                 borderRadius: BorderRadius.circular(10),
                                //border: Border.all(color : Colors.black38),
                              ),
                            ),
                      ],
                    ),
                  ),
          SizedBox(height: size.height*0.02,),
               Container(
                 alignment: Alignment.centerLeft,
                 child: const  Text('Conditions'
                  ,
                   style: TextStyle(color: Colors.black87),
                  ),
               ),
                   Wrap(
                      children: List.generate(eventconditions.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 6.0, top: 10),
                      child: Elevatedbuttons(
                        sidecolor: Colors.white,
                        width: size.width * 0.4,
                        coloring: const Color(0XFF368890),
                        text: eventconditions[index]['consitions'],
                        textColor: const Color(0XFFFFFFFF),
                      ),
                    );
                  })),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ));
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
  final String? profileImage;
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
                  image: NetworkImage(profileImage!), fit: BoxFit.cover),
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
