import 'package:flutter/material.dart';

//原始指针事件,通常为触摸事件
//Flutter中可以使用Listener widget来监听原始触摸事件，它也是一个功能性widget。
//一次完整的事件分为三个阶段：手指按下、手指移动、和手指抬起，而更高级别的手势（如点击、双击、拖动等）都是基于这些原始事件的。

//listener是用于原始的指针事件的
//listener有behavior,behavior有三个枚举值
//deferToChild  指针事件在子widget上,父widget也会有响应
//opaque   不透明,当前widget事件无法穿透到底层
//translucent  透明,当前widget事件可以穿透到底层

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        body: PointerEventTest()
      ),
    );
  }
}

class PointerEventTest extends StatefulWidget {
  @override
  _PointerEventTestState createState() => _PointerEventTestState();
}

class _PointerEventTestState extends State<PointerEventTest> {
  PointerEvent _event;
  //PointerEvent的属性有
//position：它是鼠标相对于当对于全局坐标的偏移。
// delta：两次指针移动事件（PointerMoveEvent）的距离。
// pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
// orientation：指针移动方向，是一个角度值。
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: <Widget>[
        Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300,
        height: 150,
        //.?之前的值可以为null,不会报错,除此之外和.一样
        //a??b,a如果为空,则值为b,若a有值,取a的值
        child: Text(_event?.position.toString()??"",style:TextStyle(color:Colors.white)),
      ),
      onPointerDown: (PointerDownEvent event)=>setState(()=>_event=event),
      onPointerMove: (PointerMoveEvent event)=>setState(()=>_event=event),
      onPointerUp: (PointerUpEvent event)=>setState(()=>_event=event),
    ),
        Padding(
      padding: EdgeInsets.all(10),
      child:Container(),
    ),
    Stack(
  children: <Widget>[
    Listener(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(300.0, 200.0)),
        child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue)),
      ),
      onPointerDown: (event) => print("down0"),
    ),
    Listener(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(200.0, 100.0)),
        child: Center(child: Text("左上角200*100范围内非文本区域点击")),
      ),
      onPointerDown: (event) => print("down1"),
      //behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
    )
  ],
),
      ],
    );
    
  }
}