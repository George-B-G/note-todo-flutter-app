import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/module/note_archive.dart';
import 'package:note_todo_app/module/note_menu.dart';
import 'package:note_todo_app/module/todo_archive.dart';
import 'package:note_todo_app/module/todo_done.dart';
import 'package:note_todo_app/module/todo_menu.dart';
import 'package:note_todo_app/shared/components/constant.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class NoteTodoCubit extends Cubit<NoteTodoState> {
  NoteTodoCubit() : super(InitialAppState());
  static NoteTodoCubit get(context) => BlocProvider.of(context);

  int noteCurrentIndex = 0, todoCurrentIndex = 0;
  List<Widget> noteScreens = [const NoteMenu(), const NoteArchive()];
  List<Widget> todoScreens = [
    const TodoMenu(),
    const TodoArchive(),
    const TodoDone()
  ];
  void changeNoteIndex(int index) {
    noteCurrentIndex = index;
    emit(ChangeNoteCurrentIndexState());
  }

  void changeTodoIndex(int index) {
    todoCurrentIndex = index;
    emit(ChangeTodoCurrentIndexState());
  }

  // used in todo screen in floating action button to show the showModalSheet
  bool isOpened = false;
  Icon todoFloatingButtonIcon = const Icon(Icons.add);
  void changeTodoFloatingActionButton({
    required bool isPressed,
  }) {
    // isOpened = !isOpened;
    isOpened = isPressed;
    todoFloatingButtonIcon =
        isOpened == true ? const Icon(Icons.done) : const Icon(Icons.add);
    emit(ChangeTodoFloatingButtonState());
  }

  List noteLst = [],
      noteArchiveLst = [],
      todoTasksLst = [],
      todoArchiveLst = [],
      todoDoneLst = [];
  void createDatabaseFuction() {
    localDatabase.initializeDatabaseFunction();
    getDataFunction('SELECT * FROM notes WHERE status="all"').then((value) {
      noteLst = value;
      emit(SelectDataState());
    });
    getDataFunction('SELECT * FROM notes WHERE status="archive"').then((value) {
      noteArchiveLst = value;
      emit(SelectDataState());
    });
    getDataFunction('SELECT * FROM todo WHERE status="new"').then((value) {
      todoTasksLst = value;
      emit(SelectDataState());
    });
    getDataFunction('SELECT * FROM todo WHERE status="archive"').then((value) {
      todoArchiveLst = value;
      emit(SelectDataState());
    });
    getDataFunction('SELECT * FROM todo WHERE status="done"').then((value) {
      todoDoneLst = value;
      emit(SelectDataState());
    });
    emit(CreateDatabaseState());
  }

  Future getDataFunction(String sql) async {
    emit(SelectDataLoadingState());
    return await localDatabase.readData(sql);
  }

  Future insertInDatabaseFuction(
      {required String tableName,
      String? todoTitle,
      noteTitle,
      noteDescription,
      todoDescription,
      String? time,
      date,
      image}) async {
    if (tableName == 'todo') {
      return await localDatabase.insertData('''
                INSERT INTO $tableName (title,description,time,date,status)
                VALUES(
                  "$todoTitle",
                  "$todoDescription",
                  "$time",
                  "$date",
                  "new"
                  )
                ''').then((value) {
        getDataFunction('SELECT * FROM $tableName  WHERE status="new"')
            .then((value) {
          todoTasksLst = value;
          emit(SelectDataState());
        });
        emit(InsertDataState());
      });
    } else if (tableName == 'notes') {
      return await localDatabase.insertData('''
                INSERT INTO $tableName (title,description,image,status)
                VALUES(
                  "$noteTitle",
                  "$noteDescription",
                  "$image",
                  "all"
                  )
                ''').then((value) {
        emit(InsertDataState());
        getDataFunction('SELECT * FROM $tableName  WHERE status="all" ')
            .then((value) {
          noteLst = value;
          emit(SelectDataState());
        });
      });
    }
  }

  void updateDataFunction({
    required String tableName,
    required String status,
    required int id,
  }) {
    localDatabase
        .updateData('UPDATE $tableName SET status="$status" WHERE id=$id')
        .then((value) {
      getDataFunction('SELECT * FROM notes WHERE status="all"').then((value) {
        noteLst = value;
        emit(SelectDataState());
      });
      getDataFunction('SELECT * FROM notes WHERE status="archive"')
          .then((value) {
        noteArchiveLst = value;
        emit(SelectDataState());
      });
      getDataFunction('SELECT * FROM todo WHERE status="new"').then((value) {
        todoTasksLst = value;
        emit(SelectDataState());
      });
      getDataFunction('SELECT * FROM todo WHERE status="done"').then((value) {
        todoDoneLst = value;
        emit(SelectDataState());
      });
      getDataFunction('SELECT * FROM todo WHERE status="archive"')
          .then((value) {
        todoArchiveLst = value;
        emit(SelectDataState());
      });
      emit(UpdateDataState());
    });
  }

  void updateEditingNoteFunction({
    required String tableName,
    required String status,
    required String title,
    required String description,
    required String image,
    required int id,
  }) async {
    await localDatabase
        .updateData(
            'UPDATE notes SET title="$title", description="$description", image="$image", status="$status" WHERE id=$id')
        .then((value) {
      getDataFunction('SELECT * FROM notes WHERE status="all"').then((value) {
        noteLst = value;
        emit(SelectDataState());
      });
      getDataFunction('SELECT * FROM notes WHERE status="archive"')
          .then((value) {
        noteArchiveLst = value;
        emit(SelectDataState());
      });
      imgPath = '';
      emit(UpdateNoteDataState());
    });
  }

  void deleteDataFunction({
    required int id,
    required String tableName,
  }) {
    localDatabase
        .deleteData('DELETE FROM $tableName WHERE id=$id')
        .then((value) {
      getDataFunction('SELECT * FROM notes WHERE status="all"').then((value) {
        noteLst = value;
        emit(SelectDataState());
      });
      getDataFunction('SELECT * FROM notes WHERE status="archive"')
          .then((value) {
        noteArchiveLst = value;
        emit(SelectDataState());
      });
      getDataFunction('SELECT * FROM todo WHERE status="new"').then((value) {
        todoTasksLst = value;
        emit(SelectDataState());
      });
      getDataFunction('SELECT * FROM todo WHERE status="done"').then((value) {
        todoDoneLst = value;
        emit(SelectDataState());
      });
      getDataFunction('SELECT * FROM todo WHERE status="archive"')
          .then((value) {
        todoArchiveLst = value;
        emit(SelectDataState());
      });
      emit(DeleteDataState());
    });
  }

  void deleteDatabaseData() {
    localDatabase.deleteDatabaseFunction();
    emit(DeleteDatabaseState());
  }

  bool checkboxValue = false;
  int currentSelectedId = 0;
  void changeCheckboxValue(bool value, int taskId) {
    checkboxValue = value;
    currentSelectedId = taskId;
    checkboxValue == true
        ? updateDataFunction(
            tableName: "todo",
            status: "done",
            id: taskId,
          )
        : updateDataFunction(
            tableName: "todo",
            status: "new",
            id: taskId,
          );
    emit(ChangeCheckboxValueState());
  }

  String imgPath = '';
  getImage({
    required bool isCameraPhoto,
  }) async {
    emit(ImagePickerLoadingState());
    final ImagePicker picker = ImagePicker();
    if (isCameraPhoto == false) {
      XFile? imageGallery = await picker.pickImage(source: ImageSource.gallery);
      if (imageGallery != null) {
        imgPath = imageGallery.path;
        emit(ImagePickerSuccessState());
      } else {
        imgPath = '';
      }
    } else if (isCameraPhoto == true) {
      XFile? photoCamera = await picker.pickImage(source: ImageSource.camera);
      if (photoCamera != null) {
        imgPath = photoCamera.path;
        emit(ImagePickerSuccessState());
      } else {
        imgPath = '';
      }
    }
  }

  String groupValue = 'System';
  List<Map> themes = [
    {
      'name': 'System theme',
      'value': 'System',
    },
    {
      'name': 'Light theme',
      'value': 'Light',
    },
    {
      'name': 'Dark theme',
      'value': 'Dark',
    },
  ];
  void changeThemeMode(String val) {
    groupValue = val;
    if (val == 'System') {
      themeMode = ThemeMode.system;
    } else if (val == 'Light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    emit(ChangeThemeModeState());
  }
}
