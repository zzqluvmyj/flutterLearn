import 'package:flutter/material.dart';

//图片逐渐放大的实例演示动画的基本结构
//有几种方法,具体见书籍

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some',
      home: Scaffold(
        appBar: AppBar(),
        body: ScaleAnimationRoute()
      ),
    );
  }
}

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: Image.asset("images/avatar.png",
          width: animation.value,
          height: animation.value
      ),
    );
  }
}


class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    //启动动画
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    //return AnimatedImage(animation: animation,);

    //使用animatedbuilder有三个好处
    //不用显式的增加帧监听,然后在调用setstate了
    //动画构建的范围缩小了，如果没有builder，setState()将会在父widget上下文调用，这将会导致父widget的build方法重新调用，而有了builder之后，只会导致动画widget的build重新调用，这在复杂布局下性能会提高。
    //通过AnimatedBuilder可以封装常见的过渡效果来复用动画。下面我们通过封装一个GrowTransition来说明，它可以对子widget实现放大动画

    //用GrowTransition封装后可以改为
    return GrowTransition(
      child:Image.asset('assets/images/timg.jpg'),
      animation:animation
    );


    // return AnimatedBuilder(
    //   animation: animation,
    //   child: Image.asset("images/avatar.png"),
    //   builder: (BuildContext ctx, Widget child) {
    //     return new Center(
    //       child: Container(
    //           height: animation.value, 
    //           width: animation.value, 
    //           child: child,
    //       ),
    //     );
    //   },
    // );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value, 
                width: animation.value, 
                child: child
            );
          },
          child: child
      ),
    );
  }
}