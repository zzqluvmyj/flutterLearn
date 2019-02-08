import 'package:flutter/material.dart';

//Notification是Flutter中一个重要的机制，在Widget树中，每一个节点都可以分发通知，通知会沿着当前节点（context）向上传递，所有父节点都可以通过NotificationListener来监听通知，Flutter中称这种通知由子向父的传递为“通知冒泡”（Notification Bubbling），这个和用户触摸事件冒泡是相似的，但有一点不同：通知冒泡可以中止，但用户触摸事件不行。

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(appBar: AppBar(), body: NotificationRoute()),
    );
  }
}

class NotificationListenerTest extends StatefulWidget {
  @override
  _NotificationListenerTestState createState() =>
      _NotificationListenerTestState();
}

class _NotificationListenerTestState extends State<NotificationListenerTest> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: NotificationListener(
        onNotification: (notification) {
          switch (notification.runtimeType) {
            case ScrollStartNotification:
              print("开始滚动");
              break;
            case ScrollUpdateNotification:
              print("正在滚动");
              break;
            case ScrollEndNotification:
              print("滚动停止");
              break;
            case OverscrollNotification:
              print("滚动到边界");
              break;
          }
        },
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
            );
          },
        ),
      ),
    );
  }
}

//自定义通知类
class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}

class NotificationRoute extends StatefulWidget {
  @override
  NotificationRouteState createState() {
    return new NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";
  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<MyNotification>(
      //接到通知做的事情
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + "  ";
        });
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//          RaisedButton(
//           onPressed: () => MyNotification("Hi").dispatch(context),
//           child: Text("Send Notification"),
//          ),
            Builder(
              builder: (context) {
                return RaisedButton(
                  //按钮点击时分发通知
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("Send Notification"),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}
