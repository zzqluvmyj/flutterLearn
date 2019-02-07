import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//可滚动widget通过一个List来作为其children属性时，只适用于子widget较少的情况，这是一个通用规律，并非ListView自己的特性，像GridView也是如此。
//ListView.builder适合列表项比较多（或者无限）的情况，因为只有当子Widget真正显示的时候才会被创建。

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home:Scaffold(
        appBar: AppBar(),
        body:  InfiniteListViewTest(),
      )    
    );
  }
}

//通过 ListView.builder构建无限的列表
class ListViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        physics: ScrollPhysics(
          //滚动到底后的效果,这个为ios效果,弹性效果
          parent: BouncingScrollPhysics()
        ),
        itemExtent: 50,//强制高度
        itemCount: 100,//如果是null表示无限列表
        itemBuilder: (BuildContext context,int index){
          return ListTile(title: Text('$index'),);
        },
      ),
    );
  }
}

//ListView.separated可以生成列表项之间的分割器
class ListViewTest1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        physics: ScrollPhysics(
          //滚动到底后的效果,这个为ios效果,弹性效果
          parent: BouncingScrollPhysics()
        ),
        //没有强制高度
        itemCount: 100,//如果是null表示无限列表
        itemBuilder: (BuildContext context,int index){
          return ListTile(title: Text('$index'),);
        },
        separatorBuilder: (BuildContext context,int index){
          return index%2==0?Divider(color: Colors.red,):Divider(color: Colors.blue);
        },
      ),
    );
  }
}

//无限加载列表
//异步拉取数据
class InfiniteListViewTest extends StatefulWidget {
  @override
  _InfiniteListViewTestState createState()=>_InfiniteListViewTestState();
}

class _InfiniteListViewTestState extends State<InfiniteListViewTest>{
  static const loadingTag="loading......";
  var _words=<String>[loadingTag];
  void _retrieveData(){
    Future.delayed(Duration(seconds: 5)).then(
      (e){
        _words.insertAll(_words.length-1, 
        generateWordPairs().take(20).map(
          (e)=>e.asPascalCase
        ).toList()
        );
        setState(() {
          //重构列表
        });
      });
  }

  @override
  void initState(){
    _retrieveData();
  }
  @override
  Widget build(BuildContext context){
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context,index){
        if(_words[index]==loadingTag){
          //不足100条，继续获取数据
          if(_words.length-1<100){
            _retrieveData();
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24,
                height: 24,
                //这是个等待的进度条
                child: CircularProgressIndicator(strokeWidth: 2,),
              ),
            );
          }
          else{
            //已经加载了100条,不再获取数据
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text("没有更多了",style: TextStyle(color: Colors.red),),
            );
          }
        }
        
        return ListTile(title: Text(_words[index]),);
      },
      separatorBuilder: (context,index)=>Divider(height: 0,),
    );
  }
}

