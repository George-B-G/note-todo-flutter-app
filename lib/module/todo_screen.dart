import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/components/constant.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Todo'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isOpened == true) {
                if (formKey.currentState?.mounted != null) {
                  if (formKey.currentState!.validate()) {
                    cubit
                        .insertInDatabaseFuction(
                            tableName: 'todo',
                            todoTitle: titleController.text,
                            todoDescription: descriptionController.text,
                            time: timeController.text,
                            date: dateController.text)
                        .then((value) {
                      cubit.changeTodoFloatingActionButton(isPressed: false);
                      Navigator.pop(context);
                    });
                  }
                }
              } else {
                cubit.changeTodoFloatingActionButton(isPressed: true);
                scaffoldKey.currentState!
                    .showBottomSheet((context) => Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                verticalSpace(heightValue: 3.5),
                                defaultTextFormField(
                                    textEditingController: titleController,
                                    hintTextValue: 'Title'),
                                verticalSpace(heightValue: 1),
                                defaultTextFormField(
                                    textEditingController:
                                        descriptionController,
                                    hintTextValue: 'Description',
                                    maxLinesValue: 2),
                                verticalSpace(heightValue: 1),
                                defaultTextFormField(
                                  textEditingController: timeController,
                                  hintTextValue: 'Time',
                                  suffixIconValue: const Icon(
                                    Icons.watch_later,
                                    size: 25,
                                  ),
                                  onTapFunction: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) => timeController.text =
                                            value!.format(context).toString());
                                  },
                                ),
                                verticalSpace(heightValue: 1),
                                defaultTextFormField(
                                  textEditingController: dateController,
                                  hintTextValue: 'Date',
                                  suffixIconValue: const Icon(
                                    Icons.date_range,
                                    size: 25,
                                  ),
                                  onTapFunction: () {
                                    showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2001 - 1 - 1),
                                      lastDate: DateTime.parse("2030-12-12"),
                                      initialDate: DateTime.now(),
                                    ).then((value) => dateController.text =
                                        DateFormat.yMMMd()
                                            .format(value!)
                                            .toString());
                                  },
                                ),
                                verticalSpace(heightValue: 2),
                              ],
                            ),
                          ),
                        ))
                    .closed
                    .then((value) =>
                        cubit.changeTodoFloatingActionButton(isPressed: false));
              }
            },
            child: cubit.todoFloatingButtonIcon,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.todoCurrentIndex,
            onTap: (index) => cubit.changeTodoIndex(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: 'archive'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done_all), label: 'done'),
            ],
          ),
          body: cubit.todoScreens[cubit.todoCurrentIndex],
        );
      },
    );
  }
}
