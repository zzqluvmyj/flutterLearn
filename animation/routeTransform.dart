import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//路由过渡动画,详见API文档

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        body: RouteTransformTest(),
      ),
    );
  }
}

class RouteTransformTest extends StatefulWidget {
  @override
  _RouteTransformTestState createState() => _RouteTransformTestState();
}

class _RouteTransformTestState extends State<RouteTransformTest> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        RaisedButton(
          child: Text('route A'),
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(
                builder: (context){
                  return PageA();
                }
            ));
          },
        ),
      ],
    );
  }
}

class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
      child: RaisedButton(
        child: Text('route B'),
        onPressed: (){
          Navigator.push(context,PageRouteBuilder(
              transitionDuration:Duration(seconds: 1),
              pageBuilder: (BuildContext context,Animation animation,Animation secondaryAnimation){
                 return new FadeTransition( //使用渐隐渐入过渡, 
          opacity: animation,
          child: PageB() //路由B
        );
              }
          )
           

          );
        },
      ),
    ),
    );
  }
}
class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child:Text('please return')
    ),);
  }
}