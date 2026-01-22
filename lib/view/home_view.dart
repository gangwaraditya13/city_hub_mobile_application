import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("CITY HUB"),
        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.height/36),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
