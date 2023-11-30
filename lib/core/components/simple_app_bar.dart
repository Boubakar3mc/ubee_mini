import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';


class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final Function? onArrowPressed;

  const SimpleAppBar(this.title,{this.onArrowPressed,super.key});

  
  @override
  Widget build(BuildContext context) {
    return AppBar(
            leading: IconButton(
                onPressed: () {
                  if(onArrowPressed!=null) onArrowPressed?.call();
                },
                icon: const Icon(Icons.arrow_back, color: themeBlueColor)),
            title: Text(
              title,
              style:const TextStyle(
                  fontSize: 28,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 1.2),
            ),
            centerTitle: true,
            toolbarHeight: 100,
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);

}