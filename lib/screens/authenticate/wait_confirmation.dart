import 'package:confesseja/utils/services/auth.dart';
import 'package:flutter/material.dart';

class WaitConfirmation extends StatelessWidget {
  const WaitConfirmation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    return Container(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text("Tudo certo", style: Theme.of(context).textTheme.headline2),
              SizedBox(
                height: 20,
              ),
              Text(
                  "Agora e só aguardar a confirmação da nossa equipe para liberar o seu acesso ao app.",
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  child: Text('Sair'),
                  onPressed: () {
                    _auth.logout();
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
