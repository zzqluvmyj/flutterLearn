import 'package:flutter/material.dart';

//在Flutter中，Widget的功能是“描述一个UI元素的配置数据”，它就是说，Widget其实并不是表示最终绘制在设备屏幕上的显示元素，
//而只是显示元素的一个配置数据。实际上，Flutter中真正代表屏幕上显示元素的类是Element，也就是说Widget只是描述Element的一个配置

//statelessWidget继承自Widget,重写了createElement方法

class MyApp extends StatelessWidget {
  // 页面构建的重写
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //主页也是一个组件
        home: Scaffold(
          appBar: AppBar(
            title: Text('stateless widget'),
          ),
          body: Center(
            child: Echo(
              text: 'hello world',
            ),
          ),
        ));
  }
}
//一个回显字符串的Echo widget。
class Echo extends StatelessWidget {
  const Echo(
      {Key key, @required this.text, this.backgroundColor = Colors.green})
      : super(key: key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}
