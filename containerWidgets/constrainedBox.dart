import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        body: SizedBoxTest()
      ),
    );
  }
}


//宽度尽可能大,高度为50的限制盒子
//当有多重限制的时候会取父子中较大的值
class ConstrainedBoxTest extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: 50,
      ),
      child: Container(
        height: 5,
        color: Colors.red,
      ),
    );
  }
}

//sizedBox用于给子widget指定的宽高
//等价于在ConstrainedBox中设置constraints属性:BoxConstraints.tightFor(width: 80.0,height: 80.0),
//等价于设置constraints属性:BoxConstraints(minHeight: 80.0,maxHeight: 80.0,minWidth: 80.0,maxWidth: 80.0)
class SizedBoxTest extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Container(
        height: 5,
        color: Colors.red,
      ),
    );
  }
}