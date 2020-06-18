import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapContent extends StatefulWidget {
  const MapContent({Key key,this.onGoogleMapController,this.updatePosition}) : super (key: key);

  final ValueChanged<GoogleMapController> onGoogleMapController;
  final ValueChanged<LatLng> updatePosition;

  @override
  State<StatefulWidget> createState() => MapContentState();
  
}

class MapContentState extends State<MapContent>{
  Completer<GoogleMapController> _controller = Completer();
  var isPermissionLocationEnabled = false;

  /*static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );*/

  static final CameraPosition _brasilia = CameraPosition(
    target: LatLng(-15.77972, -47.92972),
  );

  
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _brasilia,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          widget.onGoogleMapController(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
    );
  }
}