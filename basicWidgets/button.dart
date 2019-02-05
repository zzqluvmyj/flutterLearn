import 'package:flutter/material.dart';

//查看api文档来自定义按钮外形
//不用继承,预设的内容已经很多了

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gsgg',
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('RaisedButton 漂浮按钮'),
              onPressed: () => print("clicked"),
              highlightColor: Colors.red,
              highlightElevation: 20,
            ),
            FlatButton(
              child: Text('Flatbuttom 扁平按钮'),
              onPressed: () => print('clicked'),
              color: Colors.green,
              highlightColor: Colors.blue,
              colorBrightness: Brightness.dark,
              splashColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

            ),
            OutlineButton(
                onPressed: () => print('clicked'),
                child: Text('outlineButton 边框按钮')),
            IconButton(
              onPressed: () => print("clicked"),
              icon: Icon(Icons.adjust),
            )
          ],
        ),
      ),
    );
  }
}


