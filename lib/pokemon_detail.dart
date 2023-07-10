import 'package:flutter/material.dart';
import 'package:graphql_project/pokemon_model.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonDetail({super.key, required this.pokemon});

  final double fontSize = 20;
  final double lineGap = 2;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name ?? 'Pokémon Detail'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: width,
            height: width / 1.5,
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
      ),
    );
  }
}
