import 'package:flutter/material.dart';

// Flutter中使用Stack和Positioned来实现绝对定位，Stack允许子widget堆叠，而Positioned可以给子widget定位（根据Stack的四个角）。

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        //通过ConstrainedBox来确保Stack占满屏幕
        //否则显示的字体会堆叠在一起,应该是说明stack不够大
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
            //fit:StackFit.expand,//没有定位的元素如何适应,StackFit.loose表示使用子widget的大小，StackFit.expand表示扩伸到Stack的大小。
            //overflow: Overflow.visible,//子元素超出后的显示方式
            //其中container是未定位的,而positioned是定位的
            children: <Widget>[
              Container(
                child:
                    Text("Hello world", style: TextStyle(color: Colors.white)),
                color: Colors.red,
              ),
              Positioned(
                left: 18.0,
                child: Text("I am Jack"),
              ),
              Positioned(
                top: 18.0,
                child: Text("Your friend"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
