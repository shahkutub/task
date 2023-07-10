class PokemonModel {
  List<Pokemon>? pokemons;

  PokemonModel({this.pokemons});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    if (json['pokemons'] != null) {
      pokemons = <Pokemon>[];
      json['pokemons'].forEach((v) {
        pokemons!.add(Pokemon.fromJson(v));
      });
    }
  }
}

class Pokemon {
  String? id;
  String? name;
  String? classification;
  String? image;
  Weight? weight;
  Weight? height;

  Pokemon(
      {this.id,
      this.name,
      this.classification,
      this.image,
      this.weight,
      this.height});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    classification = json['classification'];
    image = json['image'];
    weight =
        json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    height =
        json['height'] != null ? Weight.fromJson(json['height']) : null;
  }
}

class Weight {
  String? minimum;
  String? maximum;

  Weight({this.minimum, this.maximum});

  Weight.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
  }
}