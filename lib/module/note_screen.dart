import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.noteCurrentIndex,
            onTap: (index) => cubit.changeNoteIndex(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: 'archive')
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  scrollable: true,
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    IconButton(
                        onPressed: () {
                          cubit.imageURL = '';
                          if (formKey.currentState!.validate()) {
                            cubit
                                .insertInDatabaseFuction(
                                    tableName: 'notes',
                                    noteTitle: titleController.text,
                                    noteDescription: descriptionController.text,
                                    image: cubit.imageURL ?? '')
                                .then((value) {
                              cubit.changeTodoFloatingActionButton(
                                  isPressed: false);
                              Navigator.pop(context);
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.task_alt,
                          color: Colors.green,
                        )),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        )),
                  ],
                  title: Text(
                    'Adding new note',
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                  content: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultTextFormField(
                          textEditingController: titleController,
                          hintTextValue: 'Title',
                        ),
                        verticalSpace(heightValue: 1),
                        defaultTextFormField(
                          textEditingController: descriptionController,
                          hintTextValue: 'Description',
                          maxLinesValue: 5,
                        ),
                        verticalSpace(heightValue: 1),
                        ListTile(
                            onTap: () => cubit.getImage(isCameraPhoto: true),
                            trailing: const Icon(Icons.camera),
                            leading: Text(
                              'Open Camera',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium,
                            )),
                        ListTile(
                            onTap: () => cubit.getImage(isCameraPhoto: false),
                            trailing: const Icon(Icons.photo_album),
                            leading: Text('Open Gallery',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium)),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: cubit.noteScreens[cubit.noteCurrentIndex],
        );
      },
    );
  }
}
