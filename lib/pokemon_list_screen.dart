import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_project/pokemon_detail.dart';
import 'package:graphql_project/pokemon_model.dart';
class PokemonList extends StatefulWidget {
  PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}


class _PokemonListState extends State<PokemonList> {
  final double fontSize = 12;

  final double lineGap = 2;

   bool isInternetAvailable = false;
  @override
  void initState() {
      checkInternet();

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokémon List"),
        centerTitle: true,

      ),
      body: isInternetAvailable?Query(
        options: QueryOptions(document: gql(getPokemonListQuery())),
        builder: (result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(
              child: Text(result.exception.toString()),
            );
          }

          final data = result.data;

          if (data == null || data.isEmpty) {
            return const Center(
              child: Text("No pokémon found yet"),
            );
          }
          final PokemonModel pokemonModel = PokemonModel.fromJson(data);
          final pokemonList = pokemonModel.pokemons ?? [];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: pokemonList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final pokemon = pokemonList[index];
                return InkWell(
                  onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                    pokemon: pokemon,
                                  )),
                        );
                  },
                  child: Card(
                          elevation: 2.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: width,
                                height: width/1.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: NetworkImage(pokemon.image ?? ''),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name: ${pokemon.name}',
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        height: lineGap,
                                      ),
                                    ),
                                    Text(
                                      'ID: ${pokemon.id}',
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        height: lineGap,
                                      ),
                                    ),
                                    Text(
                                      'Weight: ${pokemon.weight!.minimum} to ${pokemon.weight!.maximum}',
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        height: lineGap,
                                      ),
                                    ),
                                    Text(
                                      'Height: ${pokemon.height!.minimum} to ${pokemon.height!.maximum}',
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        height: lineGap,
                                      ),
                                    ),
                                    Text(
                                      'Classification: ${pokemon.classification}',
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        height: lineGap,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )

                        ),
                );
              },
            ),
          );
        },
      ):Center(child: CircularProgressIndicator()),
    );
  }

  String getPokemonListQuery() {
    return '''
 query Pokemons {
    pokemons(first: 100000) {
        id
        name
        classification
        image
        weight {
            minimum
            maximum
        }
        height {
            minimum
            maximum
        }
    }
}
 ''';
  }

  Future<void> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isInternetAvailable =  true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isInternetAvailable = false;
      });

    }
  }

}
