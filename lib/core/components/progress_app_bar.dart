import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

class ProgressAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int totalPart;
  final int currentPart;
  final Function? onArrowPressed;

  const ProgressAppBar({this.totalPart=5,this.currentPart=0,this.onArrowPressed,super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        AppBar(
            leading: IconButton(
                onPressed: () {
                  if(onArrowPressed!=null) onArrowPressed?.call();
                },
                icon: const Icon(Icons.arrow_back, color: themeBlueColor)),
            title: Row(
              children: getProgressBar(currentPart),
            )),
      ],
    );
  }

  List<Widget> getProgressBar(int current) {
    List<Widget> widgetList = [];

    for (int i = 0; i < totalPart; i++) {
      Color partColor = Color.fromARGB(255, 217, 217, 217);
      if (i == current) {
        partColor = Color.fromARGB(255, 147, 147, 147);
      }
      widgetList.add(Container(
        width: 51,
        height: 3,
        color: partColor,
      ));
    }

    return widgetList;
  }
}
