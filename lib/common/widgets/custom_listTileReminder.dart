import 'dart:math';

import 'package:flutter/material.dart';
import 'package:menu_generator/common/widgets/custom_button.dart';
import 'package:menu_generator/common/widgets/networkImage.dart';
import 'package:menu_generator/constants/global_variables.dart';
import 'package:menu_generator/constants/utils.dart';
import 'package:menu_generator/models/Pricing.dart';

class CustomListTileReminder extends StatefulWidget {
  final Pricing plants;
  final void Function(Pricing) callback;

  CustomListTileReminder({
    required this.callback,
    Key? key,
    required this.plants,
  }) : super(key: key);

  @override
  State<CustomListTileReminder> createState() => _CustomListTileReminderState();
}

class _CustomListTileReminderState extends State<CustomListTileReminder> {
  bool _isShown = true;
  List<String> phrases = [
    'is a bit thirsty',
    'might need some water',
    'is thinking of a glass of water',
    'is missing some H2O'
  ];

  void waterPlant(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: Text('Are you sure you watered ${widget.plants.name}?', style: TextStyle(color: GlobalVariables.unselectedNavBarColor),),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      widget.callback(widget.plants);
                    });

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ListTile(
      // leading: Container(
      //   width: 50,
      //   height: 50,
      //   child: widget.plants.profileURL != ""
      //       ? CustomNetworkImage(
      //           networkUrl: widget.plants.profileURL,
      //         )
      //       : Icon(
      //           Icons.photo,
      //         ),
      // ),
      trailing: Container(
          width: width * 0.1,
          alignment: Alignment.centerRight,
          child: GestureDetector(
              onTap: () {
                _isShown == true ? waterPlant(context) : null;
              },
              child: const Icon(Icons.water_drop, color: Colors.blue))),
      title: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.plants.name} ${phrases[Random().nextInt(phrases.length)]}",
              style: TextStyle(fontFamily: GlobalVariables.fontName, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
