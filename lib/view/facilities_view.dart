import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FacilitiesView extends StatefulWidget {
  const FacilitiesView({super.key});

  @override
  State<FacilitiesView> createState() => _FacilitiesViewState();
}

class _FacilitiesViewState extends State<FacilitiesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FACILITIES", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: MediaQuery.of(context).size.height/33, fontWeight: FontWeight.w600,),),
        centerTitle: true,
      ),
      body: SafeArea(child: Column(

      )),
    );
  }
}
