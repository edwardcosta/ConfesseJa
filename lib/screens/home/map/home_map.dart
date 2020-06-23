import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapContent extends StatefulWidget {
  const MapContent({Key key, this.onGoogleMapController}) : super(key: key);

  final ValueChanged<GoogleMapController> onGoogleMapController;

  @override
  State<StatefulWidget> createState() => MapContentState();
}

class MapContentState extends State<MapContent> {
  Completer<GoogleMapController> _controller = Completer();
  var isPermissionLocationEnabled = false;
  String _mapStyle;

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

  @override
  Widget build(BuildContext context) {
    final userLocation = Provider.of<LocationData>(context);
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
          widget.onGoogleMapController(controller);
          if (userLocation != null) {
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target:
                        LatLng(userLocation.latitude, userLocation.longitude),
                    zoom: 15)));
          }
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
    );
  }
}
