import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

class ProgressAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int totalPart;
  final int currentPart;
  final Function? onArrowPressed;
  final bool noArrow;

  const ProgressAppBar(
      {this.totalPart = 5,
      this.currentPart = 0,
      this.onArrowPressed,
      this.noArrow = false,
      super.key});

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
            leading: _getArrow(),
            title: Row(
              children: _getProgressBar(currentPart),
            )),
      ],
    );
  }

  List<Widget> _getProgressBar(int current) {
    List<Widget> widgetList = [];

    for (int i = 0; i < totalPart; i++) {
      Color partColor = const Color.fromARGB(255, 217, 217, 217);
      if (i == current) {
        partColor = const Color.fromARGB(255, 147, 147, 147);
      }
      widgetList.add(Container(
        width: 51,
        height: 3,
        color: partColor,
      ));
    }

    return widgetList;
  }

  Widget? _getArrow() {
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: noArrow?false:true,
      child: IconButton(
          onPressed: () {
            if (onArrowPressed != null) onArrowPressed?.call();
          },
          icon: const Icon(Icons.arrow_back, color: themeBlueColor)),
    );
  }
}
