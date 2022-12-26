import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:product_app/constant/app_colors.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/screen/login/login_screen.dart';
import 'package:product_app/screen/register/bloc/register_bloc.dart';
import 'package:product_app/screen/register/bloc/register_event.dart';
import 'package:product_app/screen/register/bloc/register_state.dart';
import 'package:product_app/screen/widget/background.dart';
import 'package:product_app/screen/widget/button.dart';
import 'package:product_app/screen/widget/text_field.dart';
import 'package:product_app/utils/validator.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  var _gender = ["Male", "Female", "Other"];

  var _currentSelectedValue;

  File? _image;
  final _picker = ImagePicker();

  final registerKey = GlobalKey<FormState>();

  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    _confirmPasswordController.dispose();
    _currentSelectedValue.dispose();
    super.dispose();
  }

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      print(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      builder: (BuildContext context, state) {
        return BackGroundImage(
          body: Center(
            child: Form(
              key: registerKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.signUpText,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: _openImagePicker,
                        child: CircleAvatar(
                          radius: 55,
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.file(
                                    _image!,
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.bottomRight,
                                  decoration: BoxDecoration(
                                    color: AppColors.greyAccent,
                                    borderRadius: BorderRadius.circular(60),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                                    ),
                                  ),
                                  width: 110,
                                  height: 110,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppColors.grey,
                                    size: 25,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 400,
                        child: textInputField(
                          readOnly: false,
                          controllers: _nameController,
                          text: AppStrings.firstName,
                          validator: AppValidation.nameValidation,
                          icon: Icons.person,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 400,
                        child: textInputField(
                          readOnly: false,
                          keyboardType: TextInputType.emailAddress,
                          text: AppStrings.emailAddressText,
                          icon: Icons.mail,
                          validator: AppValidation.validateEmail,
                          controllers: _emailController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          width: 400.0,
                          child: textInputField(
                            readOnly: false,
                            keyboardType: TextInputType.visiblePassword,
                            text: AppStrings.passwordText,
                            controllers: _passwordController,
                            icon: Icons.lock_outline,
                            isObscure: true,
                            validator: AppValidation.validatePassword,
                          ),
                        ),
                      ),
                      Container(
                        width: 400,
                        child: textInputField(
                          readOnly: false,
                          controllers: _confirmPasswordController,
                          text: AppStrings.confirmPasswordText,
                          isObscure: true,
                          icon: Icons.lock,
                          validator: (validator) {
                            if (validator.isEmpty) {
                              return AppStrings.enterConfirmPassword;
                            }
                            if (validator != _passwordController.text) {
                              return AppStrings.passwordNotMatch;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                            width: 400.0,
                            child: TextFormField(
                              readOnly: true,
                              controller: _dateController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(),
                                errorStyle: TextStyle(fontSize: 15),
                                contentPadding: EdgeInsets.only(top: 10),
                                hintText: AppStrings.enterDateOfBirth,
                                prefixIcon: Icon(Icons.calendar_month,
                                    color: AppColors.black),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    _dateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                  }
                                });
                              },
                              validator: (value) => value!.isEmpty
                                  ? AppStrings.pleaseEnterBirthDate
                                  : null,
                            )),
                      ),
                      Container(
                        width: 400,
                        child: FormField<String>(
                          validator: (value) =>
                              value!.isEmpty ? AppStrings.enterGender : null,
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  labelText: AppStrings.gender,
                                  hintText: AppStrings.gender,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  prefixIcon: Icon(Icons.person,
                                      color: AppColors.black)),
                              isEmpty: _currentSelectedValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentSelectedValue,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _currentSelectedValue = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: _gender.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: buttons(
                          buttonHeight: 48.0,
                          buttonWidth: 400.0,
                          buttonName: AppStrings.registerButtonText,
                          fontSize: 20.0,
                          onTap: () {
                            if (registerKey.currentState!.validate()) {
                              BlocProvider.of<RegisterBloc>(context).add(
                                SendDataEvent(
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  _confirmPasswordController.text,
                                  _dateController.text,
                                  _currentSelectedValue,
                                  _image.toString(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.alreadyRegister,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 2),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false);
                            },
                            child: Text(
                              AppStrings.loginHere,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is RegisterLoadedState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
    );
  }
}
