import 'package:flutter/material.dart';

//图片和图标,图标可以在https://material.io/tools/icons/查看,需要翻墙




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/timg.jpg'),
              width: 100,
              height: 100,
              //fit:BoxFit.contain
              //alignment:Alignment.center,
              //repeat:ImageRepeat.repeat,
            ),
            Image.asset(
              'assets/images/timg.jpg',
              width: 100,
              height: 100,
              ),
            Image(
              image: NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549447588066&di=2dfd9b73991fa4dc3a14ad9895faa9ae&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw640h425%2F20180227%2Fc9d1-fyrwsqi9997552.jpg'),
              width: 100,
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.accessible,color: Colors.green,),
                Icon(Icons.error,color: Colors.green,),
                Icon(Icons.fingerprint),
              ],
              )
          ],
        ),
      ),
    );
  }
}


