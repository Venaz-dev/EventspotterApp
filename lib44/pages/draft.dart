import 'dart:io';
import 'package:dio/dio.dart';
import 'package:event_spotter/models/eventTypeModel.dart';
import 'package:event_spotter/pages/create_new_event.dart';
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
// import 'package:place_picker/entities/location_result.dart';
// import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Draftsedit extends StatefulWidget {
  const Draftsedit(
      {Key? key,
      required this.eventname,
      required this.date,
      required this.placename,
      required this.imagepath,
      required this.videopath,
      required this.eventdescription,
      required this.conditions,
      required this.lat,
      required this.ticketlink,
      required this.log,
      required this.type,
      required this.eventprivaacy})
      : super(key: key);

  final String eventname;
  // final String description;
  final String date;
  final String placename;
  final String imagepath;
  final String videopath;
  final String eventdescription;
  final List conditions;
  final String? ticketlink;
  final String eventprivaacy;
  final String lat;
  final String type;
  final String log;

  @override
  State<Draftsedit> createState() => _DraftseditState();
}

class _DraftseditState extends State<Draftsedit> {
  final Dio _dio = Dio();
  late SharedPreferences _sharedPreferences;
  late String _token;
  late EventTypeModel _eventTypeModel;
  String getEventTypesUrl = "https://theeventspotter.com/api/getEventTypes";
  String createEventUrl = "https://theeventspotter.com/api/createEvent";
  String drafteventUrl = "https://theeventspotter.com/api/draftEvent";
  String MainUrl = "https://theeventspotter.com/";

  late Response response;
  String? value;
  late String latt;
  late String longg;
  bool check = false;
  late List conditions = [];
  File? imagePath;
  bool _isloading = false;
  bool _isloading1 = false;
  String venuee = "Not Selected";
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
    eventname = TextEditingController(text: widget.eventname);
    eventDescription = TextEditingController(text: widget.eventdescription);
    imagePath = File(widget.imagepath);
    latt = widget.lat;
    longg = widget.log;
    public = int.parse(widget.eventprivaacy);
    link = TextEditingController(text: widget.ticketlink);
    ;
    //value = widget.type;
    conditions = widget.conditions;
    getEventTypes();
    passingString();
    formatted = formatter.format(now);
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
        appBar: AppBar(
          title: const Text(
            "Drafts events",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              onPressed: () {},
              color: Colors.black38,
            )
          ],
          leading: Smallbutton(
            height: size.height * 0.06,
            icon: FontAwesomeIcons.arrowLeft,
            onpressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(right: 40.0, left: 40, top: 20, bottom: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (imagePath!.path.toString().contains('.mp4') ||
                        imagePath!.path.toString().contains('.mov'))
                    ? SizedBox(
                        height: size.height * 0.3,
                        width: double.infinity,
                        child: Column(
                          children: [
                            VideoPlayerScree1(url: MainUrl + imagePath!.path),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
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
                            )
                          ],
                        ))
                    : Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            //color: Colors.red,
                            height: size.height * 0.3,
                            width: size.width * double.infinity,
                            child: Image.network(MainUrl + widget.imagepath),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Elevatedbutton(
                              primary: const Color(0xFF304747),
                              text: "Upload Picture/Video",
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
                Textform(
                  isreadonly: false,
                  controller: eventname,
                  label: widget.eventname,
                  color: const Color(0XFFEBF2F2),
                  isSecure: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Textform(
                  controller: eventDescription,
                  maxlines: 4,
                  label: "Event Description",
                  isSecure: false,
                  isreadonly: false,
                  color: const Color(0XFFEBF2F2),
                  width: 30,
                ),
                const SizedBox(
                  height: 15,
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
                const Text("Event date"),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        const Icon(FontAwesomeIcons.calendar),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          formatted,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      primary: const Color(0XFF368890),
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
                const SizedBox(
                  height: 10,
                ),
                Textform(
                  input: false,
                  isSecure: false,
                  isreadonly: false,
                  controller: venue,
                  icon: FontAwesomeIcons.mapMarkerAlt,
                  label: widget.placename,
                  color: const Color(0XFFEBF2F2),
                ),
                const SizedBox(
                  height: 10,
                ),
                Textform(
                  controller: link,
                  isSecure: false,
                  icon: FontAwesomeIcons.link,
                  isreadonly: false,
                  label: "Ticket link",
                  color: const Color(0XFFEBF2F2),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Event Conditions"),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: size.height * 0.055,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: const Color(0XFFEBF2F2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 100,
                        width: size.width * 0.6,
                        child: Textform(
                          isSecure: false,
                          isreadonly: false,
                          controller: conditionss,
                          // icon: FontAwesomeIcons.,
                          label: "Add Conditions",
                          color: const Color(0XFFEBF2F2),
                        ),
                      ),
                      Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: Color(0XFF368890), shape: BoxShape.circle),
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                                onPressed: () {
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
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                conditions.isEmpty
                    ? const Center(child: Text("No Conditions"))
                    : Wrap(
                        children: List.generate(conditions.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6.0, top: 10),
                          child: Elevatedbuttons(
                            sidecolor: Colors.white,
                            width: size.width * 0.4,
                            coloring: const Color(0XFF368890),
                            text: conditions[index].toString(),
                            textColor: const Color(0XFFFFFFFF),
                          ),
                        );
                      })),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Icon(Icons.visibility),
                    SizedBox(
                      width: 10,
                    ),
                    AutoSizeText("Event Privacy"),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Elevatedbuttons(
                      sidecolor: Colors.white,
                      textColor:
                          _ispublic ? const Color(0XFFFFFFFF) : Colors.black,
                      text: "Public",
                      coloring: _ispublic
                          ? const Color(0XFF368890)
                          : const Color(0XFFFFFFFF),
                      width: size.width * double.infinity,
                      primary: _ispublic
                          ? const Color(0XFF368890)
                          : const Color(0XFFFFFFFF),
                      onpressed: () {
                        setState(() {
                          _ispublic = !_ispublic;
                          publicevent();
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Elevatedbuttons(
                      onpressed: () {
                        public = 0;
                        setState(() {
                          _ispublic = !_ispublic;

                          privateevent();
                        });
                      },
                      sidecolor: Colors.white,
                      coloring: !_ispublic
                          ? const Color(0XFF368890)
                          : const Color(0XFFFFFFFF),
                      width: size.width * double.infinity,
                      text: "Private",
                      textColor:
                          !_ispublic ? const Color(0XFFFFFFFF) : Colors.black,
                      primary: !_ispublic
                          ? const Color(0XFF368890)
                          : const Color(0XFFFFFFFF),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                !_ispublic ? privateevent() : publicevent(),
                const SizedBox(
                  height: 20,
                ),
                _isloading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xFF3BADB7)))
                    : Elevatedbutton(
                        text: "Post",
                        width: double.infinity,
                        coloring: const Color(0xFF304747),
                        textColor: const Color(0XFFFFFFFF),
                        primary: const Color(0xFF304747),
                        onpressed: () async {
                          if (eventname.text.isEmpty ||
                              eventDescription.text.isEmpty ||
                              imagePath == null ||
                              conditions.isEmpty) {
                            showToaster("Please fill all the above fields");
                          } else {
                            setState(() {
                              _isloading = !_isloading;
                            });

                            await postCreatEvent();
                          }
                        }),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
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
      "conditions": conditions,
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

  // void showPlacePicker() async {
  //   LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => PlacePicker(
  //             "AIzaSyCZTqBDEFeniyz9QukE0gu4yQ5g2mt7rm0",
  //           )));

  //   // Handle the result in your way
  //   print(result?.name);
  //   print(result?.latLng);
  //   latt = result!.latLng!.latitude.toString();
  //   longg = result.latLng!.longitude.toString();
  //   venuee = result.formattedAddress!;
  //   check = true;
  //   setState(() {});
  // }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(color: Color(0XFF74AAB0), fontSize: 16),
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
      "conditions": conditions,
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
        Navigator.pop(context);
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

class VideoPlayerScree1 extends StatefulWidget {
  VideoPlayerScree1({Key? key, required this.url}) : super(key: key);
  late String url;

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
    _controller = VideoPlayerController.network(widget.url);
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
              return Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: VideoPlayer(_controller)),
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
