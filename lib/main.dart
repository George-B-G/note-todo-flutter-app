import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/layout/layout_screen.dart';
import 'package:note_todo_app/shared/cubit/bloc_observer.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';
import 'package:note_todo_app/shared/style/screen_size_config.dart';
import 'package:note_todo_app/shared/style/style.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfiger().init(context); // to get the screen size
    return BlocProvider(
      create: (context) => NoteTodoCubit()..createDatabaseFuction(),
      child: BlocBuilder<NoteTodoCubit, NoteTodoState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Note and Todo',
            themeMode: ThemeMode.system,
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            home: const LayoutScreen(),
          );
        },
      ),
    );
  }
}
