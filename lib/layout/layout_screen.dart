import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/module/note_screen.dart';
import 'package:note_todo_app/module/settings_screen.dart';
import 'package:note_todo_app/module/todo_screen.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('All Content'),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                verticalSpace(heightValue: 3),
                Text(
                  'Todo & Notes',
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
                const Divider(),
                ListTile(
                  title: const Text('Notes'),
                  onTap: () =>
                      pushToPage(context: context, screenWidget: NoteScreen()),
                ),
                ListTile(
                  title: const Text('Todo'),
                  onTap: () =>
                      pushToPage(context: context, screenWidget: TodoScreen()),
                ),
                ListTile(
                  title: const Text('Settings'),
                  onTap: () => pushToPage(
                      context: context, screenWidget: const SettingScreen()),
                ),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.noteLst.isNotEmpty,
            fallback: (context) => const Center(
              child: Text('Try adding a new note or something todo'),
            ),
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpace(heightValue: 1),
                  screenSeparator(title: 'Notes', number: cubit.noteLst.length),
                  _buildListViewSeparator(
                    count: cubit.noteLst.length,
                    itemBuilderVal: (context, index) => buildItem(
                      textTitle: cubit.noteLst[index]['title'],
                      textSubtitle: cubit.noteLst[index]['description'],
                      id: cubit.noteLst[index]['id'],
                      image: File(cubit.noteLst[index]['image']),
                      status: "archive",
                      tableName: "notes",
                      context: context,
                    ),
                  ),
                  verticalSpace(heightValue: 1),
                  screenSeparator(
                      title: 'Notes Archive',
                      number: cubit.noteArchiveLst.length),
                  _buildListViewSeparator(
                    count: cubit.noteArchiveLst.length,
                    itemBuilderVal: (context, index) => buildItem(
                      textTitle: cubit.noteArchiveLst[index]['title'],
                      textSubtitle: cubit.noteArchiveLst[index]['description'],
                      id: cubit.noteArchiveLst[index]['id'],
                      image: File(cubit.noteArchiveLst[index]['image']),
                      status: "all",
                      tableName: "notes",
                      context: context,
                    ),
                  ),
                  verticalSpace(heightValue: 1),
                  screenSeparator(
                      title: 'Todo Tasks', number: cubit.todoTasksLst.length),
                  _buildListViewSeparator(
                    count: cubit.todoTasksLst.length,
                    itemBuilderVal: (context, index) => buildItem(
                      context: context,
                      status: "archive",
                      tableName: "todo",
                      isTodo: true,
                      id: cubit.todoTasksLst[index]['id'],
                      textTitle: cubit.todoTasksLst[index]['title'],
                      textSubtitle: cubit.todoTasksLst[index]['description'],
                      checkboxValue: cubit.todoTasksLst[index]['id'] ==
                              cubit.currentSelectedId
                          ? cubit.checkboxValue
                          : false,
                      onchangeValue: (value) => cubit.changeCheckboxValue(
                          value, cubit.todoTasksLst[index]['id']),
                    ),
                  ),
                  verticalSpace(heightValue: 1),
                  screenSeparator(
                      title: 'Todo Done', number: cubit.todoDoneLst.length),
                  _buildListViewSeparator(
                    count: cubit.todoDoneLst.length,
                    itemBuilderVal: (context, index) => buildItem(
                      context: context,
                      status: "all",
                      tableName: "todo",
                      isTodo: true,
                      id: cubit.todoDoneLst[index]['id'],
                      textTitle: cubit.todoDoneLst[index]['title'],
                      textSubtitle: cubit.todoDoneLst[index]['description'],
                      checkboxValue: cubit.todoDoneLst[index]['id'] ==
                              cubit.currentSelectedId
                          ? cubit.checkboxValue
                          : true,
                      onchangeValue: (value) => cubit.changeCheckboxValue(
                          value, cubit.todoDoneLst[index]['id']),
                    ),
                  ),
                  verticalSpace(heightValue: 1),
                  screenSeparator(
                      title: 'Todo Archive',
                      number: cubit.todoArchiveLst.length),
                  _buildListViewSeparator(
                    count: cubit.todoArchiveLst.length,
                    itemBuilderVal: (context, index) => buildItem(
                      context: context,
                      status: "new",
                      tableName: "todo",
                      isTodo: true,
                      id: cubit.todoArchiveLst[index]['id'],
                      textTitle: cubit.todoArchiveLst[index]['title'],
                      textSubtitle: cubit.todoArchiveLst[index]['description'],
                      checkboxValue: cubit.todoArchiveLst[index]['id'] ==
                              cubit.currentSelectedId
                          ? cubit.checkboxValue
                          : false,
                      onchangeValue: (value) => cubit.changeCheckboxValue(
                          value, cubit.todoArchiveLst[index]['id']),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListViewSeparator({
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
}
