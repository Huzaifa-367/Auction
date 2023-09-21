import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Auth/login_view.dart';
import 'package:flutter_admin_dashboard/ui/layouts/auth/widgets/Auth_LeftSide.dart';
import 'package:flutter_admin_dashboard/ui/layouts/auth/widgets/custom_title.dart';

// los layouts si tienen scaffold
// las vistas no tienen scaffold

class AuthLayout extends StatelessWidget {
  final Widget child;
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    ScrollController scrollController =
        ScrollController(initialScrollOffset: 0);

    // para agregar una barra de desplazamiento, necesitamos agregar el Scrollbar
    // para ello tambien sera necesario agregar el ScrollController
    // y adicionarlo tanto dentro del Scrollbar como dentro del ListView
    // por ultimo en el main, manejo el estilo del scrollbar

    return Scaffold(
        backgroundColor: Colors.white,
        body: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child:LoginView()
        ));
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({required this.child});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomTitle(),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 560,
            child: child, // child is LoginView
          ),
          const SizedBox(
            width: double.infinity,
            height: 340,
            child: BackgroundTwitter(),
          ),
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({required this.child});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width,
      height: size.height * 0.9,
      color: Colors.white,
      child: Column(
        children: [
          const CustomTitle(),
          const SizedBox(height: 10),
          Expanded(child: child)
        ],
      ),
    );
  }
}


