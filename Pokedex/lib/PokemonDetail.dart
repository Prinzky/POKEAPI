import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {
  String args;
  Future pokeApi(String name) async {
    String url = "https://pokeapi.co/api/v2/pokemon/$name";

    try {
      var responInJSON = await http.get(url);
      var decodeTheJSONtoFlutterMAP = json.decode(responInJSON.body);

      return decodeTheJSONtoFlutterMAP;
    } catch (e) {
      return e;
    }
  }

  String urlFoto(int pokedexIndex) {
    String url =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokedexIndex.png";
    return url;
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: FutureBuilder(
            builder: (context, pokemonData) {
              if (pokemonData.connectionState == ConnectionState.done) {
                var biodataPokemon = pokemonData.data;
                print(biodataPokemon.toString());
                return Container(
                  child: Column(
                    children: [
                      Center(
                        child: Image.network(
                          //FotoPokemonHalamanKedua
                          urlFoto(pokemonData.data['id']),
                          width: 300,
                          height: 300,
                        ),
                      ),
                      //Statistik
                      Text("STATISTIK: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      pokemonData.data['stats'].length == 1
                          ? Text(pokemonData.data['stats'][0]['stat']['name'])
                          : Text(
                              "${pokemonData.data['stats'][0]['stat']['name']} : ${pokemonData.data['stats'][0]['base_stat']}",
                              textAlign: TextAlign.center),
                      pokemonData.data['stats'].length == 1
                          ? Text(pokemonData.data['stats'][0]['stat']['name'])
                          : Text(
                              "${pokemonData.data['stats'][1]['stat']['name']} : ${pokemonData.data['stats'][1]['base_stat']}",
                              textAlign: TextAlign.center),
                      pokemonData.data['stats'].length == 1
                          ? Text(pokemonData.data['stats'][0]['stat']['name'])
                          : Text(
                              "${pokemonData.data['stats'][2]['stat']['name']} : ${pokemonData.data['stats'][2]['base_stat']}",
                              textAlign: TextAlign.center),
                      pokemonData.data['stats'].length == 1
                          ? Text(pokemonData.data['stats'][0]['stat']['name'])
                          : Text(
                              "${pokemonData.data['stats'][3]['stat']['name']} : ${pokemonData.data['stats'][3]['base_stat']}",
                              textAlign: TextAlign.center),
                      pokemonData.data['stats'].length == 1
                          ? Text(pokemonData.data['stats'][0]['stat']['name'])
                          : Text(
                              "${pokemonData.data['stats'][4]['stat']['name']} : ${pokemonData.data['stats'][4]['base_stat']}",
                              textAlign: TextAlign.center),
                      pokemonData.data['stats'].length == 1
                          ? Text(pokemonData.data['stats'][0]['stat']['name'])
                          : Text(
                              "${pokemonData.data['stats'][5]['stat']['name']} : ${pokemonData.data['stats'][5]['base_stat']}",
                              textAlign: TextAlign.center),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            future: pokeApi(args),
          ),
        ));
  }
}
