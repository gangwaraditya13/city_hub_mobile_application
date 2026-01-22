import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  bool isLoading;

  Widget? widget;

  VoidCallback? onTap;

  CustomTextButton({
    required this.onTap,
    required this.widget,
    super.key,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isLoading?Colors.transparent:Theme.of(context).colorScheme.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: widget,
          ),
        ),
      ),
    );
  }
}
