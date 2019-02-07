import 'package:flutter/material.dart';

//将listview和gridview的滑动变得连接起来
//这就是CustomScrollView

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'gsgg',
        home: Scaffold(
          body:CustomScrollView(
          slivers: <Widget>[
            //AppBar，包含一个导航栏
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Demo'),
                background: Image.asset(
                  "assets/images/timg.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: new SliverGrid(
                //Grid
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //Grid按两列显示
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 6.0,
                ),
                delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    //创建子widget
                    return new Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: new Text('grid item $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ),
            //List
            new SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                //创建列表项
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: new Text('list item $index'),
                );
              }, childCount: 50 //50个列表项
                  ),
            ),
          ],
        )));
  }
}
