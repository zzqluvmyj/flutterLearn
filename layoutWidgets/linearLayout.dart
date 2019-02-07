import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(' hello world '),
                Text(' i am tom '),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(' hello world '),
                Text(' i am tom '),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(' hello world '),
                Text(' i am tom '),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Text(' hello world '),
                Text(' i am tom '),
              ],
            ),
            Container(
              width: 300,
              height: 100,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      child: Column(                      
                        mainAxisSize: MainAxisSize.max, //无效，内层Colum高度为实际高度
                        children: <Widget>[
                          Text("hello world "),
                          Text("I am Jack "),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 100,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
                  children: <Widget>[
                    Text("hello world "),
                    Text("I am Jack "),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
