import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/bloc/todo_bloc.dart';
import 'package:todobloc/observer/simple_bloc_observer.dart';
import 'package:todobloc/pages/todo_page.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //Mendaftarkan Bloc Yang Telah Terbuat
      create: (context) => TodoBloc(),
      //Route Page
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TodoPage(),
      ),
    );
  }
}

