import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangabuzz/core/repository/local/moor_db_repository.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<MyDatabase>(
      create: (context) => constructDb(),
      child: MultiBlocProvider(providers: null, child: null),
    );
  }
}
