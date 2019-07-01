import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> navigationBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    title: Text("Home"),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search),
    title: Text("Sources"),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.text_format),
    title: Text("Term"),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.merge_type),
    title: Text("Types"),
  ),
];