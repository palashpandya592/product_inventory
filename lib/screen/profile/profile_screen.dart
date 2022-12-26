import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:product_app/constant/app_colors.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/screen/login/login_screen.dart';
import 'package:product_app/screen/profile/bloc/profile_screen_bloc.dart';
import 'package:product_app/screen/profile/bloc/profile_screen_event.dart';
import 'package:product_app/screen/profile/bloc/profile_screen_state.dart';
import 'package:product_app/model/profile_user_model.dart';
import 'package:product_app/screen/user_update/bloc/user_update_bloc.dart';
import 'package:product_app/screen/user_update/bloc/user_update_event.dart';
import 'package:product_app/screen/widget/button.dart';
import 'package:product_app/screen/widget/text_field.dart';
import 'package:product_app/utils/app_preferences.dart';
import 'package:product_app/utils/validator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileScreenBloc _userBloc = ProfileScreenBloc();
  final controller = ScrollController();

  @override
  void initState() {
    _userBloc.add(GetUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyAccent,
      appBar: AppBar(
        title: Text(AppStrings.profile),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AppPreference.clear();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: _buildProfile(),
    );
  }

  Widget _buildProfile() {
    return BlocProvider(
      create: (_) => _userBloc,
      child: BlocListener<ProfileScreenBloc, ProfileScreenState>(
        listener: (context, state) {
          if (state is ProfileScreenError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
          builder: (context, state) {
            if (state is ProfileScreenInitial) {
              return _buildLoading();
            } else if (state is ProfileScreenLoading) {
              return _buildLoading();
            } else if (state is ProfileScreenLoaded) {
              return _buildUserProfile(context, state.userModel!);
            } else if (state is ProfileScreenError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, UserModel model) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _dateController = TextEditingController();
    final TextEditingController _genderController = TextEditingController();

    _nameController.text = model.user!.name.toString();
    _emailController.text = model.user!.email.toString();
    _dateController.text = model.user!.birthDate.toString();
    _genderController.text = model.user!.gender.toString();

    final updateKey = GlobalKey<FormState>();

    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: updateKey,
          child: Container(
              width: 400,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      // child: Image.network(
                      //   "${model.user!.image ?? 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}",
                      //   fit: BoxFit.cover,
                      // ),
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 40),
                    textInputField(
                      readOnly: false,
                      controllers: _nameController,
                      validator: AppValidation.nameValidation,
                      icon: Icons.person,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 10),
                    textInputField(
                      readOnly: false,
                      controllers: _emailController,
                      validator: AppValidation.validateEmail,
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      controller: _dateController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        errorStyle: TextStyle(fontSize: 15),
                        contentPadding: EdgeInsets.only(top: 10),
                        hintText: AppStrings.enterDateOfBirth,
                        prefixIcon:
                            Icon(Icons.calendar_month, color: AppColors.black),
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
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          }
                        });
                      },
                      validator: (value) => value!.isEmpty
                          ? AppStrings.pleaseEnterBirthDate
                          : null,
                    ),
                    SizedBox(height: 10),
                    textInputField(
                      readOnly: true,
                      controllers: _genderController,
                      icon: Icons.person,
                    ),
                    SizedBox(height: 20),
                    buttons(
                        buttonName: "Update",
                        buttonHeight: 48.0,
                        buttonWidth: 400.0,
                        fontSize: 20.0,
                        onTap: () {
                          BlocProvider.of<UserUpdateBloc>(context).add(
                            UpdateDataEvent(
                                _nameController.text,
                                _emailController.text,
                                _dateController.text,
                                model.user?.id),
                          );
                        }),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
