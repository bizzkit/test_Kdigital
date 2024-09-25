import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdigital_test/src/data/repository/characters_repository.dart';
import 'package:kdigital_test/src/di/main_di_module.dart';
import 'package:kdigital_test/src/presentation/bloc/main_bloc.dart';
import 'package:kdigital_test/src/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/presentation/ui/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  MainDIModule().configure(GetIt.I);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainPageBloc(GetIt.I.get<CharactersRepository>())
            ..add(const GetTestDataOnMainPageEvent(1)),
        ),
      ],
      child: MaterialApp(
        title: 'Test app',
        home: CharactersScreen(),
      ),
    );
  }
}
