import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class NoteArchive extends StatelessWidget {
  const NoteArchive({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return buildCustomListview(
          lst: cubit.noteArchiveLst,
          lengthLst: cubit.noteArchiveLst.length,
          widgetBuilderItem: (context, index) => buildItem(
            textTitle: cubit.noteArchiveLst[index]['title'],
            textSubtitle: cubit.noteArchiveLst[index]['description'],
            id: cubit.noteArchiveLst[index]['id'],
            image: cubit.noteLst[index]['image'],
            status: "all",
            tableName: "notes",
            context: context,
          ),
        );
      },
    );
  }
}
