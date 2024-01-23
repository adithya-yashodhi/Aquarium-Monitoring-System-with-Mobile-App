import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'fade_in_animation_controller.dart';
import 'fade_in_animation_model.dart';

class TFadeInAnimation extends StatelessWidget {
  TFadeInAnimation({
    Key? key,
    required this.durationInMs,
    required this.child,
    this.animate,
  }) : super(key: key);

  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final TAnimatePosition? animate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => AnimatedPositioned(
          top: controller.animate.value ? animate!.topAfter : animate!.topBefore,
          left: controller.animate.value ? animate!.leftAfter : animate!.leftBefore,
          bottom: controller.animate.value ? animate!.bottomAfter : animate!.bottomBefore,
          right: controller.animate.value ? animate!.rightAfter : animate!.rightBefore,
          duration: Duration(milliseconds: durationInMs),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: durationInMs),
            opacity: controller.animate.value ? 1 : 0,
            child: child,
      ),
    ),
    );
  }
}
