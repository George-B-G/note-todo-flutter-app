import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_todo_app/shared/components/components.dart';
import 'package:note_todo_app/shared/components/constant.dart';
import 'package:note_todo_app/shared/cubit/cubit.dart';
import 'package:note_todo_app/shared/cubit/state.dart';

class EditScreen extends StatelessWidget {
  EditScreen({
    super.key,
    required this.noteId,
    required this.noteStatus,
    required this.title,
    required this.description,
    required this.image,
  });

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String title, description, noteStatus;
  int noteId;
  File? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteTodoCubit, NoteTodoState>(
      listener: (context, state) {
        if (state is UpdateNoteDataState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = NoteTodoCubit.get(context);
        titleController.text = title;
        descriptionController.text = description;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Edit note'),
            actions: [
              IconButton(
                  onPressed: () => cubit.updateEditingNoteFunction(
                        tableName: 'notes',
                        status: noteStatus,
                        id: noteId,
                        title: titleController.text,
                        description: descriptionController.text,
                        image: cubit.imgPath,
                      ),
                  icon: const Icon(Icons.save))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                verticalSpace(heightValue: 2),
                defaultTextFormField(
                  textEditingController: titleController,
                  hintTextValue: 'Title',
                ),
                verticalSpace(heightValue: 2),
                defaultTextFormField(
                  textEditingController: descriptionController,
                  hintTextValue: 'Description',
                ),
                verticalSpace(heightValue: 2),
                Card(
                  child: SizedBox(
                      width: double.infinity,
                      height: screenDefaultSize * 25,
                      child: image == null || image!.path.isEmpty
                          ? const Center(
                              child: Text('This note has no image'),
                            )
                          : Image(
                              image: FileImage(image!),
                              fit: BoxFit.cover,
                            )),
                ),
                ListTile(
                  onTap: () => cubit.getImage(isCameraPhoto: true),
                  title: const Text(
                    'Open Camera',
                    textAlign: TextAlign.center,
                  ),
                  leading: const Icon(Icons.camera),
                ),
                ListTile(
                  onTap: () => cubit.getImage(isCameraPhoto: false),
                  title: const Text(
                    'Open Gallery',
                    textAlign: TextAlign.center,
                  ),
                  leading: const Icon(Icons.image),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
