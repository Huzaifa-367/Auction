// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_admin_dashboard/providers/register_form_provider.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter_admin_dashboard/providers/Controllers.dart';
// import '../../../Global/constants.dart';

// // las vistas no tienen scaffold
// // los layouts si tienen scaffold

// class RegisterView extends StatelessWidget {
//   RegisterView({super.key});

//   late RegisterFormProvider registerFormProvider;
//   @override
//   Widget build(BuildContext context) {
//     registerFormProvider = context.read<RegisterFormProvider>();

//     var size = MediaQuery.of(context).size;
//     var theme = Theme.of(context);

//     return ChangeNotifierProvider(
//       create: (_) => RegisterFormProvider(),
//       child: Builder(
//         builder: (context) {
//           final registerFormProvider =
//               Provider.of<RegisterFormProvider>(context, listen: false);

//           return GestureDetector(
//             onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//             child: Scaffold(
//               backgroundColor: Colors.white,
//               resizeToAvoidBottomInset: false,
//               body: LayoutBuilder(
//                 builder: (context, constraints) {
//                   if (constraints.maxWidth > 600) {
//                     return _buildLargeScreen(size, theme);
//                   } else {
//                     return _buildSmallScreen(size, theme);
//                   }
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   /// For large screens
//   Widget _buildLargeScreen(Size size, ThemeData theme) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 4,
//           child: RotatedBox(
//             quarterTurns: 3,
//             child: Lottie.asset(
//               'assets/coin.json',
//               height: size.height * 0.3,
//               width: double.infinity,
//               fit: BoxFit.fill,
//             ),
//           ),
//         ),
//         SizedBox(width: size.width * 0.06),
//         Expanded(
//           flex: 5,
//           child: _buildMainBody(size, theme),
//         ),
//       ],
//     );
//   }

//   /// For Small screens
//   Widget _buildSmallScreen(Size size, ThemeData theme) {
//     return Center(
//       child: _buildMainBody(size, theme),
//     );
//   }

//   /// Main Body
//   Widget _buildMainBody(Size size, ThemeData theme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment:
//           size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
//       children: [
//         size.width > 600
//             ? Container()
//             : Lottie.asset(
//                 'assets/wave.json',
//                 height: size.height * 0.2,
//                 width: size.width,
//                 fit: BoxFit.fill,
//               ),
//         SizedBox(
//           height: size.height * 0.03,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: Text(
//             'Sign Up',
//             style: kLoginTitleStyle(size),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: Text(
//             'Create Account',
//             style: kLoginSubtitleStyle(size),
//           ),
//         ),
//         SizedBox(
//           height: size.height * 0.03,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 20),
//           child: Form(
//             key: registerFormProvider.formKey,
//             child: Column(
//               children: [
//                 /// username
//                 TextFormField(
//                   style: kTextFormFieldStyle(),
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.person),
//                     hintText: 'Username',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                     ),
//                   ),

//                   controller: Controllers.username,
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter username';
//                     } else if (value.length < 4) {
//                       return 'at least enter 4 characters';
//                     } else if (value.length > 13) {
//                       return 'maximum character is 13';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),

//                 /// Gmail
//                 TextFormField(
//                   style: kTextFormFieldStyle(),
//                   controller: Controllers.useremail,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.email_rounded),
//                     hintText: 'gmail',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                     ),
//                   ),
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter gmail';
//                     } else if (!value.endsWith('@gmail.com')) {
//                       return 'please enter valid gmail';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),

//                 /// password
//                 TextFormField(
//                   style: kTextFormFieldStyle(),
//                   controller: Controllers.userpass,
//                   obscureText: false,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock_open),
//                     suffixIcon: IconButton(
//                       icon: const Icon(
//                         // simpleUIController.isObscure.value
//                         //     ? Icons.visibility
//                         //     :
//                         Icons.visibility_off,
//                       ),
//                       onPressed: () {},
//                     ),
//                     hintText: 'Password',
//                     border: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                     ),
//                   ),
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter some text';
//                     } else if (value.length < 7) {
//                       return 'at least enter 6 characters';
//                     } else if (value.length > 13) {
//                       return 'maximum character is 13';
//                     }
//                     return null;
//                   },
//                 ),

//                 SizedBox(
//                   height: size.height * 0.01,
//                 ),
//                 Text(
//                   'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
//                   style: kLoginTermsAndPrivacyStyle(size),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),

//                 /// SignUp Button
//                 signUpButton(theme),
//                 SizedBox(
//                   height: size.height * 0.03,
//                 ),

//                 /// Navigate To Login Screen
//                 GestureDetector(
//                   onTap: () {
//                     Controllers.clearusersControllers();
//                     registerFormProvider.formKey.currentState?.reset();
//                   },
//                   child: GestureDetector(
//                     child: RichText(
//                       text: TextSpan(
//                         text: 'Already have an account?',
//                         style: kHaveAnAccountStyle(size),
//                         children: [
//                           TextSpan(
//                               text: " Login",
//                               style: kLoginOrSignUpTextStyle(size)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // SignUp Button
//   Widget signUpButton(ThemeData theme) {
//     return SizedBox(
//       width: double.infinity,
//       height: 55,
//       child: ElevatedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//         ),
//         onPressed: () {
//           // Validate returns true if the form is valid, or false otherwise.
//           if (registerFormProvider.formKey.currentState!.validate()) {
//             // ... Navigate To your Home Page
//           }
//         },
//         child: const Text('Sign up'),
//       ),
//     );
//   }
// }

// class _CapitalizedWordsTextFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String capitalizedText = newValue.text.toLowerCase();
//     List<String> words = capitalizedText.split(' ');

//     for (int i = 0; i < words.length; i++) {
//       String word = words[i];
//       if (word.isNotEmpty) {
//         words[i] = word[0].toUpperCase() + word.substring(1);
//       }
//     }

//     capitalizedText = words.join(' ');

//     return TextEditingValue(
//       text: capitalizedText,
//       selection: newValue.selection,
//     );
//   }
// }
