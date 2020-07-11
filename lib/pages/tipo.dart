import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class Tipo extends StatefulWidget {
  final String tipo;
  Tipo(this.tipo);

  @override
  _TipoState createState() => _TipoState();
}

class _TipoState extends State<Tipo> {
  List<Pokemon> pokemons = [];

  @override
  void initState() {
    super.initState();
    obtenerPokemons();
  }

  Future<void> obtenerPokemons() async {
    var respuesta =
        await http.get('https://pokeapi.co/api/v2/type/${widget.tipo}');
    final data = jsonDecode(respuesta.body)['pokemon'] as List<dynamic>;
    print(data);
    data.forEach((element) async {
      var res = await http.get(element['pokemon']['url']);
      var dataPoke = jsonDecode(res.body);
      List<String> imagenes = [];

      //Reviso si existe esta imagen y la coloco como imagen principal
      if(dataPoke['sprites']['front_default'] != null){
        imagenes.add(dataPoke['sprites']['front_default']);
      }

      (dataPoke['sprites'] as Map<String, dynamic>).keys.forEach((key) {
        imagenes.add(dataPoke['sprites'][key]);
      });

      setState(() {
        pokemons.add(Pokemon(
            nombre: dataPoke['name'],
            id: dataPoke['id'],
            url: element['pokemon']['url'],
            tipo: widget.tipo,
            imagenes: imagenes));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.tipo,
          child: Text(widget.tipo),
        ),
      ),
      body: GridView.builder(
        itemCount: pokemons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 4,
        ),
        itemBuilder: (ctx, index) => Card(
          child: Center(
            // child: Text(pokemons[index].nombre),
            child: pokemons[index].imagenes[0] != null
                ? Image.network(pokemons[index].imagenes[4])
                : Text(pokemons[index].nombre),
          ),
        ),
      ),
    );
  }
}
