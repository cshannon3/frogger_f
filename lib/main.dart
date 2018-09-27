import 'package:flutter/material.dart';
import 'package:frogger_f/model.dart';
import 'package:frogger_f/pond.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
      appBar: new AppBar(

    ),
    body: new MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {



  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {


  AnimationController controller;
  Animation<double> animation;
  double paddingtop;
  double paddingbottom;
  double froggerX;
  double froggerY;
  double pond_width;

  int currentlane;
  double pond_height;
  double debugboxwidth;
  double debugboxposleft;
  double initpos = 300.0;

  @override
  void initState() {
    super.initState();
    paddingtop = 100.0;
    paddingbottom = 100.0;
    pond_width = 400.0 - 50.0;
    currentlane = 0;
    debugboxwidth = 0.0;
    debugboxposleft = 0.0;

    pond_height = 700.0 - paddingtop - paddingbottom;
    froggerX = 700.0 - paddingbottom;
    froggerY = pond_width / 2;
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 12000))
      ..addListener(() {
        setState(() {
          if(froggerX/50 < lanes.length && !lanes[currentlane].empty) {
            double val = (1 * 400 + 6000 * controller.value * lanes[currentlane].speed) %
                1200 - 300;
            if (val > initpos) {
              if (val < initpos + lanes[currentlane].boxwidths[1]) {
                debugboxwidth = val - initpos;
                debugboxposleft = debugboxwidth;
                print(debugboxwidth);
              } else if (val <= initpos + 2 * lanes[currentlane].boxwidths[1]) {
                debugboxwidth = initpos + 2 * lanes[currentlane].boxwidths[1] - val;
              } else if (val > initpos + 2 * lanes[currentlane].boxwidths[1]) {
                debugboxwidth = 0.0;
                debugboxposleft = 0.0;
              }
            }
          }
        });
      });

    controller.repeat();
  }
  loopanimtion() {
    controller.forward().whenComplete(() {
      controller.reverse();
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

/*
  Widget _buildRow(Lane lane) {
    List<Widget> boxes = [];
    if (lane.empty) {
      return Container(
        height: 50.0,
        width: double.infinity,
        color: lane.boxColor,
      );
    }
    for (int p = 0; p < lane.boxwidths.length; p++) {
      boxes.add(
        Transform(
          transform: Matrix4.translationValues(controller.value != null ?
          lane.forward ? (p * 400 + 6000 * controller.value * lane.speed) %
              1200 - 300
              : (p * 400 - 6000 * controller.value * lane.speed) % 1200 - 300
              : 0.0, 0.0, 0.0),
          child: Container(
            height: 50.0,
            width: lane.boxwidths[p],
            decoration: BoxDecoration(
                color: lane.boxColor,
                borderRadius: BorderRadius.circular(3.0)
            ),
          ),
        ),);
    }
    return Stack(
        children: boxes
    );
  }

  Widget _buildLanes() {
    List<Widget> lanewidgets = [];
    lanes.forEach((lane) {
      lanewidgets.add(_buildRow(lane));
    });
    return Column(
        children: lanewidgets
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Expanded(
          child: new Container(
            color: Colors.blue,
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
               // _buildLanes(),
                Pond(animationvalue: controller.value,),
                Positioned(
                  top: froggerX,
                  left: froggerY,
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle

                    ),
                  ),
                ),
                Positioned(
                  top: 50.0*currentlane,
                  right: 300-debugboxposleft,
                  child: Container(
                    height: 50.0,
                    width: debugboxwidth,
                    color: Colors.red,

                  ),
                ),

              ],
            ),
          ),
        ),
        Container(
          height: 70.0,
          width: double.infinity,
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  setState(() {
                    print(froggerY);
                    if (froggerY > 50.0) froggerY -= 50.0;
                  });
                },
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    if (froggerX - 50.0 >= 0.0) {
                      froggerX -= 50.0;
                      currentlane = (froggerX/50).floor();
                      print(currentlane);
                    }
                  });
                },
                color: Colors.green,
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  setState(() {

                    if (froggerX < 700.0 - paddingbottom) {
                      froggerX += 50.0;
                      currentlane = (froggerX/50).floor();
                      print(currentlane);
                    }
                  });
                },

                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  setState(() {
                    print(froggerY);
                    if (froggerY + 50.0 < pond_width) froggerY += 50.0;
                  });
                },

                iconSize: 40.0,
              ),
            ],
          ),
        )
      ],
    );
  }
}
