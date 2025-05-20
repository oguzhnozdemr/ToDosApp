import 'package:flutter/material.dart';


import '../tools/app_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  MyAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: TextStyle(color: textColor2,fontSize: 26,fontFamily: "Oswald"),),
      centerTitle: true,
      backgroundColor: mainColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);//kToolbarHeight
}