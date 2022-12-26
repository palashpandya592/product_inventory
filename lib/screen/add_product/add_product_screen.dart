import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_app/constant/app_colors.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/main.dart';
import 'package:product_app/screen/add_product/bloc/add_product_bloc.dart';
import 'package:product_app/screen/add_product/bloc/add_product_event.dart';
import 'package:product_app/screen/add_product/bloc/add_product_state.dart';
import 'package:product_app/model/home_screen_model.dart';
import 'package:product_app/screen/product_update/bloc/product_update_bloc.dart';
import 'package:product_app/screen/product_update/bloc/product_update_event.dart';
import 'package:product_app/screen/view/bottom_screen.dart';
import 'package:product_app/screen/widget/button.dart';
import 'package:product_app/screen/widget/text_field.dart';
import 'package:product_app/utils/validator.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({
    Key? key,
    this.name,
    this.mrp,
    this.selling,
    this.description,
    this.image,
    this.title,
    this.id,
  }) : super(key: key);
  final name;
  final mrp;
  final selling;
  final description;
  final image;
  final title;
  final id;

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mrpController = TextEditingController();
  final TextEditingController _sellingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Datum>? listItem = [];

  File? _image;
  final _picker = ImagePicker();
  String? title;
  int? id;

  final addProductKey = GlobalKey<FormState>();

  void initState() {
    _nameController.text = widget.name.toString();
    _mrpController.text = widget.mrp.toString();
    _sellingController.text = widget.selling.toString();
    _descriptionController.text = widget.description.toString();
    // _image = widget.image;
    title = widget.title;
    id = widget.id;
    super.initState();
  }

  void dispose() {
    _nameController.dispose();
    _mrpController.dispose();
    _sellingController.dispose();
    _descriptionController.dispose();
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
    return BlocConsumer<AddProductBloc, AddProductState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('${title!} Page'),
          ),
          body: Center(
            child: Form(
              key: addProductKey,
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                        'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                      ),
                                      fit: BoxFit.cover),
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
                        text: AppStrings.productName,
                        validator: AppValidation.nameValidation,
                        icon: Icons.drive_file_rename_outline,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 400,
                      child: textInputField(
                        readOnly: false,
                        validator: AppValidation.numberValidation1,
                        controllers: _mrpController,
                        text: AppStrings.productPrice,
                        icon: Icons.price_check,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 400,
                      child: textInputField(
                        validator: AppValidation.numberValidation1,
                        readOnly: false,
                        controllers: _sellingController,
                        text: AppStrings.productSelling,
                        icon: Icons.numbers,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 400,
                      child: textInputField(
                        validator: AppValidation.nameValidation,
                        readOnly: false,
                        controllers: _descriptionController,
                        text: AppStrings.productDescription,
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    SizedBox(height: 30),
                    buttons(
                      buttonName: title,
                      buttonHeight: 48.0,
                      buttonWidth: 400.0,
                      fontSize: 20.0,
                      onTap: () {
                        if (addProductKey.currentState!.validate()) {
                          if (title == 'Add Product') {
                            BlocProvider.of<AddProductBloc>(context).add(
                              AddProductDataEvent(
                                _nameController.text,
                                _mrpController.text,
                                _sellingController.text,
                                _descriptionController.text,
                                _image.toString(),
                              ),
                            );
                          } else {
                            BlocProvider.of<ProductUpdateBloc>(context).add(
                              ProductUpdateDataEvent(
                                _nameController.text,
                                _mrpController.text,
                                _sellingController.text,
                                _descriptionController.text,
                                _image.toString(),
                                widget.id,
                              ),
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  pageIndex = 0;
                                  return BottomScreen();
                                },
                              ),
                              (route) => false,
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              )),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is AddProductLoadingState) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              pageIndex = 0;
              return BottomScreen();
            },
          ), (route) => false);
        }
      },
    );
  }
}
