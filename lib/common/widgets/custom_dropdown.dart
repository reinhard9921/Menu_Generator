import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:menu_generator/constants/global_variables.dart';

class CustomDropDown extends StatelessWidget {
  final TextEditingController controller;
  final List<String> items;
  String hintText;
  CustomDropDown({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.05,
          bottom: height * 0.01,
          right: width * 0.05,
          top: height * 0.01),
      child: DropdownSearch<String>(
        popupProps: const PopupProps.modalBottomSheet(
            modalBottomSheetProps: ModalBottomSheetProps(
                elevation: 10,
                backgroundColor: GlobalVariables.backgroundColor),
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  hintStyle: const TextStyle(
                      fontFamily: GlobalVariables.fontName,
                      color: GlobalVariables.textTheme),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: GlobalVariables.textTheme,
                      )),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: GlobalVariables.textTheme,
                      ))),
            )),
        items: items,
        dropdownButtonProps:
            DropdownButtonProps(color: GlobalVariables.textTheme),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: const TextStyle(
              fontFamily: GlobalVariables.fontName,
              color: GlobalVariables.textTheme),
          dropdownSearchDecoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                  fontFamily: GlobalVariables.fontName,
                  color: GlobalVariables.textTheme),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(
                    color: GlobalVariables.textTheme,
                  )),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(
                    color: GlobalVariables.textTheme,
                  ))),
        ),
        onChanged: (value) {
          controller.text = value!;
          hintText = value;
        },
      ),
    );
  }
}
