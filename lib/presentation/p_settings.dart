import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:work_timer/core/constants/extentions/w_extention.dart';
import 'package:work_timer/core/constants/my_color.dart';
import 'package:work_timer/core/constants/my_dimention.dart';
import 'package:work_timer/core/services/a_menager.dart';

class PSettings extends StatefulWidget {
  const PSettings({super.key});

  @override
  State<PSettings> createState() => _PSettingsState();
}

class _PSettingsState extends State<PSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          Divider(height: 1),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MyColor.buttonColor,
                      borderRadius: BorderRadius.circular(
                        MyDimension.boarderRadius,
                      ),
                    ),
                    height: 200.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundImage: AssetImage(AMenager.defaultProfile),
                        ).padY(),
                        Text(
                          "Md Romjan Ali",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(color: MyColor.white),
                        ),
                        Text(
                          "Hello, I am a flutter developer. now, i am a student at brahmanbaria ploytechnic institute. and i am doing internship a \"Appify Devs\". still now i have done few project's like Mess Management, Chess Game, ETC",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(color:Colors.black,),
                        ),
                      ],
                    ).padX(),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(100),
                        borderRadius: BorderRadius.circular(MyDimension.borderRadius),
                      ),
                      child: Text("Edit Profile", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: MyColor.white, fontWeight: FontWeight.bold),).padAll(),
                    ))
                ],
              ),

              // top items
              spaceY(val: 30),
              Container(
                decoration: BoxDecoration(
                  color: Color(0X0D000000),
                  borderRadius: BorderRadius.circular(MyDimension.borderRadius),
                ),
                child: Column(
                  children: [
                    _getItem(
                      leadingIcon: Icons.restart_alt,
                      label: "All Clear History",
                      onTap: () {

                      },
                    ),
                    _getItem(
                      leadingIcon: Icons.share,
                      label: "Share",
                      onTap: () {

                      },
                      isLast: true,
                    ),
                  ],
                ),
              ),

              // rest items
              spaceY(val: 30),
              Container(
                decoration: BoxDecoration(
                  color: Color(0X0D000000),
                  borderRadius: BorderRadius.circular(MyDimension.borderRadius),
                ),
                child: Column(
                  children: [
                    _getItem(
                      leadingIcon: Icons.question_mark_sharp,
                      label: "FAQ",
                      onTap: () {},
                    ),
                    _getItem(
                      leadingIcon: Icons.feedback,
                      label: "Feedback",
                      onTap: () {},
                    ),
                    _getItem(
                      leadingIcon: Icons.star_rate_rounded,
                      label: "Rate Us",
                      onTap: () {},
                    ),
                    _getItem(
                      leadingIcon: FontAwesomeIcons.solidFolderClosed,
                      label: "Terms of Use",
                      onTap: () {},
                    ),
                    _getItem(
                      leadingIcon: Icons.privacy_tip,
                      label: "Privacy Policy",
                      onTap: () {},
                    ),
                    _getItem(
                      leadingIcon: Icons.support_agent_outlined,
                      label: "Contact Support",
                      onTap: () {},
                      isLast: true,
                    ),
                  ],
                ),
              ),

              // version label
              Text(
                "Version 2.9.1",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ).padAll(),
        ],
      ),
    );
  }

  Widget _getItem({
    required IconData leadingIcon,
    required String label,
    required Function() onTap,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(leadingIcon),
              spaceX(),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Icon(Icons.keyboard_arrow_right_sharp, size: 22.h,),
            ],
          ).padAll(),
          if (!isLast) Divider(height: 1),
        ],
      ),
    );
  }
}
