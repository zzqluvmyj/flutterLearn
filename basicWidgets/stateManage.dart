import 'package:flutter/material.dart';

//widget管理自身状态,_TapboxAState管理TapboxA的状态
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);
  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;
  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(_active ? 'active' : 'Inactive',
              style: TextStyle(fontSize: 32, color: Colors.white)),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: _active ? Colors.lightBlue[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//父widget管理子widget的state
//ParentWidgetState 类:为TapboxB 管理_active状态.
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;
  void _handleTapboxChanged(bool newvalue) {
    setState(() {
      _active = newvalue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;
  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'active' : 'inactive',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//混合管理,字widget管理一些状态,而父widget管理一些其他的外部状态,
class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;
  void _handlerTapboxChanged(bool newvalue) {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: _active,
        onChanged: _handlerTapboxChanged,
      ),
    );
  }
}

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);
  //因为是父对象管理这个状态,所以这些值从父组件接收而来
  final bool active;
  final ValueChanged<bool> onChanged;

  //下面的state对象,自己管理自己的状态
  @override
  _TapboxCState createState() => new _TapboxCState();
}

//此处的泛型什么意思
class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;
  
  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

//此处为什么要用widget.active
  void _handleTap() {
    setState(() {
      widget.onChanged(widget.active);
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      onTapUp: _handleTapUp,
      child: Container(
        child: Center(
          child: Text(widget.active?'Active':'Inactive',style: TextStyle(fontSize: 32,color: Colors.white),),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: widget.active?Colors.lightGreen[700]:Colors.grey[600],
          border: _highlight?Border.all(
            color: Colors.teal[700],
            width: 10,
          ):null
        ),
      ),
    );
  }
}


//全局状态管理
//2种方法,全局事件总线或者redux这样的全局状态包





class MyApp extends StatelessWidget {
  // 页面构建的重写
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
        child: Column(
          children: <Widget>[
            TapboxA(),
            ParentWidget(),
            ParentWidgetC(),
          ],
        ),
      ),
    );
  }
}