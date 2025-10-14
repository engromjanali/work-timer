import 'package:flutter/material.dart';
import 'package:work_timer/core/constants/extentions/w_extention.dart';
import 'package:work_timer/core/constants/my_color.dart';
import 'package:work_timer/core/constants/my_dimention.dart';

class WButton extends StatelessWidget {
  const WButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.buttonColor,
          borderRadius: BorderRadius.circular(MyDimension.borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Task",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MyColor.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ).padY(),
      ),
    );
  }
}
