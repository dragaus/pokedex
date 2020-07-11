import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/providers/auth_provider.dart';

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  bool _isSingIn = false;

  void _switchAuthMode() {
    setState(() {
      _isSingIn = !_isSingIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(30),
      // ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(16.0),
        height: _isSingIn ? 360 : 280,
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),
                _isSingIn
                    ? TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Repite la Contraseña',
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  child: Text(_isSingIn ? 'Ingresar' : 'Registro'),
                  onPressed: () => auth.setAuth(true),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                ),
                FlatButton(
                  child: Text(
                      '¿O quieres ${_isSingIn ? 'registarte' : 'ingresar'}?'),
                  onPressed: (_switchAuthMode),
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
