import 'dart:ui';

import 'package:confesseja/models/user.dart';
import 'package:confesseja/res/strings.dart';
import 'package:confesseja/screens/home/home_bottom_menu_conent.dart';
import 'package:confesseja/screens/home/map/home_map.dart';
import 'package:confesseja/screens/home/profile/profile.dart';
import 'package:confesseja/utils/animated_routes/size_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final double _initFabHeight = 150.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 125.0;
  double _opacity = 1;
  final _map = MapContent(
    onGoogleMapController: onGoogleMapController,
  );
  static GoogleMapController _controller;
  String welcomeText = AppStrings.HOME_WELCOME;

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
  }

  static void onGoogleMapController(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height; //* .80;
    final firebaseUser = Provider.of<FirebaseUser>(context);
    final user = Provider.of<User>(context);

    LocationData userLocation = Provider.of<LocationData>(context);

    if (firebaseUser != null &&
        firebaseUser.displayName != null &&
        firebaseUser.displayName.isNotEmpty) {
      welcomeText += ', ' + firebaseUser.displayName;
    }

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _map,
            panelBuilder: (sc) =>
                HomeBottoMenuContent.botomMenuContent(context, sc, _opacity),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
              _opacity = 1 - pos;
            }),
          ),

          // the fab
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                if (userLocation != null) {
                  _controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              userLocation.latitude, userLocation.longitude),
                          zoom: 15)));
                }
              },
              backgroundColor: Colors.white,
            ),
          ),

          //Notification Area
          Positioned(
              top: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.transparent,
                      )))),

          //Welcome Title
          Positioned(
            top: 52.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(SizeRoute(
                    page: Profile(
                  welcomeText: welcomeText,
                  user: user,
                )));
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
                child: Hero(
                  tag: 'welcomeText',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      welcomeText,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, _opacity)),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, _opacity),
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, _opacity * .25),
                        blurRadius: 16.0)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
