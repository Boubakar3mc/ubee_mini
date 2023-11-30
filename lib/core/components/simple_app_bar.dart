import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

AppBar simpleAppBar(String title,{Function? onArrowPressed}){
  return AppBar(
            leading: IconButton(
                onPressed: () {
                  if(onArrowPressed!=null) onArrowPressed.call();
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