import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.todoCurrentIndex,
            onTap: (index) => cubit.changeTodoIndex(index),
            items: cubit.bottomNavBarItemList,
          ),
          body: cubit.todoScreens[cubit.todoCurrentIndex],
        );
      },
    );
  }
}
