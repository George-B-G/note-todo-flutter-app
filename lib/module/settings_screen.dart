import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/components/constant.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Column(
            children: [
              screenSeparator(title: 'Theme', number: cubit.themes.length),
              buildListViewSeparator(
                count: cubit.themes.length,
                itemBuilderVal: (context, index) => RadioListTile(
                  title: Text('${cubit.themes[index]['name']}'),
                  value: cubit.themes[index]['value'],
                  groupValue: cubit.groupValue,
                  onChanged: (value) => cubit.changeThemeMode(value),
                  selected: cubit.themes[index] == index ? true : false,
                ),
              ),
              screenSeparator(
                title: 'Settings',
              ),
              ElevatedButton.icon(
                onPressed: () => cubit.deleteDatabaseData(),
                icon: const Icon(Icons.delete_forever),
                label: const Text('Delete database'),
              )
            ],
          ),
        );
      },
    );
  }
}
