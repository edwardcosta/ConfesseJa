import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapContent extends StatefulWidget {
  const MapContent({Key key,this.onGoogleMapController,this.updatePosition}) : super (key: key);

  final ValueChanged<GoogleMapController> onGoogleMapController;
  final ValueChanged<LatLng> updatePosition;

  @override
  State<StatefulWidget> createState() => MapContentState();
  
}

class MapContentState extends State<MapContent>{
  Completer<GoogleMapController> _controller = Completer();
  Geolocator geolocator = Geolocator();
  var isPermissionLocationEnabled = false;

  /*static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );*/

  static final CameraPosition _brasilia = CameraPosition(
    target: LatLng(-15.77972, -47.92972),
  );

  Position userLocation;

  @override
  void initState() {
    super.initState();
    _getUserLocation().then((value){
      userLocation = value;
    });
  }

  Future<void> onMyLocationTap() async {
    final GoogleMapController controller = await _controller.future;
    _getUserLocation().then((value) => {
      if(value != null){
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(value.latitude,value.longitude),
              zoom: 15
            )
          )
        )
      }
    });
  }

  void initPositionListener(){
    geolocator.getPositionStream().listen((event) {
        widget.updatePosition(LatLng(event.latitude,event.longitude));
      }
    );
  }

  
  @override
  Widget build(BuildContext context) {
    Permission.location.status.then((value) {
      if(value.isGranted){
        isPermissionLocationEnabled = true;
        initPositionListener();
      }
    });

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: userLocation == null ? 
        _brasilia : CameraPosition(target: LatLng(userLocation.latitude,userLocation.longitude),zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          onMyLocationTap();
          widget.onGoogleMapController(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),*/
    );
  }

  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/

  Future<Position> _getUserLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}