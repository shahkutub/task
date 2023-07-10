import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_project/pokemon_detail.dart';
import 'package:graphql_project/pokemon_list_screen.dart';

void main() async {
 
 //Initializes the HiveStore used for caching
 await initHiveForFlutter();
 
 final GraphQLClient graphQLClient = GraphQLClient(
   link: HttpLink("https://graphql-pokemon2.vercel.app/"),
   cache: GraphQLCache(
     store: HiveStore(),
   ),
 );
 
 final client = ValueNotifier(graphQLClient);
 runApp(
   GraphQLProvider(
     client: client,
     child: const MyApp(),
   ),
 );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: 'PokemonList GraphQL',
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
       primarySwatch: Colors.blue,
     ),
     initialRoute: "/",
     routes: {
       "/": (context) => PokemonList(),
     },
   );
  }
}