
import 'package:flutter/material.dart';
import 'package:shoeapp/view/shared/appStyle.dart';

class CheckOutButton extends StatelessWidget {
  CheckOutButton({
    super.key,
    required this.width, required this.name,required this.onTap
  });
  void Function()? onTap;
  final double width;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height:  43,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12)
        ),
        width: width*0.9,
        child: Center(child: Text(name,style: AppStyle(25, Colors.white, FontWeight.w600),),),
      ),
    );
  }
}
