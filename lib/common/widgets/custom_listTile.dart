import 'package:flutter/material.dart';
import 'package:menu_generator/common/widgets/custom_button.dart';
import 'package:menu_generator/common/widgets/networkImage.dart';
import 'package:menu_generator/constants/global_variables.dart';
import 'package:menu_generator/models/Pricing.dart';

class CustomListTile extends StatelessWidget {
  final List<Pricing> plants;
  VoidCallback callback;

  CustomListTile({
    required this.callback,
    Key? key,
    required this.plants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToPlantDetail() {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => PlantDetailScreen(callback: callback),
      //   ),
      // );
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.78,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: plants?.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: height * 0.1,
                    child: ListTile(
                      // leading: Container(
                      //   width: 50,
                      //   height: 50,
                      //   child: plants[index].profileURL != ""
                      //       ? CustomNetworkImage(
                      //           networkUrl: plants[index].profileURL,
                      //         )
                      //       : Icon(
                      //           Icons.photo,
                      //         ),
                      // ),
                      trailing: Container(
                          width: width * 0.1,
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.nature, color: Colors.green)),
                      title: Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plants[index].name,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: GlobalVariables.fontName,
                                  color: GlobalVariables.textTheme),
                              textAlign: TextAlign.start,
                            ),
                            Text(plants[index].price,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: GlobalVariables.fontName,
                                    color: GlobalVariables.textTheme),
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PlantDetailScreen(
                        //         plant: plants[index], callback: callback),
                        //   ),
                        // );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
