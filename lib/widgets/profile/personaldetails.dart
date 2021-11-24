import 'package:event_spotter/pages/create_new_event.dart';
import 'package:event_spotter/widgets/textformfield.dart';
import 'package:flutter/material.dart';

class Personaldetails extends StatelessWidget {
  const Personaldetails({
    Key? key,
    required TextEditingController email,
    required TextEditingController phonenumber,
    required TextEditingController address,
    required TextEditingController city,
    required TextEditingController country,
  }) : _email = email, _phonenumber = phonenumber, _address = address, _city = city, _country = country, super(key: key);

  final TextEditingController _email;
  final TextEditingController _phonenumber;
  final TextEditingController _address;
  final TextEditingController _city;
  final TextEditingController _country;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
      ],
    );
  }
}
