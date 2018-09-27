import 'package:flutter/material.dart';
import 'package:frogger_f/model.dart';
class Pond extends StatelessWidget {
  final double animationvalue;

  Pond({
    this.animationvalue = 0.0,
});
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: List.generate(lanes.length,
    (laneindex) {
        Lane lane = lanes[laneindex];
        return Stack(
          children: lane.empty
            ? [Container(
          height: 50.0,
          width: double.infinity,
          color: lane.boxColor,
        )]
      :
      List.generate(lane.boxwidths.length,
      (boxnum) {
        return Transform(
          transform: Matrix4.translationValues(animationvalue != null ?
          lane.forward ? (boxnum * 400 + 6000 * animationvalue * lane.speed) %
              1200 - 300
              : (boxnum * 400 - 6000 * animationvalue * lane.speed) % 1200 - 300
              : 0.0, 0.0, 0.0),
          child: Container(
            height: 50.0,
            width: lane.boxwidths[boxnum],
            decoration: BoxDecoration(
                color: lane.boxColor,
                borderRadius: BorderRadius.circular(3.0)
            ),
          ),
        );
      })
        );
    }),
    );
  }
}

