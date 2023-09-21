import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/buttons/ButtonWidget.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/inputs/TextField_Round.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
import 'package:flutter_admin_dashboard/providers/auth_provider.dart';
import 'package:flutter_admin_dashboard/providers/login_form_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_admin_dashboard/providers/Controllers.dart';
import '../../../Global/constants.dart';
import 'package:get/get.dart';
// las vistas no tienen scaffold
// los layouts si tienen scaffold

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  late AuthProvider authProvider;
  bool? isVisible = true;
  late LoginFormProvider loginFormProvider;
  // String _errorText = '';

  // void _validateInput(String value) {
  //   final emailRegex =
  //       RegExp(r'^[\w\.-]+@(gmail.com|yahoo.com|hotmail.com|outlook.com)$');

  //   setState(() {
  //     if (value.isEmpty) {
  //       _errorText = '';
  //     } else {
  //       if (!emailRegex.hasMatch(value)) {
  //         _errorText = 'Please enter a valid email address.';
  //       } else {
  //         _errorText = '';
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(builder: (context) {
        loginFormProvider =
            Provider.of<LoginFormProvider>(context, listen: false);

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return _buildLargeScreen(size);
                } else {
                  return _buildSmallScreen(
                    size,
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }

  void onFormSubmit(
      LoginFormProvider loginFormProvider, AuthProvider authProvider) {
    final isValid = loginFormProvider.validateForm();
    if (isValid) {
      authProvider.login(
          Controllers.useremail.text.trim(), Controllers.userpass.text.trim());
    }
  }

  Widget _buildLargeScreen(
    Size size,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 3,
            child: Lottie.asset(
              'assets/coin.json',
              height: size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(
            size,
          ),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
  ) {
    return Center(
      child: _buildMainBody(
        size,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: size.width > 600
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          size.width > 600
              ? Container()
              : Lottie.asset(
                  'assets/wave.json',
                  height: size.height * 0.2,
                  width: size.width,
                  fit: BoxFit.fill,
                ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Login',
              style: kLoginTitleStyle(size),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextWidget(
              title: 'Welcome Back To OSA Auction',
              txtSize: 25,
              txtColor: txtColor,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: loginFormProvider.formKey,
              child: Column(
                children: [
                  /// username or Gmail
                  // TextFormField(
                  //   style: kTextFormFieldStyle(),
                  //   decoration: const InputDecoration(
                  //     prefixIcon: Icon(Icons.person),
                  //     hintText: 'Username or Gmail',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //     ),
                  //   ),
                  //   controller: Controllers.useremail,
                  //   // The validator receives the text that the user has entered.
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter username';
                  //     }
                  //     // else if (value.length < 4) {
                  //     //   return 'at least enter 4 characters';
                  //     // } else if (value.length > 13) {
                  //     //   return 'maximum character is 13';
                  //     // }
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.02,
                  // ),

                  TextFormField(
                    controller: Controllers.useremail,
                    decoration: const InputDecoration(
                      // errorText: _errorText.isNotEmpty ? _errorText : null,
                      prefixIcon: Icon(Icons.email_rounded),
                      hintText: 'Gmail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    // onChanged: _validateInput,

                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter gmail';
                    //   } else if (!value.endsWith('@gmail.com')) {
                    //     return 'please enter valid gmail';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// password
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    controller: Controllers.userpass,
                    obscureText: isVisible!,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isVisible! ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          // simpleUIController.isObscureActive();
                          setState(() {
                            isVisible = !isVisible!;
                          });
                        },
                      ),
                      hintText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      // else if (value.length < 7) {
                      //   return 'at least enter 6 characters';
                      // } else if (value.length > 13) {
                      //   return 'maximum character is 13';
                      // }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  // Text(
                  //   'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                  //   style: kLoginTermsAndPrivacyStyle(size),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// Login Button
                  // loginButton(),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ButtonWidget(
                        btnText: "Login",
                        onPress: () {
                          onFormSubmit(loginFormProvider, authProvider);
                        }),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// Navigate To Login Screen
                  // GestureDetector(
                  //   onTap: () {
                  //     //Navigator.pop(navigator.c);

                  //     _formKey.currentState?.reset();
                  //     //NavigationService.navigateTo(Flurorouter.registerRoute);
                  //     //Get.to(RegisterView());
                  //     //  simpleUIController.isObscure.value = true;
                  //   },
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Controllers.clearusersControllers();
                  //       _formKey.currentState?.reset();
                  //       NavigationService.navigateTo(Flurorouter.registerRoute);
                  //     },
                  //     child: RichText(
                  //       text: TextSpan(
                  //         text: 'Don\'t have an account?',
                  //         style: kHaveAnAccountStyle(size),
                  //         children: [
                  //           TextSpan(
                  //             text: " Sign up",
                  //             style: kLoginOrSignUpTextStyle(
                  //               size,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          onFormSubmit(loginFormProvider, authProvider);
        },
        child: const Text('Login'),
      ),
    );
  }
}
