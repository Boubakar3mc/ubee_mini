import 'package:flutter/material.dart';
import 'package:ubee_mini/core/components/top_page_title.dart';
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
            title: TopPageTitle(title:title),
            centerTitle: true,
            toolbarHeight: 100,
          );
  }

  @override
  Size get preferredSize =>const Size.fromHeight(100);

}