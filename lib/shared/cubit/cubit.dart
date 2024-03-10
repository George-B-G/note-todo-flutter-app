import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/module/note_archive.dart';
import 'package:note_todo_app/module/note_done.dart';
import 'package:note_todo_app/module/note_menu.dart';
import 'package:note_todo_app/module/todo_archive.dart';
import 'package:note_todo_app/module/todo_done.dart';
import 'package:note_todo_app/module/todo_menu.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class NoteTodoCubit extends Cubit<NoteTodoState> {
  NoteTodoCubit() : super(InitialAppState());
  static NoteTodoCubit get(context) => BlocProvider.of(context);

  int noteCurrentIndex = 0, todoCurrentIndex = 0;
  List<BottomNavigationBarItem> bottomNavBarItemList = const [
    BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'tasks'),
    BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'archive'),
    BottomNavigationBarItem(icon: Icon(Icons.done_all), label: 'done'),
  ];
  List<Widget> noteScreens = [NoteMenu(), NoteArchive(), NoteDone()];
  List<Widget> todoScreens = [TodoMenu(), TodoArchive(), TodoDone()];
  void changeNoteIndex(int index) {
    noteCurrentIndex = index;
    emit(ChangeNoteCurrentIndexState());
  }

  void changeTodoIndex(int index) {
    todoCurrentIndex = index;
    emit(ChangeTodoCurrentIndexState());
  }
}
