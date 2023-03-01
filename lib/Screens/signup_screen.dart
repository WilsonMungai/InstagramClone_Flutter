import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isntagram/Resources/Auth_method.dart';
import 'package:isntagram/widgets/text_field_input.dart';
import '../utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenScreenState();
}

class _SignUpScreenScreenState extends State<SignUpScreen> {
  // email text field
  final TextEditingController _emailController = TextEditingController();
  // password text field
  final TextEditingController _passwordController = TextEditingController();
  // email text field
  final TextEditingController _bioController = TextEditingController();
  // password text field
  final TextEditingController _userNameController = TextEditingController();
  // Image picker
  Uint8List? _image;

  // clear text field when widget gets disposed
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  // select image funtion
  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    // set image
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // create flex with a container and a flex of 1 to create space at the top
              Flexible(flex: 2, child: Container()),
              // svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                height: 64,
              ),
              const SizedBox(height: 64),
              // circular widget to accept selection of profile image
              Stack(
                children: [
                  // profile image holder
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg'),
                        ),
                  // add image button
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ))
                ],
              ),
              const SizedBox(height: 48),
              // text field for user name
              TextFieldInput(
                  textEditingController: _userNameController,
                  hintText: 'Enter Your username',
                  textInputType: TextInputType.text),
              const SizedBox(height: 24),
              // textfield for email
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 24),
              // textfield field for password
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter Your Password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 24),
              // textfield for bio
              TextFieldInput(
                  textEditingController: _bioController,
                  hintText: 'Enter Your Bio',
                  textInputType: TextInputType.text),
              const SizedBox(height: 24),
              // button for login
              InkWell(
                onTap: () async {
                  String res = await AuthMethods().signUpUser(
                      username: _userNameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      bio: _bioController.text);
                  print(res);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: Colors.blue),
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),
              // transition to signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(" Log in",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              )
            ],
          )),
    ));
  }
}
