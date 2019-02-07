import 'package:flutter/material.dart';
import 'dart:math' as math;
//Transform可以在其子Widget绘制时对其应用一个矩阵变换（transformation），Matrix4是一个4D矩阵，通过它我们可以实现各种矩阵操作

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(appBar: AppBar(), body: TransformTest()),
    );
  }
}

class TransformTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            //一般变换,需要矩阵知识
            Positioned(
              left: 20,
              top: 10,
              child: Transform(
                alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                transform: Matrix4.skewY(-0.5), //沿着y轴倾斜0.5弧度
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.orange,
                  child: const Text('hello world'),
                ),
              ),
            ),
            //平移
            Positioned(
              left: 20,
              top: 90,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.translate(
                  offset: Offset(-20, -5),
                  child: Text('Hello world'),
                ),
              ),
            ),
            //旋转
            Positioned(
              left: 20,
              top: 150,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.rotate(
                  //旋转90度
                  angle: math.pi / 2,
                  child: Text("Hello world"),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 200,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Transform.scale(
                      scale: 1.5, //放大到1.5倍
                      child: Text("Hello world"))),
            ),
            //transform的变换的应用是在绘制阶段,不是在布局阶段
            //所以无论对子widget应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
            //RotatedBox变换是在layout阶段,会影响子widget的位置和大小
            Positioned(
              left: 20,
              top: 250,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                //将Transform.rotate换成RotatedBox
                child: RotatedBox(
                  quarterTurns: 1, //旋转90度(1/4圈)
                  child: Text("Hello world"),
                ),
              ),
            ),
          ],
        ));
  }
}
