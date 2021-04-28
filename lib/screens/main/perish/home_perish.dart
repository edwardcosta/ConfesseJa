import 'package:confesseja/utils/services/auth.dart';
import 'package:flutter/material.dart';

class HomePerish extends StatefulWidget {
  @override
  _HomePerishState createState() => _HomePerishState();
}

class _HomePerishState extends State<HomePerish> {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: ElevatedButton(child: Text('Sair'), onPressed: () {
              _auth.logout();
            }),
          ),
        ],
      ),
    );
  }
}
