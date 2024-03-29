import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:note_todo_app/shared/components/constant.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';

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
  Widget? suffixIconValue,
  Function()? onTapFunction,
  int maxLinesValue = 1,
}) =>
    TextFormField(
      minLines: 1,
      controller: textEditingController,
      cursorColor: darkBrownColor,
      maxLines: maxLinesValue,
      onTap: onTapFunction ?? () {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'must not be empty';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        isDense: true,
        hintText: hintTextValue,
        suffixIcon: suffixIconValue,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: darkBrownColor,
          ),
        ),
      ),
    );

Widget buildCustomListview({
  required List lst,
  required int lengthLst,
  required Function widgetBuilderItem,
}) =>
    ConditionalBuilder(
      condition: lst.isNotEmpty,
      fallback: (context) => const Center(
        child: Text('Try adding a new note or something todo'),
      ),
      builder: (context) => ListView.builder(
        itemCount: lengthLst,
        itemBuilder: (context, index) => widgetBuilderItem(context, index),
      ),
    );

Widget buildItem({
  required context,
  required int id,
  required String textTitle,
  required String textSubtitle,
  required String tableName,
  required String status,
  File? image,
  bool isTodo = false,
  bool checkboxValue = false,
  Function? longPress, 
  Function? onchangeValue,
}) {
  dynamic img = image == null || image.path.isEmpty
      ? const AssetImage('assets/images/splash.png')
      : FileImage(image);
  return Card(
    color: darkBrownColor,
    margin: const EdgeInsets.all(10),
    child: ListTile(
      onLongPress: () => longPress == null ? null : longPress(),
      leading: isTodo
          ? Checkbox(
              value: checkboxValue,
              onChanged: (value) => onchangeValue!(value) ?? (value) {},
              visualDensity: VisualDensity.compact,
            )
          : SizedBox(
              width: 50,
              height: 50,
              child: Image(
                image: img,
                fit: BoxFit.cover,
              ),
            ),
      title: Text(
        textTitle,
        style: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        textSubtitle,
        style: const TextStyle(
            fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w700),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => NoteTodoCubit.get(context).updateDataFunction(
              tableName: tableName,
              status: status,
              id: id,
            ),
            icon: const Icon(
              Icons.archive,
            ),
          ),
          IconButton(
            onPressed: () => NoteTodoCubit.get(context)
                .deleteDataFunction(tableName: tableName, id: id),
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade400,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget screenSeparator({
  required String title,
  int? number,
}) =>
    Container(
      height: 35,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5.5, left: 10),
      color: midBrownColor,
      child: Text(
        number == null ? title : '$number $title',
        style:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );

Widget buildListViewSeparator({
  required int count,
  required Widget? Function(BuildContext, int) itemBuilderVal,
  ScrollPhysics scrollPhysics = const NeverScrollableScrollPhysics(),
}) =>
    ListView.separated(
      shrinkWrap: true,
      physics: scrollPhysics,
      separatorBuilder: (context, index) => const Divider(),
      itemCount: count,
      itemBuilder: itemBuilderVal,
    );
