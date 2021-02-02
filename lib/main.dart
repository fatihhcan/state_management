import 'package:flutter/material.dart';
import 'package:state_management/bloc/bloc_cats_view.dart';
import 'package:state_management/mobx/cat_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: CatView());
  }
}
