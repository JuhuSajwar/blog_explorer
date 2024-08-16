import 'package:blog_explorer/blog/bloc/blog_bloc.dart';
import 'package:blog_explorer/ui/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => BlogBloc())],
      child: const MaterialApp(
        title: 'Blog Explorer',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}