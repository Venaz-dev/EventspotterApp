import 'dart:io';
import 'package:dio/dio.dart';
import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/elevatedbutton.dart';
import 'package:event_spotter/widgets/smallButton.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:event_spotter/widgets/toaster.dart';
import 'package:event_spotter/widgets/topmenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Uploadimage extends StatefulWidget {
  final int eventId;
  Uploadimage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<Uploadimage> createState() => _UploadimageState();
}

class _UploadimageState extends State<Uploadimage> {
  final ImagePicker _picker = ImagePicker();
  File? imagePath;
  late Response response;
  bool _isloading = false;
  final Dio _dio = Dio();
  late SharedPreferences _sharedPreferences;
  late String _token;
  String uploadLiveFeeds = "https://theeventspotter.com/api/uploadEventSnap";
  TextEditingController _snapdescription = TextEditingController();
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
          // appBar: AppBar(
          //   title: const Text(
          //     "Upload a live snap",
          //     style: TextStyle(
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black87,
          //         fontSize: 20),
          //   ),
          //   centerTitle: true,
          //   elevation: 0,
          //   backgroundColor: Colors.white,
          //   leading: Smallbutton(
          //     height: size.height * 0.06,
          //     icon: FontAwesomeIcons.arrowLeft,
          //     onpressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ),
          body: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 80),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              imagePath == null
                  ? Container(
                      //height: size.height * 0.35,
                      width: size.width * double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
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
                                child: Image.asset('Assets/icons/camera.png')),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
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
                      ? SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              VideoPlayerScree1(url: imagePath!),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
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
                              )
                            ],
                          ))
                      : Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  _selectPhoto();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
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
              const Text("Snap Description"),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border:
                        Border.all(color: const Color(0xffE5E7EB), width: 2)),
                child: Textform(
                  isreadonly: false,
                  controller: _snapdescription,
                  label: "Enter Snap Description",
                  color: Colors.white,
                  isSecure: false,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // const AutoSizeText(
              //   "Tag People in Snap",
              //   style: TextStyle(fontSize: 16),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Textform(
              //     label: "Write Names",
              //     isSecure: false,
              //     maxlines: 2,
              //     controller: _snapdescription,
              //     color: const Color(0XFFEBF2F2),
              //     width: size.width * 0.1),
              const SizedBox(
                height: 20,
              ),
              _isloading == true
                  ? const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0XFF3BADB7),
                        ),
                      ),
                    )
                  : Elevatedbutton(
                      text: "Upload",
                      width: double.infinity,
                      coloring: const Color(0xFF304747),
                      textColor: const Color(0XFFFFFFFF),
                      primary: const Color(0xFF3BADB7),
                      onpressed: () async {
                        if (imagePath == null) {
                          showToaster("Please upload a snap");
                        } else {
                          setState(() {
                            _isloading = !_isloading;
                          });
                          await UploadLiveFeed();
                          Navigator.pop(context);
                        }
                      }),
            ]),
          ),
        ),
        Topmenu(
          title: "Upload a live snap",
        )
      ])),
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

  Future _pickvideo(ImageSource mediasource) async {
    final pickedFile = await _picker.pickVideo(source: mediasource);
    setState(() {
      imagePath = File(pickedFile!.path);
    });
    if (pickedFile == null) {
      return;
    }
  }

  UploadLiveFeed() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _token = _sharedPreferences.getString('accessToken')!;
    String fileName = imagePath!.path.split('/').last;
    var file =
        await MultipartFile.fromFile(imagePath!.path, filename: fileName);
    print(file.filename);
    print(_snapdescription.text);
    FormData formData = new FormData.fromMap({
      "event_id": widget.eventId,
      "description": _snapdescription.text,
      "path": file
    });
    _dio.options.headers["Authorization"] = "Bearer ${_token}";
    response = await _dio.post(uploadLiveFeeds, data: formData);
    print(response.data);
    try {
      if (response.data["success"] == true) {
        print(response.data);
        print("Data Send");
        showToaster("Snap Uploaded");
      } else {
        print("Snap not Uploaded Error");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _isloading = false;

      setState(() {});
    }
  }
}
