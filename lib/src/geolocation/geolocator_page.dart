import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocationPage extends StatefulWidget {
  GeolocationPage({Key? key}) : super(key: key);

  @override
  _GeolocationPageState createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {
  Position? position;
  double? _lat, _long;
  var mapLists;
  Completer<GoogleMapController> _mapsController = Completer();

  List<Marker> _marker = [];

  void _initMarkers() {
    if (mapLists != null) {
      _marker.clear();
      for (int i = 0; i < mapLists.length; i++) {
        MarkerId markerId = new MarkerId(i.toString());

        if (mapLists[i].latitude != null && mapLists[i].longitude != null) {
          _marker.add(
            new Marker(
              markerId: markerId,
              position: LatLng(-6.1794201, 106.831151),
              onTap: () {},
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
            ),
          );
        }
      }
    }
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.1794201, 106.831151),
    zoom: 14.4746,
    // bearing: 192.8334901395799,
    // tilt: 59.440717697143555,
  );

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    _lat = position!.latitude;
    _long = position!.longitude;
    print("Location get success");
    // _goToCurrentLocation();
    final GoogleMapController controller = await _mapsController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_lat!, _long!), zoom: 19.151926040649414)));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocation"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 430,
                child: GoogleMap(
                  indoorViewEnabled: true,

                  mapType: MapType.hybrid,
                  // mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _mapsController.complete(controller);
                  },
                  // markers: _marker.toSet(),

                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),
              SizedBox(height: 5),
              MaterialButton(
                onPressed: () {
                  print("Get location clicked");
                  // _determinePosition();
                  getLocation();
                },
                color: Colors.black,
                child: Text(
                  'Get Geolocation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 5),
              (position == null)
                  ? Container()
                  : SingleChildScrollView(
                      child: Container(
                          height: 120,
                          child: Column(
                            children: [
                              Row(children: [
                                Text("Latitude",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                Text("${position!.latitude}")
                              ]),
                              Row(children: [
                                Text("Longitude",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                Text("${position!.longitude}")
                              ]),
                              Row(children: [
                                Text("Altitude",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                Text("${position!.altitude}")
                              ]),
                              Row(children: [
                                Text("Floor",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                Text("${position!.floor}")
                              ]),
                              Row(children: [
                                Text("Accuracy",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                Text("${position!.accuracy}")
                              ]),
                              Row(children: [
                                Text("Is Mocked",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                Text("${position!.isMocked}")
                              ]),
                              Row(children: [
                                Text("Time Stamp",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                Text("${position!.timestamp}")
                              ]),
                            ],
                          )),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
