import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './login_screen.dart';
import './register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  static const String routeName = '/login-or-register';

  const LoginOrRegisterScreen({
    super.key,
    required this.isLogin,
  });

  final bool isLogin;

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  late bool _isLogin;

  @override
  void initState() {
    _isLogin = widget.isLogin;
    super.initState();
  }

  void _toggleLoginRegister() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Decorate the background with blobs (from svg)
            // For register screen
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linearToEaseOut,
              top: -180.0,
              right: _isLogin ? -300.0 : 0.0,
              child: SvgPicture.asset(
                'assets/svg/register_blob_top_right.svg',
                height: 500,
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linearToEaseOut,
              bottom: -280.0,
              left: _isLogin ? -350.0 : -100.0,
              child: SvgPicture.asset(
                'assets/svg/register_blob_bottom_left.svg',
                height: 500,
              ),
            ),

            // For login screen
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linearToEaseOut,
              top: -50.0,
              left: _isLogin ? -100.0 : -400.0,
              child: SvgPicture.asset(
                'assets/svg/login_blob_top_left.svg',
                height: 500,
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linearToEaseOut,
              bottom: -80.0,
              right: _isLogin ? -100.0 : -400.0,
              child: SvgPicture.asset(
                'assets/svg/login_blob_bottom_right.svg',
                height: 500,
              ),
            ),

            // Main content TODO:
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              left: _isLogin ? 0 : -MediaQuery.of(context).size.width,
              bottom: 0,
              top: 0,
              child: LoginScreen(toggleLoginRegister: _toggleLoginRegister),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              left: _isLogin ? MediaQuery.of(context).size.width : 0,
              bottom: 0,
              top: 0,
              child: RegisterScreen(toggleLoginRegister: _toggleLoginRegister),
            ),
          ],
        ),
      ),
    );
  }
}