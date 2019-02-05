import 'package:flutter/material.dart';
//StatelessWidget一样，StatefulWidget也是继承自widget类，并重写了createElement()方法，不同的是返回的Element 对象并不相同；
//另外StatefulWidget类中添加了一个新的接口createState()

//注意:该例子没搞明白,路由设置后还是有异常,这是将路由页面作为home实现的

//本例子中重写的方法添加了print是为了更清楚每一个阶段的相应的操作
//刚开始没有加载,后来点击按钮后加载,可以看出运行的过程
class CounterWidget extends StatefulWidget{
  const CounterWidget({Key key,this.initValue:0});
  final int initValue;
  @override
  _CounterWidgetState createState()=>_CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget>{
  int _counter;
  @override
  void initState(){
    super.initState();
    _counter=widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context){
    print("build");
    return Center(child: FlatButton(
      child: Text('$_counter'),
      onPressed: ()=>setState(()=>++_counter),
    ),);    
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget){
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void dispose(){
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble(){
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NewRoute"),
        ),
        body: Center(
          child: Text("This is new route"),
        ));
  }
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'stateful widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Scaffold(
        appBar: AppBar(title: Text('stateful widget'),),
        body:CounterWidget()));}
}
