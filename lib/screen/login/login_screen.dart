import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/constant/app_colors.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/screen/login/bloc/login_bloc.dart';
import 'package:product_app/screen/login/bloc/login_event_bloc.dart';
import 'package:product_app/screen/login/bloc/login_state_bloc.dart';
import 'package:product_app/screen/register/register_screen.dart';
import 'package:product_app/screen/view/bottom_screen.dart';
import 'package:product_app/screen/widget/background.dart';
import 'package:product_app/screen/widget/button.dart';
import 'package:product_app/screen/widget/text_field.dart';
import 'package:product_app/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginKey = GlobalKey<FormState>();

  String? email;
  String? password;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (BuildContext context, state) {
        return BackGroundImage(
            body: Center(
          child: Form(
              key: loginKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(children: [
                    Text(
                      AppStrings.signInText,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: 400,
                      child: textInputField(
                        readOnly: false,
                        icon: Icons.mail,
                        keyboardType: TextInputType.emailAddress,
                        text: AppStrings.emailAddressText,
                        validator: AppValidation.validateEmail,
                        controllers: emailController,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 400,
                      child: textInputField(
                        readOnly: false,
                        text: AppStrings.passwordText,
                        isObscure: true,
                        icon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        validator: AppValidation.password,
                        controllers: passwordController,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              AppStrings.forgotText,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    buttons(
                      buttonName: AppStrings.loginButtonText,
                      buttonHeight: 48.0,
                      buttonWidth: 400.0,
                      fontSize: 20.0,
                      onTap: () {
                        if (loginKey.currentState!.validate()) {
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginUserEvent(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.dontHaveAnAccount,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 2),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppStrings.registerHere,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blue),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              )),
        ));
      },
      listener: (BuildContext context, Object? state) {
        if (state is LoginLoadingState) {
          Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoginLoadedState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomScreen()),
            (route) => false,
          );
        } else if (state is LoginErrorState) {
          Container();
        } else {
          Container();
        }
      },
    );
  }
}
