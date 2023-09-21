import 'package:flutter/material.dart';

class GetUsers extends StatefulWidget {
  Widget? content;
  var onPress;
  List<Widget>? action;
  String? title;
  GetUsers({super.key, this.title, this.content, this.action, this.onPress});

  @override
  State<GetUsers> createState() => _GetUsersState();
}

class _GetUsersState extends State<GetUsers> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          for (int i = 0; i < 10; i++) ...{
            SizedBox(
              width: 300,
              child: Card(
                  child: ListTile(
                      onTap: () {
                        showDialog(
                          //useSafeArea: true,
                          //To disable alert background
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                              icon: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.cancel)),
                              ),
                              title: Text(widget.title ?? ''),
                              //content: const Text("Do you want to login?"),
                              content: widget.content,
                              actions: widget.action),
                        );
                      },
                      title: Text('Worker ${i + 1}'),
                      subtitle: const Text('Amount'),
                      leading: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          height: 200,
                          width: 100,
                          child: Image.asset(
                            'assets/jalaii.jpeg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ))),
            )
          }
        ],
      ),
    );
  }
}
