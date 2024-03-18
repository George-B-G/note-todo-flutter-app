import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class TodoDone extends StatelessWidget {
  const TodoDone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return buildCustomListview(
          lst: cubit.todoDoneLst,
          lengthLst: cubit.todoDoneLst.length,
          widgetBuilderItem: (context, index) => buildItem(
            context: context,
            status: "all",
            tableName: "todo",
            isTodo: true,
            id: cubit.todoDoneLst[index]['id'],
            textTitle: cubit.todoDoneLst[index]['title'],
            textSubtitle: cubit.todoDoneLst[index]['description'],
            checkboxValue:
                cubit.todoDoneLst[index]['id'] == cubit.currentSelectedId
                    ? cubit.checkboxValue
                    : true,
            onchangeValue: (value) => cubit.changeCheckboxValue(
                value, cubit.todoDoneLst[index]['id']),
          ),
        );
      },
    );
  }
}
