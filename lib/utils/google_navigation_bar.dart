import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleNavigationBar extends StatefulWidget {

  void Function(int)? onTabChange;

  GoogleNavigationBar({super.key, required this.onTabChange});

  @override
  State<GoogleNavigationBar> createState() => _GoogleNavigationBarState();
}

class _GoogleNavigationBarState extends State<GoogleNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return GNav(
        rippleColor: Theme.of(context).colorScheme.secondary,
        hoverColor: Theme.of(context).colorScheme.primary,
        haptic: true,
        tabBorderRadius: 15,
        tabActiveBorder: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
        tabBorder: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1),
        tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)],
        curve: Curves.easeOutExpo,
        duration: Duration(milliseconds: 200),
        gap: 2,
        color: Theme.of(context).colorScheme.secondary,
        activeColor: Theme.of(context).colorScheme.primary,
        iconSize: 24,
        tabBackgroundColor: Theme.of(context).colorScheme.secondary,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        onTabChange: (Index) => widget.onTabChange!(Index),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.real_estate_agent_outlined,
            text: 'Facilities',
          ),
          GButton(
            icon: Icons.person_sharp,
            text: 'You',
          ),
        ]);
  }
}
