import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

class ExpandableCard extends StatefulWidget{
  final String title;
  final List<String> texts;

  const ExpandableCard({super.key,required this.title,required this.texts});

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Card(
              borderOnForeground: true,
              color: Colors.white,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  leading: const Icon(
                    Icons.info,
                    color: themeBlueColor,
                  ),
                  title: Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          color: themeBlueColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  trailing: Icon(
                      _customTileExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: themeBlueColor),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _customTileExpanded = expanded;
                    });
                  },
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:_getTexts(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _getTexts(){
    final texts = <Widget>[];
    for(var i = 0; i < widget.texts.length; i++){
      texts.add(
        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '\u2022',
                                style: TextStyle(
                                    fontSize: 20,
                                    height: 1,
                                    color: themeBlueColor),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Text(
                                widget.texts[i],
                                style: const TextStyle(
                                    color: themeBlueColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              )),
                            ],
                          ),
      );
    }

    return texts;
  }
}