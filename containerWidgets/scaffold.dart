import 'package:flutter/material.dart';

//Scafford 
//脚手架,就是一般应用软件的框架

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: ScaffoldTest()
    );
  }
}

class ScaffoldTest extends StatefulWidget{
  @override
  _ScaffoldTestState createState()=>_ScaffoldTestState();
}

//暂时不知道什么意思
class _ScaffoldTestState extends State<ScaffoldTest> with SingleTickerProviderStateMixin{
  //int _seletedIndex=1;
  TabController _tabController;
  //tabBar和tabBarView的controller是一个,所以能够进行同步的变换
  List tabs=['新闻','历史','图片'];
  // void _onItemTapped(int index){
  //   setState(() {
  //    _seletedIndex=index; 
  //   });
  // }
  @override
  void initState(){
    super.initState();
    //不知道什么意思
    _tabController=TabController(length: tabs.length,vsync: this);
    //添加监听
    _tabController.addListener((){
      switch(_tabController.index){
        case 1:
        break;
        case 2:
        break;
        case 3:
        break;
        default:
        break;
      }
    });
  }
  void _onAdd(){

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(//导航栏
        leading: Builder(
          //还有一种方法设置leading,具体见示例
          builder: (context){
            return IconButton(
              icon: Icon(Icons.dashboard,color:Colors.white),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        //automaticallyImplyLeading: true,//如果leading为null，是否自动实现默认的leading按钮
        title: Text("Appname"),
        actions: <Widget>[//导航栏右侧菜单
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){},
          ),
        ],
        bottom:TabBar(
          controller: _tabController,
          //意思是将这些文本加入tab中并形成tab列表
          //可以自定制tab
          tabs: tabs.map((e)=>Tab(text: e,)).toList(),
        ),//底部按钮组
        elevation: 5,//导航栏阴影
      ),
      //endDrawer: ,//右抽屉菜单
      drawer: MyDrawer(),//抽屉
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        //底部导航栏打一个洞
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.home),onPressed: (){},),
            SizedBox(),//中间空着
             IconButton(icon: Icon(Icons.business),onPressed: (){},),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,//均匀分配空间
        ),
      ),
      //BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home')),
      //     BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
      //     BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
      //   ],
      //   currentIndex: _seletedIndex,
      //   fixedColor: Colors.orange,
      //   onTap: _onItemTapped,
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //决定floatingbutton在什么位置
      //配合TabBar实现同步切换和滑动状态同步
      body: TabBarView(
        controller: _tabController,
        //创建3个tab页
        children: tabs.map((e){
          return Container(
            alignment:Alignment.center,
            child: Text(e,textScaleFactor:5),
          );
        }).toList(),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Icon(Icons.accessible)
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}