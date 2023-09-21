// import 'package:flutter/material.dart';

// class practice_Screen extends StatefulWidget {
//   const practice_Screen({Key? key}) : super(key: key);

//   @override
//   State<practice_Screen> createState() => _practice_ScreenState();
// }

// List<Color> colors = [
//   const Color(0xFF3366FF),
//   const Color.fromARGB(255, 51, 255, 129),
//   // const Color.fromARGB(255, 255, 146, 51),
// ];

// class _practice_ScreenState extends State<practice_Screen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             width: 200,
//             height: 300.0,
//             decoration: BoxDecoration(
//               //color: Colors.red,
//               gradient: const LinearGradient(
//                 colors: [
//                   Color(0xFF3366FF),
//                   Color(0xFF00CCFF),
//                 ],
//                 // colors: colors,
//                 begin: FractionalOffset(6.0, 9.0),
//                 end: FractionalOffset(1.0, 0.0),
//                 stops: [0.0, 2.0],
//                 tileMode: TileMode.repeated,
//               ),
//               color: const Color.fromARGB(192, 7, 164, 255),
//               //shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             alignment: Alignment.topCenter,
//             child: Container(
//               height: 150,
//               width: 100,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xFF3366FF),
//                     Color.fromARGB(255, 0, 255, 21),
//                   ],
//                   // colors: colors,
//                   begin: FractionalOffset(60.0, 40.0),
//                   end: FractionalOffset(1.0, 0.0),
//                   stops: [0.0, 2.0],
//                   tileMode: TileMode.repeated,
//                 ),
//                 //color: Colors.black,
//               ),
//               //alignment: Alignment.center,
//               child: const Center(
//                 child: Text("IUWE Y"),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remove_background/remove_background.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoaded = false;
  ui.Image? image;
  ByteData? pngBytes;

  @override
  initState() {
    getUiImage();
    super.initState();
  }

  getUiImage() async {
    ByteData data = await rootBundle.load('assets/1.jpg');
    image = await decodeImageFromList(data.buffer.asUint8List());
    await getPNG();
    setState(() {
      isLoaded = true;
    });
  }

  getPNG() async {
    pngBytes = await image?.toByteData(format: ui.ImageByteFormat.png);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoaded
                ? Image.memory(Uint8List.view(pngBytes!.buffer))
                : const Icon(Icons.image),
            const Text(
              'Example remove background image',
            ),
            isLoaded
                ? TextButton(
                    onPressed: () async {
                      pngBytes =
                          await cutImage(context: context, image: image!);
                      setState(() {});
                    },
                    child: const Text("Cutout Image"))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}