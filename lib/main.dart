import 'package:credicxo/bloc/home/song_bloc.dart';
import 'package:credicxo/data/api_repository.dart';
import 'package:credicxo/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => SongBloc(repository: ApiRepositoryImpl()),
        child: HomePage(),
      ),
    );
  }
}
