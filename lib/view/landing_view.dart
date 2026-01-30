import 'package:city_hub/utils/google_navigation_bar.dart';
import 'package:city_hub/view/facilities_view.dart';
import 'package:city_hub/view/home_view.dart';
import 'package:city_hub/view/user_profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {

  int _selectViewIndex = 0;

  final List<Widget> _pagesViews = [
    const Homeview(),
    const FacilitiesView(),
    const UserProfileView(),
  ];

  void viewNavigationGetIndex(int index){
    setState(() {
      _selectViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25,right: 18,left: 18),
        child: GoogleNavigationBar(
          onTabChange: (index) => viewNavigationGetIndex(index),
        ),
      ),
        body:_pagesViews[_selectViewIndex]
    );
  }
}
