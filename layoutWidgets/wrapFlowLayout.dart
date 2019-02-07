import 'package:flutter/material.dart';

//wrap的属性,除此之外和流失布局类似
// spacing：主轴方向子widget的间距
// runSpacing：纵轴方向的间距
// runAlignment：纵轴方向的对齐方式

//flow过于复杂,但性能好,足够灵活
//不能自适应子widget大小，必须通过指定父容器大小或实现TestFlowDelegate的getSize返回固定大小。

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        body: FlowTest()
      ),
    );
  }
}

class WrapTest extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 8,//主轴方向间距
      runSpacing: 4,//纵轴方向间距
      alignment: WrapAlignment.center,//主轴对齐方式
      runAlignment: WrapAlignment.start,//纵轴对齐方式
      children: <Widget>[
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue,child: Text('A'),),
          label: Text('hamilton'),
        ),
                Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue,child: Text('M'),),
          label: Text('lafayette'),
        ),
                Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue,child: Text('H'),),
          label: Text('mulligan'),
        ),
                Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue,child: Text('J'),),
          label: Text('lautens'),
        ),
      ],
    );
  }
}

class FlowTest extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: TestFlowDelegate(margin:EdgeInsets.all(10)),
      children: <Widget>[
       new Container(width: 80.0, height:80.0, color: Colors.red,),
    new Container(width: 80.0, height:80.0, color: Colors.green,),
    new Container(width: 80.0, height:80.0, color: Colors.blue,),
    new Container(width: 80.0, height:80.0,  color: Colors.yellow,),
    new Container(width: 80.0, height:80.0, color: Colors.brown,),
    new Container(width: 80.0, height:80.0,  color: Colors.purple,),
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  TestFlowDelegate({this.margin});
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置  
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)  
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
         x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  getSize(BoxConstraints constraints){
    //指定Flow的大小  
    return Size(double.infinity,200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}