import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/cards/white_card.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/inputs/TextField_Round.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
export 'package:pluto_grid/pluto_grid.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView>
    with TickerProviderStateMixin {
  TextEditingController text = TextEditingController();
  late TabController tabController = TabController(length: 3, vsync: this);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          //Text('New User', style: CustomLabels.h1),
          // const SizedBox(height: 30),
          WhiteCard(
            title: 'Setting',
            width: 400,
            // icon: Icons.add,
            // onPress: () {
            //   //
            // },
            child: Center(
              child: getWidget(),
            ),
          )
        ],
      ),
    );
  }

  // _getNewTaskTile() {
  //   return Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 20),
  //       width: MediaQuery.of(context).size.width,
  //       margin: const EdgeInsets.only(bottom: 12),
  //       child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             ClipPath(
  //               clipper: DolDurmaClipper(right: 40, holeRadius: 20),
  //               child: Container(
  //                   decoration: const BoxDecoration(
  //                     borderRadius: BorderRadius.all(
  //                       Radius.circular(15),
  //                     ),
  //                     color: Colors.blueAccent,
  //                   ),
  //                   width: MediaQuery.of(context).size.width,
  //                   padding: const EdgeInsets.all(15),
  //                   child: Row(children: [
  //                     Expanded(
  //                         child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                           Text(
  //                             "task?.title " ?? "",
  //                             style: GoogleFonts.lato(
  //                               textStyle: const TextStyle(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.black87),
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             height: 12,
  //                           ),
  //                           Row(
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               const Icon(
  //                                 Icons.access_time_rounded,
  //                                 color: Colors.black87,
  //                                 size: 18,
  //                               ),
  //                               const SizedBox(width: 4),
  //                               Text(
  //                                 "task.startTime - task!.endTime",
  //                                 style: GoogleFonts.lato(
  //                                   textStyle: const TextStyle(
  //                                       fontSize: 13, color: Colors.black87),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           const SizedBox(height: 12),
  //                           Text(
  //                             "task?.note" ?? "",
  //                             style: GoogleFonts.lato(
  //                               textStyle: const TextStyle(
  //                                   fontSize: 15, color: Colors.black87),
  //                             ),
  //                           ),
  //                         ])),
  //                     RotatedBox(
  //                       quarterTurns: 3,
  //                       child: Text(
  //                         "COMPLETED",
  //                         style: GoogleFonts.lato(
  //                           textStyle: const TextStyle(
  //                               fontSize: 10,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black),
  //                         ),
  //                       ),
  //                     ),
  //                   ])),
  //             )
  //           ]));
  // }

  getWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextWidget(
                  title: 'Bidding Timmer',
                  txtSize: 20,
                  txtColor: txtColor,
                ),
                MyTextField(
                  controller: TextEditingController(),
                  hintText: 'Value In Minutes: 5',
                  maxlines: 1,
                  obscureText: false,
                ),
              ],
            ),
          ),
          // FittedBox(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       TextWidget(title: 'Cut', txtSize: 20, txtColor: txtColor),
          //       MyTextField(
          //         controller: TextEditingController(),
          //         hintText: 'Enter price /1000',
          //         maxlines: 1,
          //         obscureText: false,
          //         prefixIcon: const Icon(Icons.money_off_csred),
          //       ),
          //     ],
          //   ),
          // ),
          // FittedBox(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       TextWidget(title: 'Jammadar', txtSize: 20, txtColor: txtColor),
          //       MyTextField(
          //         controller: TextEditingController(),
          //         hintText: 'Enter price /1000',
          //         maxlines: 1,
          //         obscureText: false,
          //         prefixIcon: const Icon(Icons.person),
          //       ),
          //     ],
          //   ),
          // ),

          ElevatedButton(
            onPressed: () {},
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
