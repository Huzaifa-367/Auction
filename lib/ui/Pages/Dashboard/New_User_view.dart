import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/cards/white_card.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/inputs/TextField_Round.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
import 'package:flutter_admin_dashboard/models/User_Model.dart';
import 'package:flutter_admin_dashboard/providers/Controllers.dart';
import 'package:flutter_admin_dashboard/providers/auth_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
export 'package:pluto_grid/pluto_grid.dart';

class NewUserView extends StatefulWidget {
  const NewUserView({super.key});

  @override
  State<NewUserView> createState() => _NewUserViewState();
}

class _NewUserViewState extends State<NewUserView>
    with TickerProviderStateMixin {
  TextEditingController text = TextEditingController();
  late TabController tabController = TabController(length: 3, vsync: this);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? selectedValue;
  late AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    authProvider = context.read<AuthProvider>();
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          //Text('New User', style: CustomLabels.h1),
          // const SizedBox(height: 30),
          WhiteCard(
            title: 'New User',
            width: 400,
            // icon: Icons.add,
            // onPress: () {
            //   //
            // },
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextWidget(
                            title: 'Name',
                            txtSize: 20,
                            txtColor: txtColor,
                          ),
                          MyTextField(
                            controller: Controllers.username,
                            hintText: 'Set name for user',
                            maxlines: 1,
                            obscureText: false,
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextWidget(
                            title: 'Email',
                            txtSize: 20,
                            txtColor: txtColor,
                          ),
                          MyTextField(
                            controller: Controllers.useremail,
                            hintText: 'Set email for user',
                            maxlines: 1,
                            obscureText: false,
                            //prefixIcon: const Icon(Icons.money_off_csred),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextWidget(
                            title: 'Pass',
                            txtSize: 20,
                            txtColor: txtColor,
                          ),
                          MyTextField(
                            controller: Controllers.userpass,
                            hintText: 'Set password for user',
                            maxlines: 1,
                            obscureText: false,
                            // prefixIcon: const Icon(Icons.person),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SizedBox(
                        width: 250,
                        child: RadioListTile<String>(
                          title: const Text('Telephonist'),
                          value: "tele",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    FittedBox(
                      child: SizedBox(
                        width: 250,
                        child: RadioListTile<String>(
                          title: const Text('Presenter'),
                          value: "pres",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    //Text('Selected value: $selectedValue'),
                    ElevatedButton(
                      onPressed: () async {
                        if (selectedValue != null) {
                          await authProvider.register(
                              user: USER(
                                  name: Controllers.username.text.trim(),
                                  email: Controllers.useremail.text.trim(),
                                  password: Controllers.userpass.text.trim(),
                                  userType: selectedValue ?? 'pres'));
                        } else {
                          Get.showSnackbar(const GetSnackBar(
                            message: 'Select user type!',
                          ));
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
