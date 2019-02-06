import 'package:flutter/material.dart';

//输入框
//内容
//获取输入内容
//文本输入监听
//焦点操作 实现但无效
//监听焦点 没有实现
//自定义样式  简单实现,不会像例子中那样实现,
  //将输入框放到container中,设定container的外观来增强输入框的外观



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _upasswordController = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode focusScopeNode;

  //设置默认值选择文本
  TextEditingController _selectionController = TextEditingController();

  //通过controller监听文本变化
  //功能多一点,可以设置默认值,选择文本等
  //onChanged只能监听文本变化,功能少

////////////////////////////////////////////////////
//使用controller控制文本的方法不奏效,怀疑是加载该类的时候,表单还未生成,所以出现这种情况
//暂时未知解决方法
//该方法只在这个类创建的时候运行
//////////////////////////////
//问题已经解决,因为我没有将_selectionController绑定到特定的controller上
  @override
  void initState() {
    super.initState();
    _unameController.addListener(() {
      print(_unameController.text);
      _selectionController.text = 'hello world';
      _selectionController.selection = TextSelection(
          baseOffset: 2, extentOffset: _selectionController.text.length);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: '用户名',
                  labelStyle: TextStyle(color: Colors.green),
                  hintText: '用户名或邮箱',
                  hintStyle: TextStyle(color: Colors.purple),
                  prefixIcon: Icon(Icons.person),
                  //输入下划线消失
                  border: InputBorder.none,
                ),
                controller: _unameController,
                onChanged: (v) {
                  print('$v');
                },
              ),
              TextField(
                controller: _selectionController,
              ),
              Container(
                child: TextField(),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.red,width: 2)),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '您的登录密码',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                //通过onchange和controller监听和获取文本
                controller: _upasswordController,
                onChanged: (v) {
                  print('onchange: $v');
                  print('${_upasswordController.text}');
                }, // onChanged: ,
                // onSubmitted: ,
                // onEditingComplete: ,
              ),

              //下面是焦点的操作
              TextField(
                autofocus: true,
                focusNode: focusNode1, //关联focusNode1
                decoration: InputDecoration(labelText: "input1"),
              ),
              TextField(
                focusNode: focusNode2, //关联focusNode2
                decoration: InputDecoration(labelText: "input2"),
              ),
              //Builder不知道干啥的,移动焦点不起作用,不知道为什么
              Builder(
                builder: (ctx) {
                  return Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text("移动焦点"),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(focusNode2);
                          //将焦点从第一个TextField移到第二个TextField
                          // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                          // 这是第二种写法
                          if (null == focusScopeNode) {
                            focusScopeNode = FocusScope.of(context);
                          }
                          focusScopeNode.requestFocus(focusNode2);
                        },
                      ),
                      RaisedButton(
                        child: Text("隐藏键盘"),
                        onPressed: () {
                          // 当所有编辑框都失去焦点时键盘就会收起
                          focusNode1.unfocus();
                          focusNode2.unfocus();
                        },
                      ),
                    ],
                  );
                },
              ),
// //创建 focusNode
// FocusNode focusNode = new FocusNode();
// ...
// // focusNode绑定输入框
// TextField(focusNode: focusNode);
// ...
// // 监听焦点变化
// focusNode.addListener((){
//    print(focusNode.hasFocus);
// });
            ],
          )),
    );
  }
}
