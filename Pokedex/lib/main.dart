import 'dart:convert';
import 'PokemonDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pokedex',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {'/detailPokemon': (BuildContext context) => PokemonDetail()},
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future pokeApi() async {
    String url = "https://pokeapi.co/api/v2/pokemon?limit=151&offset=0";

    try {
      var responInJSON = await http.get(url);
      var decodeTheJSONtoFlutterMAP = json.decode(responInJSON.body);

      return decodeTheJSONtoFlutterMAP;
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("P@KEDEX TUGAS MOBILE PROGRAMMING"),
      ),
      body: FutureBuilder(
          future: pokeApi(),
          builder: (context, pokeApiReturnData) {
            if (pokeApiReturnData.connectionState == ConnectionState.done) {
              return PokemonList(pokeApiReturnData.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class PokemonList extends StatefulWidget {
  final pokedexResult;
  PokemonList(this.pokedexResult);
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String urlFoto(int pokedexIndex) {
    String url =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokedexIndex.png";

    return url;
  }

  String n = '';
  @override
  Widget build(BuildContext context) {
    List<String> x = [];
    if (n.isNotEmpty) {
      for (int index = 0;
          index < widget.pokedexResult['results'].length;
          index++) {
        if (widget.pokedexResult['results'][index]['name']
            .toString()
            .contains(n)) {
          x.add(widget.pokedexResult['results'][index]['name']);
        }
      }
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'search'),
                onChanged: (value) {
                  setState(() {
                    n = value.toString();
                    print(n);
                  });
                },
              ),
              n.isEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            return Navigator.pushNamed(
                                context, '/detailPokemon',
                                arguments: widget.pokedexResult['results']
                                    [index]['name']);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 1.0, color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Image.network(
                                    urlFoto(index + 1),
                                    width: 200,
                                    height: 200,
                                  ),
                                  Text(
                                    widget.pokedexResult['results'][index]
                                        ['name'],
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: widget.pokedexResult["results"].length,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            return Navigator.pushNamed(
                                context, '/detailPokemon',
                                arguments: x[index]);
                          },
                          child: Container(
                              child: Center(
                                  child: Text(
                            x[index],
                            style: TextStyle(fontSize: 35),
                          ))),
                        );
                      },
                      itemCount: x.length,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
