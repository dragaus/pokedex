import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './tipo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> types = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http.get('https://pokeapi.co/api/v2/type').then((respuesta) {
      setState(() {
        print(respuesta.body);
        var data = jsonDecode(respuesta.body)['results'];
        data.forEach((element) {
          types.add(element['name']);
        });
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: ListView.builder(
        itemCount: types.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => Tipo(types[index]),
              ),
            );
          },
          child: ListTile(
            title: Hero(
              tag: types[index],
              child: Text(types[index]),
            ),
          ),
        ),
      ),
    );
  }
}
