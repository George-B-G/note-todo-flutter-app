import 'package:flutter/material.dart';
import 'package:note_todo_app/model/local_database.dart';
import 'package:note_todo_app/shared/style/screen_size_config.dart';

LocalDatabase localDatabase = LocalDatabase();

double screenDefaultSize = ScreenSizeConfiger.defaultSize!;

// for light theme colors
Color lightBrownColor = const Color(0xffFFE8D6);
Color midBrownColor = const Color(0xffDDBEA9);
Color darkBrownColor = const Color(0xffCB997E);
// for dark theme colors
Color darkThemeFontColor = const Color(0xffe4c5b6);
Color darkThemeBackgroundColor = const Color(0xff221e1c);
Color darkThemeForegroundColor = const Color(0xff373331);
