import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class TodoMenu extends StatelessWidget {
  const TodoMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return buildCustomListview(
          lst: cubit.todoTasksLst,
          lengthLst: cubit.todoTasksLst.length,
          widgetBuilderItem: (context, index) => buildItem(
            context: context,
            status: "archive",
            tableName: "todo",
            isTodo: true,
            id: cubit.todoTasksLst[index]['id'],
            textTitle: cubit.todoTasksLst[index]['title'],
            textSubtitle: cubit.todoTasksLst[index]['description'],
            checkboxValue:
                cubit.todoTasksLst[index]['id'] == cubit.currentSelectedId
                    ? cubit.checkboxValue
                    : false,
            onchangeValue: (value) => cubit.changeCheckboxValue(
                value, cubit.todoTasksLst[index]['id']),
          ),
        );
      },
    );
  }
}
