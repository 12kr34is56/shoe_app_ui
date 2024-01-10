import 'package:flutter/material.dart';
import 'package:shoeapp/view/shared/appStyle.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key,this.onPressed,required this.color,required this.name});
  final void Function()? onPressed;
  final Color color;
  final String name;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: 40,
        width: MediaQuery.sizeOf(context).width*0.250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: color,style: BorderStyle.solid
          )
        ),
        child: Center(child: Text(name,style: AppStyle(20, color, FontWeight.w600),)),
      ),
    );
  }
}
