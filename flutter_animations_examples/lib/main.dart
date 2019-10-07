import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addStatusListener((state) => print('$state'));
    controller.forward();
  }

  // @override
  // Widget build(BuildContext context) => GrowTransition(
  //       child: LogoWidget(),
  //       animation: animation,
  //     );

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}

// class LogoWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: FlutterLogo(),
//     );
//   }
// }

// class GrowTransition extends StatelessWidget {
//   GrowTransition({this.child, this.animation});

//   final Widget child;
//   final Animation<double> animation;

//   Widget build(BuildContext context) => Center(
//         child: AnimatedBuilder(
//             animation: animation,
//             builder: (context, child) => Container(
//                   height: animation.value,
//                   width: animation.value,
//                   child: child,
//                 ),
//             child: child),
//       );
// }
