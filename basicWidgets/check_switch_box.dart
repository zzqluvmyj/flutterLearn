import 'package:flutter/material.dart';

//单选框和复选框,因为继承自statelesswidget,不会保存状态
//所以由父组件管理状态

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        body: SwitchAndCheckBoxTestRoute()
      ),
    );
  }
}

class SwitchAndCheckBoxTestRoute extends StatefulWidget{
  @override
  _SwitchAndCheckBoxTestRouteState createState()=>_SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState extends State<SwitchAndCheckBoxTestRoute>{
  bool _switchSelected=true;
  bool _checkboxSelected=true;
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Switch(
          value: _switchSelected,
          onChanged: (value){
            setState(() {
             _switchSelected=value; 
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          onChanged: (value){
            setState(() {
             _checkboxSelected=value; 
            });
          },
          )
      ],
      );
  }
}

