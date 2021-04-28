import 'package:confesseja/utils/services/auth.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: ElevatedButton(
                child: Text('Sair'),
                onPressed: () {
                  _auth.logout();
                }),
          ),
        ],
      ),
    );
  }
}
