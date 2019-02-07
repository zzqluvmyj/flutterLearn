import 'package:flutter/material.dart';

//SliverGridDelegateWithMaxCrossAxisExtent  横轴子元素固定最大长度
//GridView.extent

//SliverGridDelegateWithFixedCrossAxisCount  横轴子元素固定数量,需要参数gridDelegate
//GridView.builder,需要参数gridDelegate,itemBuilder

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'some',
        home: Scaffold(
          appBar: AppBar(),
          body: InfiniteGridView()
        ));
  }
}

class ListViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //横轴三个子widget
                  childAspectRatio: 1 //宽高比为1时，子widget
                  ),
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
                
              ]),
    );
  }
}

class InfiniteGridView extends StatefulWidget {
  @override
  _InfiniteGridViewState createState() => new _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {

  List<IconData> _icons = []; //保存Icon数据

  @override
  void initState() {
    // 初始化数据  
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            childAspectRatio: 1.0 //显示区域宽高相等
        ),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          //如果显示到最后一个并且Icon总数小于200时继续获取数据
          if (index == _icons.length - 1 && _icons.length < 200) {
            _retrieveIcons();
          }
          return Icon(_icons[index]);
        }
    );
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access, Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}