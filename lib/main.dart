import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Tween<double> animation;
  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration:  const Duration(milliseconds: 250))
      ..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        animationController.reverse();
      }
      else if(status==AnimationStatus.dismissed){
        animationController.forward();
      }
    }
    );
    animation = Tween<double>(begin: 0.8,end: 0);
    animationController.forward();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Center(
          child: AnimatedBuilder(
            builder: (context,child)=>CustomPaint(
              painter: PackManPainter(mouthExtend: animationController.value),
            // child: CustomPaint(
            //   painter: PackManPainter(mouthExtend: 0.6),
            ), animation: animation.animate(animationController),
          ),
        ));
        // LayoutBuilder(builder: (context, constraints) {
        //   print(constraints.maxHeight);
        //   print(constraints.minHeight);
        //   print(constraints.maxWidth);
        //   print(constraints.minWidth);
        //   return GridView(
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: getMaxColumnSize(constraints.maxWidth),
        //     ),
        //     children: const [
        //       WCard(),
        //       WCard(),
        //       WCard(),
        //       WCard(),
        //       WCard(),
        //     ],
        //   );
        // })

    // return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: Scaffold(
    //       body: Center(
    //         child: QrImageView(
    //           data: "SALOM",
    //           size: 200,
    //           gapless: false,
    //         ),
    //       ),
    //     ));
    //   MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: Scaffold(
    //       body: Stack(
    //     children: [
    //       MobileScanner(
    //         controller: MobileScannerController(
    //             torchEnabled: false, facing: CameraFacing.back),
    //         onDetect: (barcodeCapture) {
    //           print(barcodeCapture.barcodes.first.rawValue);
    //         },
    //       ),
    //       Positioned.fill(
    //         child: Align(
    //           child: Container(
    //               width: 200,
    //               height: 200,
    //               decoration: BoxDecoration(
    //                   border: Border.all(
    //                 width: 1,
    //                 color: Colors.black,
    //               ))),
    //         ),
    //       ),
    //     ],
    //   )),
    // );
  }
}
int getMaxColumnSize(double value){
  if(value<1020){
    return 1;
  }
  else if(value>1020&&value<1280){
    return 2;
  }
  else{
    return 3;
  }
}


class WCard extends StatelessWidget {
  const WCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 4,
            )
          ]),
      child: const Column(
        children: [
          Text(
            'Title',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet!',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
class PackManPainter extends CustomPainter{
  final double mouthExtend ;
  PackManPainter({super.repaint, required this.mouthExtend});
  @override
  void paint(Canvas canvas, Size size) {
   final centreX =  size.width/2;
   final centreY =  size.height/2;
   final paint = Paint();
   paint.color = Colors.yellow;
   canvas.drawArc(Rect.fromCenter(center: Offset(centreX,centreY), width: 100, height: 100), 0.4, 2*pi-mouthExtend, true, paint);
  }

  @override
  bool shouldRepaint(PackManPainter oldDelegate) =>true;

}

