import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapContent extends StatefulWidget {
  final ValueChanged<GoogleMapController> onGoogleMapCotrollerChanged;

  MapContent({this.onGoogleMapCotrollerChanged});

  @override
  State<StatefulWidget> createState() => MapContentState();
}

class MapContentState extends State<MapContent> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _mapController;
  var isPermissionLocationEnabled = false;
  String _mapStyle;
  LocationData userLocation;

  static final CameraPosition _brasilia = CameraPosition(
    target: LatLng(-15.77972, -47.92972),
  );

  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/raw/maps_style.json')
        .then((value) => _mapStyle = value);
  }

  void moveCameraToUserLocation() async {
    if (userLocation != null) {
      _mapController
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: 15,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    userLocation = Provider.of<LocationData>(context);
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: userLocation == null
            ? _brasilia
            : CameraPosition(
                target: LatLng(userLocation.latitude, userLocation.longitude),
                zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(_mapStyle);
          _controller.complete(controller);
          _mapController = controller;
          widget.onGoogleMapCotrollerChanged(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
    );
  }
}
