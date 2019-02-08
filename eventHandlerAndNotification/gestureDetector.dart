import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//手势识别

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        body: GestureConflictTestRoute()
      ),
    );
  }
}

//点击,长按,双击,
class GestureDetectorTest extends StatefulWidget {
  @override
  _GestureDetectorTestState createState() => _GestureDetectorTestState();
}

class _GestureDetectorTestState extends State<GestureDetectorTest> {
  String _operation = "No Gesture detected!";
  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[

        GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200.0, 
          height: 100.0,
          child: Text(_operation,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText("Tap"),//点击
        onDoubleTap: () => updateText("DoubleTap"), //双击
        onLongPress: () => updateText("LongPress"), //长按
      ),     
      ],
    );
  }
}

//拖动,滑动
//可以改为单一方向拖动
class _Drag extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}
class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0;//距左边的偏移
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e){
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}

//缩放,完整的缩放见动画一章



//GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，
//而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势，
//GestureDetector直接可以接收一个子Widget。
//GestureRecognizer是一个抽象类，
//一种手势的识别器对应一个GestureRecognizer的子类，
//Flutter实现了丰富的手势识别器，我们可以直接使用。
//假设我们要给一段富文本（RichText）的不同部分分别添加点击事件处理器，但是TextSpan并不是一个Widget，这时我们不能用GestureDetector，但TextSpan有一个recognizer属性，它可以接收一个GestureRecognizer，假设我们在点击时给文本变色:

class GestureRecognizerTestRoute extends StatefulWidget {
  @override
  _GestureRecognizerTestRouteState createState() => _GestureRecognizerTestRouteState();
}

class _GestureRecognizerTestRouteState
    extends State<GestureRecognizerTestRoute> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
     //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
          TextSpan(
              children: [
                TextSpan(text: "你好世界"),
                TextSpan(
                  text: "点我变色",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: _toggle ? Colors.blue : Colors.red
                  ),
                  recognizer: _tapGestureRecognizer
                    ..onTap = () {
                      setState(() {
                        _toggle = !_toggle;
                      });
                    },
                ),
                TextSpan(text: "你好世界"),
              ]
          )
      ),
    );
  }
}


//手势竞争
//实际上Flutter中的手势识别引入了一个Arena的概念，Arena直译为“竞技场”的意思，每一个手势识别器（GestureRecognizer）都是一个“竞争者”（GestureArenaMember），当发生滑动事件时，他们都要在“竞技场”去竞争本次事件的处理权，而最终只有一个“竞争者”会胜出(win)。

//示例
//同时识别水平和垂直方向的拖动手势，当用户按下手指时就会触发竞争（水平方向和垂直方向），一旦某个方向“获胜”，则直到当次拖动手势结束都会沿着该方向移动。
class BothDirectionTestRoute extends StatefulWidget {
  @override
  BothDirectionTestRouteState createState() =>
      new BothDirectionTestRouteState();
}

class BothDirectionTestRouteState extends State<BothDirectionTestRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }
}

//手势冲突和解决
//具体见书籍
class GestureConflictTestRoute extends StatefulWidget {
  @override
  _GestureConflictTestRouteState createState() => _GestureConflictTestRouteState();
}
class _GestureConflictTestRouteState extends State<GestureConflictTestRoute> {
  double _left = 0.0;
  double _leftB=0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _left,
          child: GestureDetector(
              child: CircleAvatar(child: Text("A")), //要拖动和点击的widget
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details){
                print("onHorizontalDragEnd");
              },
              onTapDown: (details){
                print("down");
              },
              onTapUp: (details){
                print("up");
              },
          ),
        ),
        Positioned(
  top:80.0,
  left: _leftB,
  child: Listener(
    onPointerDown: (details) {
      print("down");
    },
    onPointerUp: (details) {
      //会触发
      print("up");
    },
    child: GestureDetector(
      child: CircleAvatar(child: Text("B")),
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          _leftB += details.delta.dx;
        });
      },
      onHorizontalDragEnd: (details) {
        print("onHorizontalDragEnd");
      },
    ),
  ),
)
      ],
    );
  }
}

