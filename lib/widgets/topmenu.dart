import 'package:flutter/material.dart';

class Topmenu extends StatelessWidget {
  const Topmenu({Key? key, this.height, this.icon, this.onpressed, this.title})
      : super(key: key);

  final double? height;
  final IconData? icon;
  final VoidCallback? onpressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: size.width * 0.45,
                      child: Text(
                        title.toString(),
                        style: const TextStyle(
                            color: Color(0xff222222),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )),
        ),
        Positioned(
            top: 0.0,
            left: 20.0,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFE5E7EB), width: 1))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xff101010),
                          size: 22.0,
                        ),
                        Text(
                          "Back",
                          style:
                              TextStyle(color: Color(0xff222222), fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )))),
      ],
    );
  }
}
