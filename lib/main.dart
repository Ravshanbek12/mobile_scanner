import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Tween<double> animation;
  late WebViewController controller;

  @override
  void initState() {

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://poki.com/'));


    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animation = Tween<double>(begin: 0.8, end: 0);
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white12,
        body: WebViewWidget(controller: controller,)
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   // mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const SizedBox(
        //       height: 200,
        //     ),
        //     Center(
        //       child: CustomPaint(
        //         painter: PackManPainter(mouthExtend: animationController.value),
        //         // child: CustomPaint(
        //         //   painter: PackManPainter(mouthExtend: 0.6),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
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

// int getMaxColumnSize(double value) {
//   if (value < 1020) {
//     return 1;
//   } else if (value > 1020 && value < 1280) {
//     return 2;
//   } else {
//     return 3;
//   }
// }

////WCard class

// class WCard extends StatelessWidget {
//   const WCard({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: Colors.grey,
//           ),
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.2),
//               blurRadius: 4,
//             )
//           ]),
//       child: const Column(
//         children: [
//           Text(
//             'Title',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet! Lorem ipsum dolor sit amet!',
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//// WCard class end;

class PackManPainter extends CustomPainter {
  final double mouthExtend;

  PackManPainter({super.repaint, required this.mouthExtend});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final paint1 = Paint();
    paint.color = Colors.white;

    paint1.color = Colors.black;

    // canvas.drawArc(
    //     Rect.fromCenter(
    //         center: const Offset(0, 60), width: 100, height: 100),
    //     0,
    //     2*pi,
    //     true,
    //     paint);
    canvas.drawCircle(const Offset(0, 60), 40, paint);
    canvas.drawCircle(const Offset(-20, 55), 4, paint1);
    canvas.drawCircle(const Offset(20, 55), 4, paint1);
    canvas.drawArc(
        Rect.fromCenter(center: const Offset(0, 140), width: 100, height: 100),
        1.4,
        2 * pi,
        false,
        paint);
    canvas.drawCircle(const Offset(0, 120), 4, paint1);
    canvas.drawCircle(const Offset(0, 145), 4, paint1);
    canvas.drawCircle(const Offset(0, 220), 65, paint);
  }

  @override
  bool shouldRepaint(PackManPainter oldDelegate) => false;
}
