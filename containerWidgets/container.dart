import 'package:flutter/material.dart';

//Container是我们要介绍的最后一个容器类widget，它本身不对应具体的RenderObject，它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等widget的一个组合widget。所以我们只需通过一个Container可以实现同时需要装饰、变换、限制的场景。
//color和decoration互斥

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(appBar: AppBar(), body: ContainerTest()),
    );
  }
}

class ContainerTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //margin: EdgeInsets.only(top: 50, left: 120),//容器外留白
        //padding: const EdgeInsets.all(30),//容器内留白
        constraints: BoxConstraints.tightFor(width: 200, height: 150),
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.red, Colors.orange],
                center: Alignment.topLeft,
                radius: 0.98),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54, offset: Offset(2, 2), blurRadius: 4),
            ]),
            transform: Matrix4.rotationZ(0.2),
            alignment: Alignment.center,//文字居中
            child: Text('5.20',style:TextStyle(color:Colors.white,fontSize:40)),
      ),
    );
  }
}
