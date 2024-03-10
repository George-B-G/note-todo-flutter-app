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
        return Scaffold(
          appBar: AppBar(
            title: const Text('Book'),
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
                      context: context, screenWidget: SettingScreen()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
