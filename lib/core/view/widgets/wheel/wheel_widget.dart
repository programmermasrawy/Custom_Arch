import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/assets.dart';

class WheelWidget extends StatelessWidget {

  WheelWidget({Key? key, this.items,required this.onSelected}) : super(key: key);

  Function onSelected;
  StreamController<int> selected = StreamController<int>();
  Random random = Random();
  Map<String,String>? items;

  @override
  Widget build(BuildContext context) {
    items ??= {
      "mahmoud":Assets.draftStatus,
      "gamal":Assets.progressGrey,
      "saeed":Assets.deliveredGrey,
      "ahmed":Assets.shippedGrey,
      "azb":Assets.dashedLine,
    };

    return FortuneWheel(
          selected: selected.stream,
          styleStrategy: const AlternatingStyleStrategy(),
          indicators: const <FortuneIndicator>[
        FortuneIndicator(
          alignment: Alignment.bottomCenter,
          child: TriangleIndicator(
            color: Colors.green,
          ),
        ),
          ],
          items: [
        for(var item in items!.entries)
          FortuneItem(
              style: FortuneItemStyle(
                color: AppColors.multiColors[random.nextInt(AppColors.multiColors.length)],
                borderWidth: 3, // <-- custom circle slice stroke width
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(item.key),
                  SvgPicture.asset(
                    item.value,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                ],
              )),
          ],
        );
  }
}
