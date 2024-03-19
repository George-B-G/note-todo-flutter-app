import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class NoteMenu extends StatelessWidget {
  const NoteMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return buildCustomListview(
          lst: cubit.noteLst,
          lengthLst: cubit.noteLst.length,
          widgetBuilderItem: (context, index) => buildItem(
            textTitle: cubit.noteLst[index]['title'],
            textSubtitle: cubit.noteLst[index]['description'],
            id: cubit.noteLst[index]['id'],
            image: File(cubit.noteLst[index]['image']),
            status: "archive",
            tableName: "notes",
            context: context,
          ),
          // File: '/data/user/0/com.example.note_todo_app/cache/ec78a8fb-048a-4cdd-bd50-2f512c245702/wallpaperflare.com_wallpaper.jpg'
        );
      },
    );
  }
}
