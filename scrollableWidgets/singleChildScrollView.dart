import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home:Scaffold(
        appBar: AppBar(),
        body:  SingleChildScrollViewTestRoute(),
      )    
    );
  }
}

class SingleChildScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
      child: SingleChildScrollView(
        physics: ScrollPhysics(
          //滚动到底后的效果,这个为ios效果,弹性效果
          parent: BouncingScrollPhysics()
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column( 
            //动态创建一个List<Widget>  
            children: str.split("") 
                //每一个字母都用一个Text显示,字体为原来的两倍
                .map((c) => Text(c, textScaleFactor: 2.0,)) 
                .toList(),
          ),
        ),
      ),
    );
  }
}