import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/services/add_product_service.dart';
import 'package:product_app/screen/add_product/bloc/add_product_bloc.dart';
import 'package:product_app/screen/delete_product/bloc/delete_product_bloc.dart';
import 'package:product_app/services/delete_product_service.dart';
import 'package:product_app/screen/login/bloc/login_bloc.dart';
import 'package:product_app/screen/login/login_screen.dart';
import 'package:product_app/services/login_service.dart';
import 'package:product_app/screen/product_update/bloc/product_update_bloc.dart';
import 'package:product_app/services/product_update_service.dart';
import 'package:product_app/screen/register/bloc/register_bloc.dart';
import 'package:product_app/services/register_service.dart';
import 'package:product_app/screen/user_update/bloc/user_update_bloc.dart';
import 'package:product_app/services/user_update_service.dart';
import 'package:product_app/screen/view/bottom_screen.dart';
import 'package:product_app/utils/app_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  AppPreference.init();
  runApp(MyApp());
}

int pageIndex = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(LoginService()),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(RegisterService()),
        ),
        BlocProvider<UserUpdateBloc>(
          create: (context) => UserUpdateBloc(UpdateService()),
        ),
        BlocProvider<AddProductBloc>(
          create: (context) => AddProductBloc(AddProductService()),
        ),
        BlocProvider<ProductUpdateBloc>(
          create: (context) => ProductUpdateBloc(ProductUpdateService()),
        ),
        BlocProvider<DeleteProductBloc>(
          key: UniqueKey(), // assign the key
          create: (context) => DeleteProductBloc(DeleteProductService()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.teal),
        debugShowCheckedModeBanner: false,
        home: AppPreference.getBool(AppStrings.loginStatus) == true
            ? BottomScreen()
            : LoginScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
