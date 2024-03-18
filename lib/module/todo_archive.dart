import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class TodoArchive extends StatelessWidget {
  const TodoArchive({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return buildCustomListview(
          lst: cubit.todoArchiveLst,
          lengthLst: cubit.todoArchiveLst.length,
          widgetBuilderItem: (context, index) => buildItem(
            context: context,
            status: "new",
            tableName: "todo",
            isTodo: true,
            id: cubit.todoArchiveLst[index]['id'],
            textTitle: cubit.todoArchiveLst[index]['title'],
            textSubtitle: cubit.todoArchiveLst[index]['description'],
            checkboxValue:
                cubit.todoArchiveLst[index]['id'] == cubit.currentSelectedId
                    ? cubit.checkboxValue
                    : false,
            onchangeValue: (value) => cubit.changeCheckboxValue(
                value, cubit.todoArchiveLst[index]['id']),
          ),
        );
      },
    );
  }
}
