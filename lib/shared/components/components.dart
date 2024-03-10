import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_todo_app/shared/components/constant.dart';

Widget verticalSpace({required double heightValue}) => SizedBox(
      height: screenDefaultSize * heightValue,
    );
Widget horizontalSpace({required double widthValue}) => SizedBox(
      width: screenDefaultSize * widthValue,
    );

pushToPage({required context, required screenWidget}) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screenWidget,
    ));

Widget defaultTextFormField({
  required TextEditingController textEditingController,
  required String hintTextValue,
  int maxLinesValue = 1,
}) =>
    TextFormField(
      controller: textEditingController,
      cursorColor: darkBrownColor,
      maxLines: maxLinesValue,
      minLines: 1,
      decoration: InputDecoration(
        hintText: hintTextValue,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: darkBrownColor,
          ),
        ),
      ),
    );
