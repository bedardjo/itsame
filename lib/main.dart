import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'It\'s a me, Mario!',
      home: MarioAnimationDemo(),
    );
  }
}

class MarioAnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MarioAnimationDemoState();
}

class MarioAnimationDemoState extends State<MarioAnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  Animation<double> marioX;
  Animation<double> marioY;
  Animation<int> marioFrame;

  Animation<double> blockY;
  Animation<int> blockFrame;

  Animation<double> coinY;

  int coinHits = 15;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));

    List<double> wgts = [.5, 1.5, .3, .3, .5];

    List<TweenSequenceItem<double>> marioXItems = [
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.5), weight: wgts[0]),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: wgts[1]),
    ];
    for (int i = 0; i < coinHits; i++) {
      marioXItems.add(
        TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: wgts[2]),
      );
      marioXItems.add(
        TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: wgts[3]),
      );
    }
    marioXItems.add(
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.0), weight: wgts[4]),
    );
    marioX = TweenSequence<double>(marioXItems).animate(animationController);

    List<TweenSequenceItem<double>> marioYItems = [
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[0]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[1]),
    ];
    for (int i = 0; i < coinHits; i++) {
      marioYItems.add(
        TweenSequenceItem(
            tween: Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeOutQuad)),
            weight: wgts[2]),
      );
      marioYItems.add(
        TweenSequenceItem(
            tween: Tween(begin: 1.0, end: 0.0)
                .chain(CurveTween(curve: Curves.easeIn)),
            weight: wgts[3]),
      );
    }
    marioYItems.add(
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[4]),
    );
    marioY = TweenSequence<double>(marioYItems).animate(animationController);

    List<TweenSequenceItem<int>> marioFrameItems = [
      TweenSequenceItem(tween: walkAnimation(), weight: wgts[0]),
      TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: wgts[1]),
    ];
    for (int i = 0; i < coinHits; i++) {
      marioFrameItems.add(
        TweenSequenceItem(tween: IntTween(begin: 5, end: 5), weight: wgts[2]),
      );
      marioFrameItems.add(
        TweenSequenceItem(tween: IntTween(begin: 5, end: 5), weight: wgts[3]),
      );
    }
    marioFrameItems.add(
      TweenSequenceItem(tween: walkAnimation(), weight: wgts[4]),
    );
    marioFrame =
        TweenSequence<int>(marioFrameItems).animate(animationController);

    List<TweenSequenceItem<double>> blockYItems = [
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[0]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[1]),
    ];
    for (int i = 0; i < coinHits; i++) {
      blockYItems.add(
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[2]),
      );
      blockYItems.add(
        TweenSequenceItem(
            tween: TweenSequence<double>([
              TweenSequenceItem(
                  tween: Tween(begin: 0.0, end: 1.0), weight: 1.0),
              TweenSequenceItem(
                  tween: Tween(begin: 1.0, end: 0.0), weight: 1.0),
            ]),
            weight: wgts[3]),
      );
    }
    blockYItems.add(
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[4]),
    );
    blockY = TweenSequence<double>(blockYItems).animate(animationController);

    List<TweenSequenceItem<int>> blockFrameItems = [
      TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: wgts[0]),
      TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: wgts[1]),
    ];
    for (int i = 0; i < coinHits - 1; i++) {
      blockFrameItems.addAll([
        TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: wgts[2]),
        TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: wgts[2]),
      ]);
    }
    blockFrameItems.addAll([
      TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: wgts[2]),
      TweenSequenceItem(tween: IntTween(begin: 1, end: 2), weight: wgts[3]),
    ]);
    blockFrameItems.add(
      TweenSequenceItem(tween: IntTween(begin: 2, end: 2), weight: wgts[4]),
    );
    blockFrame =
        TweenSequence<int>(blockFrameItems).animate(animationController);

    List<TweenSequenceItem<double>> coinYItems = [
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[0]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[1]),
    ];
    for (int i = 0; i < coinHits; i++) {
      coinYItems.add(
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[2]),
      );
      coinYItems.add(
        TweenSequenceItem(
            tween: TweenSequence<double>([
              TweenSequenceItem(
                  tween: Tween(begin: 0.0, end: 1.0), weight: 1.0),
              TweenSequenceItem(
                  tween: Tween(begin: 1.0, end: 0.0), weight: 1.0),
            ]),
            weight: wgts[3]),
      );
    }
    coinYItems.add(
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: wgts[4]),
    );
    coinY = TweenSequence<double>(coinYItems).animate(animationController);

    animationController.repeat();
  }

  walkAnimation() => TweenSequence([
        TweenSequenceItem(tween: StepTween(begin: 2, end: 5), weight: 1),
        TweenSequenceItem(tween: StepTween(begin: 2, end: 5), weight: 1),
        TweenSequenceItem(tween: StepTween(begin: 2, end: 5), weight: 1),
        TweenSequenceItem(tween: StepTween(begin: 2, end: 5), weight: 1),
      ]);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Positioned(
                  left: size.width / 2 - 16.0,
                  top: size.height / 2 - 105 - 120 * coinY.value,
                  child: Image(
                    image: AssetImage("assets/coin.png"),
                    gaplessPlayback: true,
                  ));
            },
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Positioned(
                  left: size.width / 2 - 16.0,
                  top: size.height / 2 - 105 - 10 * blockY.value,
                  child: Image(
                    image: AssetImage("assets/block_${blockFrame.value}.png"),
                    gaplessPlayback: true,
                  ));
            },
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Positioned(
                  left: marioX.value * size.width - 16.0,
                  top: size.height / 2 - 80 * marioY.value,
                  child: Image(
                    image: AssetImage("assets/mario_${marioFrame.value}.png"),
                    gaplessPlayback: true,
                  ));
            },
          )
        ],
      ),
    );
  }
}
