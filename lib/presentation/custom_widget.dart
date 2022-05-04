import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomWidget extends HookWidget {
  const CustomWidget({required this.categoryName, required this.categoryNum, required this.ontap});

  final String categoryName;
  final int categoryNum;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(categoryName, style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffF2F4F6),
              ),

              child: Text(categoryNum.toString(), textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
