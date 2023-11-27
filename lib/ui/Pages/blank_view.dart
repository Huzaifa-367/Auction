import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/cards/white_card.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/custom_labels.dart';

import 'dart:async';

class BlankView extends StatelessWidget {
  const BlankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Blank View', style: CustomLabels.h1),
          const SizedBox(height: 30),
          // const WhiteCard(
          //   title: 'This is a Blank View',
          //   child: StopWatchTimerPage(),
          // ),
          const SizedBox(
            height: 80,
            width: 40,
            child: StopWatchTimerPage(),
          ),
        ],
      ),
    );
  }
}

/////
///
///
///
///

class StopWatchTimerPage extends StatefulWidget {
  const StopWatchTimerPage({super.key});

  @override
  _StopWatchTimerPageState createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  static const countdownDuration = Duration(minutes: 10);
  Duration duration = const Duration();
  Timer? timer;

  bool countDown = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reset();
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.orange[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTime(),
              const SizedBox(
                height: 80,
              ),
              buildButtons()
            ],
          ),
        ),
      );

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'Hr'),
      // const SizedBox(
      //   width: 8,
      // ),
      buildTimeCard(time: minutes, header: 'Min'),
      // const SizedBox(
      //   width: 8,
      // ),
      buildTimeCard(time: seconds, header: 'Sec'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            // const SizedBox(
            //   height: 14,
            // ),
            Text(
              header,
              style: const TextStyle(
                //fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return isRunning || isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isRunning) {
                      stopTimer(resets: false);
                    }
                  });
                },
                child: const Text("Stop"),
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          )
        : ElevatedButton(
            onPressed: () {
              setState(() {
                startTimer();
              });
            },
            child: const Text("Start"),
          );
  }
}
