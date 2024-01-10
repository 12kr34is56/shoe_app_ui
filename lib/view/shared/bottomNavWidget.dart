


import 'package:flutter/material.dart';

class BottomNavWidget extends StatelessWidget {
  BottomNavWidget({
    super.key,
    required this.onTap,required this.icon
  });
  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36, //todo make it responsive
        width: 36,
        child: Icon(icon,color: Colors.white,),
      ),
    );
  }
}
