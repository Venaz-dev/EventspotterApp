import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventTypeModel.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/smallButton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Createevent extends StatefulWidget {
  const Createevent({Key? key}) : super(key: key);

  @override
  State<Createevent> createState() => _CreateeventState();
}

class _CreateeventState extends State<Createevent> {
  final Dio _dio = Dio();
  late SharedPreferences _sharedPreferences;
  late String _token;
  late EventTypeModel _eventTypeModel;
  String getEventTypesUrl = "https://theeventspotter.com/api/getEventTypes";
  String createEventUrl = "https://theeventspotter.com/api/createEvent";
  String drafteventUrl = "https://theeventspotter.com/api/draftEvent";

  late Response response;
  String? value;
  late String latt;
  late String longg;
  bool check = false;
  late List<String> conditions = [];
  File? imagePath;
  bool _isloading = false;
  bool _isloading1 = false;
  String venuee = "Select Venue";
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateFormat newValues = DateFormat('yyyy-MM-dd');
  late String formatted;
  int public = 1;
  bool _ispublic = true;
  bool isprivate = false;
  final ImagePicker _picker = ImagePicker();
  TextEditingController eventname = TextEditingController();
  TextEditingController eventDescription = TextEditingController();

  TextEditingController venue = TextEditingController();
  TextEditingController conditionss = TextEditingController();

  TextEditingController link = TextEditingController();

  //File? imageFile;

  late List<String> eventtypes = [];
  @override
  void dispose() {
    // TODO: implement dispose
    eventname.dispose();
    eventDescription.dispose();
    venue.dispose();
    conditionss.dispose();
    link.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getEventTypes();
    passingString();
  }

  @override
  Widget build(BuildContext context) {
    String newValue;

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
          // appBar: AppBar(
          //   title: const Text(
          //     "Create a new event",
          //     style: TextStyle(
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black87,
          //         fontSize: 20),
          //   ),
          //   centerTitle: true,
          //   elevation: 0,
          //   backgroundColor: Colors.white,
          //   actions: [
          //     IconButton(
          //       icon: const Icon(Icons.info_outline_rounded),
          //       onPressed: () {},
          //       color: Colors.black38,
          //     )
          //   ],
          //   leading: Smallbutton(
          //     height: size.height * 0.06,
          //     icon: FontAwesomeIcons.arrowLeft,
          //     onpressed: () {
          //       Navigator.pop(context);
          //       // Navigator.of(context).pop();
          //     },
          //   ),
          // ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 20.0, left: 20, top: 80, bottom: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imagePath == null
                          ? Container(
                              //height: size.height * 0.35,
                              width: size.width * double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF3F4F6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                // border: Border(
                                //     top: BorderSide(color: Colors.black54),
                                //     left: BorderSide(color: Colors.black54),
                                //     right: BorderSide(color: Colors.black54),
                                //     bottom: BorderSide(color: Colors.black54)),
                              ),
                              child: InkWell(
                                onTap: () {
                                  _selectPhoto();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20.0, left: 20, bottom: 40),
                                  child: Column(children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        height: size.height * 0.15,
                                        child: Image.asset(
                                            'Assets/icons/camera.png')),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const AutoSizeText(
                                      "Tap to upload a picture or a video",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Elevatedbutton(
                                    //     primary: const Color(0xFF304747),
                                    //     text: "Upload Picture/Video",
                                    //     width: double.infinity,
                                    //     coloring: const Color(0xFF304747),
                                    //     onpressed: () {
                                    //       _selectPhoto(); // Navigator.of(context).push(MaterialPageRoute(
                                    //       //     builder: (context) => const Uploadimage()));
                                    //     }),
                                  ]),
                                ),
                              ))
                          : (imagePath!.path.toString().contains('.mp4') ||
                                  imagePath!.path.toString().contains('.mov'))
                              ? Column(children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      //color: Colors.red,
                                      height: size.height * 0.3,
                                      width: size.width * double.infinity,
                                      child:
                                          VideoPlayerScree1(url: imagePath!)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Elevatedbutton(
                                        primary: const Color(0xFF304747),
                                        text: "Upload Picture/Video",
                                        width: double.infinity,
                                        coloring: const Color(0xFF304747),
                                        onpressed: () {
                                          _selectPhoto(); // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) => const Uploadimage()));
                                        }),
                                  ),
                                  // SizedBox(
                                  //     height: size.height * 0.3,
                                  //     width: double.infinity,
                                  //     child: Column(
                                  //       children: [
                                  //         VideoPlayerScree1(url: imagePath!),
                                  //         Flexible(
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 bottom: 10.0),
                                  //             child: Elevatedbutton(
                                  //                 primary:
                                  //                     const Color(0xFF304747),
                                  //                 text: "Upload Picture/Video",
                                  //                 width: double.infinity,
                                  //                 coloring:
                                  //                     const Color(0xFF304747),
                                  //                 onpressed: () {
                                  //                   _selectPhoto(); // Navigator.of(context).push(MaterialPageRoute(
                                  //                   //     builder: (context) => const Uploadimage()));
                                  //                 }),
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ))
                                ])
                              : Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          _selectPhoto();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          //color: Colors.red,
                                          height: size.height * 0.3,
                                          width: size.width * double.infinity,
                                          child: Image.file(
                                            imagePath!,
                                            fit: BoxFit.contain,
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Elevatedbutton(
                                        primary: const Color(0xFF304747),
                                        text: "Change Picture/Video",
                                        width: double.infinity,
                                        coloring: const Color(0xFF304747),
                                        onpressed: () {
                                          _selectPhoto(); // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) => const Uploadimage()));
                                        }),
                                  ],
                                ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Event name"),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: const Color(0xffE5E7EB), width: 2)),
                        child: Textform(
                          isreadonly: false,
                          controller: eventname,
                          label: "Enter Event name",
                          color: Colors.white,
                          isSecure: false,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Event Description"),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: const Color(0xffE5E7EB), width: 2)),
                        child: Textform(
                          controller: eventDescription,
                          maxlines: 4,
                          label: "Enter Event Description",
                          isSecure: false,
                          isreadonly: false,
                          color: Colors.white,
                          width: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text("Event Type"),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          //  margin:  EdgeInsets.all(10),
                          height: 52,
                          // height: MediaQuery.of(context).size.height * 0.06,
                          //width: size.width*0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xffE5E7EB), width: 2),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 15),
                              child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  isExpanded: true,
                                  value: value,
                                  items: eventtypes.map(buildMenuItem).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      this.value = value;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Event date"),
                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(
                      //         color: const Color(0xffE5E7EB), width: 2),
                      //   ),
                      //   child: InkWell(
                      //       onTap: () {},
                      //       child: const Padding(
                      //           padding: EdgeInsets.only(right: 10.0, left: 15),
                      //           child: SizedBox(height: 52))),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xffE5E7EB), width: 1),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 0,
                                ),
                                Text(
                                  formatted,
                                  style: const TextStyle(
                                      color: Color(0xFF101010),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                const Icon(
                                  FontAwesomeIcons.calendar,
                                  color: Color(0xFF101010),
                                  size: 20,
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(2021, 1, 1),
                                maxTime: DateTime(2025, 6, 7),
                                onConfirm: (date) {
                                  print('confirm $date');
                                  newValue = newValues.format(date);
                                  formatted = newValue;
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Event venue"),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xffE5E7EB), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 5),
                          child: GestureDetector(
                            onTap: () {
                              showPlacePicker();
                            },
                            child: Textform(
                              input: false,
                              isSecure: false,
                              //isreadonly: false,
                              controller: venue,
                              // suffix: FontAwesomeIcons.crosshairs,
                              suffix: FontAwesomeIcons.mapMarkerAlt,
                              iconSize: 20,
                              iconColor: const Color(0xFF606060),
                              label: venuee,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Event link"),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xffE5E7EB), width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 5),
                          child: Textform(
                            controller: link,
                            isSecure: false,
                            suffix: FontAwesomeIcons.link,
                            iconSize: 20,
                            isreadonly: false,
                            label: "Enter Ticket link",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Event Conditions"),

                      conditions.isEmpty
                          // ? const Center(child: Text("No Conditions"))
                          ? const SizedBox()
                          : Column(

                              ////////////////////////////////////////////////////////////////////
                              ///
                              ///
                              children:
                                  List.generate(conditions.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 6.0, top: 10),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFFf9f9f9),
                                  ),
                                  child: Text(conditions[index].toString(),
                                      style: const TextStyle(
                                          color: Color(0xFF101010),
                                          fontSize: 16)),
                                ),
                              );
                            })),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 52,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          //color: const Color(0XFFEBF2F2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xffE5E7EB), width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100,
                              width: size.width * 0.7,
                              child: Textform(
                                isSecure: false,
                                isreadonly: false,
                                controller: conditionss,
                                // icon: FontAwesomeIcons.,
                                label: "Add an event condition",
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  if (conditionss.text == "") {
                                    setState(() {
                                      showToaster("Add Conditions");
                                    });
                                  } else {
                                    setState(() {
                                      addConditionsList();
                                      conditionss.clear();
                                    });
                                  }
                                },
                                child: Row(
                                  children: const [
                                    SizedBox(
                                        width: 30.0,
                                        child: Image(
                                            image: AssetImage(
                                                "Assets/icons/plus.png"))),
                                    SizedBox(
                                      width: 15,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          // Icon(Icons.visibility),
                          SizedBox(
                            width: 10,
                          ),
                          AutoSizeText("Event Privacy"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              public = 1;

                              setState(() {
                                _ispublic = !_ispublic;
                                publicevent();
                              });
                            },
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: _ispublic
                                      ? Colors.white
                                      : const Color(0XFFf8f8f8),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: _ispublic
                                          ? const Color(0xff3BADB7)
                                          : const Color(0XFFf8f8f8),
                                      width: 2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0,
                                      left: 10,
                                      top: 10,
                                      bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Public",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF101010),
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Everyone will be able to see this event details.",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF808080)),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              public = 0;
                              setState(() {
                                _ispublic = !_ispublic;

                                privateevent();
                              });
                            },
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: !_ispublic
                                      ? Colors.white
                                      : const Color(0XFFf8f8f8),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: !_ispublic
                                          ? const Color(0xff3BADB7)
                                          : const Color(0XFFf8f8f8),
                                      width: 2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0,
                                      left: 10,
                                      top: 10,
                                      bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Private",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF101010),
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Only your followers or your following can see this event",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF808080)),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // !_ispublic ? privateevent() : publicevent(),

                      _isloading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xFF3BADB7)))
                          : Elevatedbutton(
                              text: "Create",
                              width: double.infinity,
                              coloring: const Color(0xFF304747),
                              textColor: const Color(0XFFFFFFFF),
                              primary: const Color(0xFF3BADB7),
                              onpressed: () async {
                                if (eventname.text.isEmpty ||
                                    eventDescription.text.isEmpty ||
                                    venuee.contains("Not Selected") ||
                                    imagePath == null ||
                                    conditions.isEmpty) {
                                  showToaster(
                                      "Please fill all the above fields");
                                } else {
                                  setState(() {
                                    _isloading = !_isloading;
                                  });

                                  await postCreatEvent();
                                }
                              }),
                      const SizedBox(
                        height: 16,
                      ),
                      _isloading1
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xFF3BADB7)))
                          : Elevatedbutton(
                              onpressed: () async {
                                if (eventname.text.isEmpty ||
                                    eventDescription.text.isEmpty ||
                                    venuee.contains("Not Selected") ||
                                    imagePath == null ||
                                    conditions.isEmpty) {
                                  showToaster(
                                      "Please fill all the above fields");
                                } else {
                                  setState(() {
                                    _isloading1 = !_isloading1;
                                  });

                                  await DraftEvent();
                                }
                              },
                              textColor: const Color(0XFF101010),
                              coloring: Colors.white,
                              text: "Save as draft",
                              width: double.infinity,
                              primary: const Color(0xFFC8FBFF),
                            ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                    height: 58,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFc4c4c4), width: 1))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: const [
                          Spacer(),
                          Text(
                            "Create a new event",
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
            ],
          )),
    );
  }

  AutoSizeText privateevent() {
    return const AutoSizeText(
      "This Event is private.Only your followers will see this event details",
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 15,
      ),
    );
  }

  AutoSizeText publicevent() {
    return const AutoSizeText(
      "This Event is public. Everyone on Event Spotter will be able to see this event details",
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 15,
      ),
    );
  }

  DraftEvent() async {
    String fileName = imagePath!.path.split('/').last;
    print("events near you $formatted");
    print('condtions length ${conditions.length}');
// return;
    var file =
        await MultipartFile.fromFile(imagePath!.path, filename: fileName);
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    FormData formData = FormData.fromMap({
      "event_name": eventname.text,
      "event_description": eventDescription.text,
      "event_type": value,
      "event_date": formatted,
      "location": venuee,
      "is_public": public,
      "lat": latt,
      "lng": longg,
      "ticket_link": link.text,
      "conditions": jsonEncode(conditions),
      'image': file,
    });

    response = await _dio.post(drafteventUrl, data: formData);

    try {
      if (response.statusCode == 200) {
        print(response.data);
        print("Data Send");
        showToaster("Saved in Draft");
        venue.clear();
        link.clear();
        eventDescription.clear();
        eventname.clear();
        Navigator.pop(context);
      } else {
        showToaster("Error");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isloading1 = false;
      setState(() {});
    }
  }

  addConditionsList() {
    conditions.add(conditionss.text);
  }

  getEventTypes() async {
    response = await _dio.get(getEventTypesUrl);
    if (response.data["success"] == true) {
      _eventTypeModel = EventTypeModel.fromJson(response.data);
      print(_eventTypeModel.data);

      for (int i = 0; i < _eventTypeModel.data.length; i++) {
        var value = _eventTypeModel.data[i].type;
        eventtypes.add(value);
      }
      setState(() {
        value = eventtypes[0];
      });
    }
  }

  passingString() {
    formatted = formatter.format(now);
  }

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyCZTqBDEFeniyz9QukE0gu4yQ5g2mt7rm0",
            )));

    // Handle the result in your way
    print(result?.name);
    print(result?.latLng);
    latt = result!.latLng!.latitude.toString();
    longg = result.latLng!.longitude.toString();
    venuee = result.formattedAddress!;
    check = true;
    setState(() {});
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(color: Color(0XFF101010), fontSize: 16),
      ));

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: const Icon(Icons.filter),
                      title: const Text('Pick an image'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      }),
                  ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('camera'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      }),
                  ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('Pick a video'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickvideo(ImageSource.gallery);
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.photo_camera_front,
                      ),
                      title: const Text('video'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickvideo(ImageSource.camera);
                      }),
                ],
              ),
              onClosing: () {},
            ));
  }

  createEvent() async {}
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
      print("ssssssss");
    }
  }

  postCreatEvent() async ///////////////////////////////////////
  {
    String fileName = imagePath!.path.split('/').last;
    print("events near you $formatted");
    print('condtions length ${conditions.length}');
// return;
    var file =
        await MultipartFile.fromFile(imagePath!.path, filename: fileName);
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    FormData formData = FormData.fromMap({
      "event_name": eventname.text,
      "event_description": eventDescription.text,
      "event_type": value,
      "event_date": formatted,
      "location": venuee,
      "is_public": public,
      "lat": latt,
      "lng": longg,
      "ticket_link": link.text,
      "conditions": conditions.join(','),
      'image': file,
    });

    response = await _dio.post(createEventUrl, data: formData);

    try {
      if (response.statusCode == 200) {
        print(response.data);
        print("Data Send");
        showToaster("Event Created");
        venue.clear();
        link.clear();
        eventDescription.clear();
        eventname.clear();
        // Navigator.pop(context);
      } else {
        showToaster("Error");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isloading = false;
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
}

class Elevatedbuttons extends StatelessWidget {
  final String text;
  final Color? coloring;
  final Color? textColor;
  final VoidCallback? onpressed;
  final double width;
  final Color? primary;
  final Color? sidecolor;
  final Color? shadowColor;

  const Elevatedbuttons({
    required this.text,
    Key? key,
    this.shadowColor,
    this.coloring,
    this.textColor,
    this.onpressed,
    this.width = 0,
    this.primary,
    this.sidecolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        color: coloring,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: sidecolor!),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            primary: primary,
            shadowColor: shadowColor),
        onPressed: onpressed,
      ),
    );
  }
}

class VideoPlayerScree1 extends StatefulWidget {
  VideoPlayerScree1({Key? key, required this.url}) : super(key: key);
  late File url;

  @override
  _VideoPlayerScree1State createState() => _VideoPlayerScree1State();
}

class _VideoPlayerScree1State extends State<VideoPlayerScree1> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.file(widget.url);
    print(widget.url);
    print('Hello Wolrd');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.setVolume(5);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _controller.play();

              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return SizedBox(
                height: size.height * 0.3,
                width: double.infinity,
                child: ClipRRect(child: VideoPlayer(_controller)),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF3BADB7)),
              );
            }
          },
        ),
        // ElevatedButton(
        //     onPressed: () {
        //       // If the video is playing, pause it.
        //       if (_controller.value.isPlaying) {
        //         _controller.pause();
        //       } else {
        //         // If the video is paused, play it.
        //         _controller.play();
        //       }
        //       setState(() {});
        //     },
        //     child: Text('PLAY'))
      ],
    );
  }
}
