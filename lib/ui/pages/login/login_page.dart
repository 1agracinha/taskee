import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:taskee/ui/helpers/helpers.dart';
import 'package:taskee/ui/mixins/validator_mixin.dart';
import 'package:taskee/ui/pages/newTask/components/custom_task_field.dart';
import 'package:taskee/ui/pages/register/register_page.dart';

import 'controller/login_controller.dart';

class LoginPage extends StatefulWidget with Validators {
  static const route = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginController>();
    return BlocConsumer<LoginController, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(controller.failureMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.all(20),
                      color: primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Welcome!'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 100),
                          CustomTaskFieldWidget(
                            labelText: 'Email',
                            semanticsLabel: 'Email text field'.tr,
                            inputType: TextInputType.emailAddress,
                            controller: emailController,
                            maxLines: 1,
                            obscureText: false,
                            validator: (value) => widget.validateEmail(value),
                          ),
                          SizedBox(height: 35),
                          CustomTaskFieldWidget(
                            labelText: 'Password'.tr,
                            semanticsLabel: 'Password text field'.tr,
                            inputType: TextInputType.visiblePassword,
                            maxLines: 1,
                            controller: passwordController,
                            obscureText: obscureText,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                obscureText = !obscureText;
                                setState(() {});
                              },
                              child: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            validator: (value) =>
                                widget.validatePassword(value),
                          ),
                          SizedBox(height: 35),
                          ElevatedButton(
                            child: state is LoginLoading
                                ? CircularProgressIndicator(
                                    color: primaryColor,
                                  )
                                : Text('Sign in'.tr),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(400, 60),
                              primary: Colors.white,
                              onPrimary: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              final validate =
                                  _formKey.currentState!.validate();
                              if (validate) {
                                final email = emailController.value.text;
                                final password = passwordController.value.text;
                                controller.login(email, password);
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              }
                            },
                          ),
                          SizedBox(height: 35),
                          ElevatedButton(
                            child: Text('Create new account'.tr),
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 1.5, color: Colors.white),
                              minimumSize: Size(400, 60),
                              primary: Colors.transparent,
                              elevation: 0,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => Get.toNamed(RegisterPage.route),
                          ),
                          SizedBox(height: 35),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
