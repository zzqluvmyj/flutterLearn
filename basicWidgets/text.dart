import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'text',
      home: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: <Widget>[
                Text(
                  "hello world",
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Hello world' * 4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'hello world',
                  textScaleFactor: 1.5,
                ),
                Text(
                  '你好世界',
                  style: TextStyle(
                    color: Colors.red,
                    //比例大小和实际像素
                    //textScaleFactor: 1.5
                    fontSize: 30,
                    //行高,具体为大小乘以字体大小
                    height: 3,
                    fontFamily: '黑体',
                    background: Paint()..color = Colors.yellow,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.green,
                  ),
                ),
                Text('这是logo字体',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "logoti"
                ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.start,
                  child: Column(
                    children: <Widget>[
                      Text('继承文字样式'),
                      Text('不继承文字样式',style: TextStyle(
                        inherit: false,
                        color: Colors.yellow,
                      ),)
                    ],
                  )
                ),
              ],
            ),
          )),
    );
  }
}
