import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/providers/auth_provider.dart';

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  bool _isSingIn = false;

  AnimationController _controller;
  // Animation<Size> _animacionAltura;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    // _animacionAltura = Tween<Size>(
    //   begin: Size(double.infinity, 280),
    //   end: Size(double.infinity, 360),
    // ).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Curves.easeIn,
    //   ),
    // );
    // _animacionAltura.addListener(() => setState((){}));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0, 1.5), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _switchAuthMode() {
    setState(() {
      _isSingIn = !_isSingIn;
      if (_isSingIn) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(30),
      // ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
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
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeIn,
                  constraints: BoxConstraints(
                    minHeight: _isSingIn ? 60 : 0,
                    maxHeight: _isSingIn ? 120 : 0,
                  ),
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Repite la Contraseña',
                        ),
                      ),
                    ),
                  ),
                ),
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
