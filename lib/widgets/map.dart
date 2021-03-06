import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Map extends StatefulWidget {
  final String? long;
  final String lat;
  const Map({Key? key, @required this.long, required this.lat})
      : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  // ignore: prefer_typing_uninitialized_variables
  var lat1;
  // ignore: prefer_typing_uninitialized_variables
  var lng1;
  late LatLng _initialcameraposition;

  final Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    lat1 = double.parse(widget.lat);
    lng1 = double.parse(widget.long!);
    _initialcameraposition = LatLng(lat1, lng1);
    print(_initialcameraposition);
  }

  late GoogleMapController _controller;
  final Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.satellite,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              myLocationButtonEnabled: false,
              markers: getmarkers(),
              onTap: (latlng) {
                print(latlng);
              },
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(_initialcameraposition.toString()),
        position: _initialcameraposition, //position of marker
        infoWindow: const InfoWindow(//popup info

            ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}