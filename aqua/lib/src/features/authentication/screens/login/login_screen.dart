import 'package:aqua/src/constants/sizes.dart';
import 'package:aqua/src/features/authentication/screens/login/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/login_footer_widget.dart';
import 'widgets/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginHeaderWidget(size: size),
                const LoginFormWidget(),
                const LoginFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}


