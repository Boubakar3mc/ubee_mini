import 'package:flutter/material.dart';
import 'package:ubee_mini/core/components/progress_app_bar.dart';
import 'package:ubee_mini/core/components/top_page_title.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

class AddPictureView extends StatefulWidget {
  const AddPictureView({super.key});

  @override
  State<AddPictureView> createState() => _AddPictureViewState();
}

class _AddPictureViewState extends State<AddPictureView> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProgressAppBar(
        currentPart: 3,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const TopPageTitle(title: 'Add a profile picture'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.012,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: const Text(
              'Show-off your professional look and improve your chances of getting hired.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: themeDarkColor),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.055,
          ),
          const Image(image: AssetImage('images/add_a_photo.webp')),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.037,
          ),
          SizedBox(
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
                  title: const Center(
                    child: Text(
                      'Picture guidelines',
                      style: TextStyle(
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\u2022',
                                style: TextStyle(
                                    fontSize: 20,
                                    height: 1,
                                    color: themeBlueColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Text(
                                'Show your best smile',
                                style: TextStyle(
                                    color: themeBlueColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              )),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\u2022',
                                style: TextStyle(
                                    fontSize: 20,
                                    height: 1,
                                    color: themeBlueColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Text(
                                'Center yourself in frame, from the shoulders up.',
                                style: TextStyle(
                                    color: themeBlueColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              )),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\u2022',
                                style: TextStyle(
                                    fontSize: 20,
                                    height: 1,
                                    color: themeBlueColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Text(
                                'Make sure your face is visible, well lit and in focus',
                                style: TextStyle(
                                    color: themeBlueColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.592,
            height: MediaQuery.of(context).size.height * 0.06,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        width: 2.0, color: themeLightBlueColor)),
                onPressed: () {},
                child: const Text('Select from library',
                    style: TextStyle(
                        color: themeLightBlueColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.592,
            height: MediaQuery.of(context).size.height * 0.06,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        width: 2.0, color: themeDarkColor)),
                onPressed: () {},
                child: const Text('Go to camera',
                    style: TextStyle(
                        color: themeDarkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.074,
          )
        ]),
      ),
    );
  }
}
