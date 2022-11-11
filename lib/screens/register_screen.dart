import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../database/database_helper.dart';
import '../main.dart';
import '../utils/Colors.dart';
import '../utils/widgets.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();

  bool isIconTrue = false;
  String name = '';
  String email = '';
  String password = '';

  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
     // appBar: careaAppBarWidget(context),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(height: 110, width: 110, fit: BoxFit.cover, image: AssetImage('assets/app_icon.png'),),
                  const SizedBox(height: 16),
                  Text('Create Your Account', style: boldTextStyle(size: 24)),
                  const SizedBox(height: 40),
                  TextFormField(
                    autofocus: false,
                    validator: (value) {
                      if (value.isEmptyOrNull) {
                        return 'Please enter the correct Name';
                      }
                      return null;
                    },
                    autofillHints: const [AutofillHints.name],
                    onFieldSubmitted: (v) {
                     // focusEmail.unfocus();
                      FocusScope.of(context).requestFocus(focusEmail);
                    },
                    controller: _nameController,
                    decoration: inputDecoration(context, prefixIcon: Icons.person, hintText: "Full Name"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autofocus: false,
                    validator: (value) {
                      if (!value!.contains('@') || !value.endsWith(".com")) {
                        return 'Please enter the correct email';
                      }
                      return null;
                    },
                    focusNode: focusEmail,
                    autofillHints: const [AutofillHints.email],
                    onFieldSubmitted: (v) {
                      focusEmail.unfocus();
                      FocusScope.of(context).requestFocus(focusPassword);
                    },
                    controller: _emailController,
                    decoration: inputDecoration(context, prefixIcon: Icons.mail_rounded, hintText: "Email"),
                  ),
                  const SizedBox(height: 20),
                  Observer(
                    builder: (context) => TextFormField(
                      autofocus: false,
                      focusNode: focusPassword,
                      controller: _passwordController,
                      obscureText: isIconTrue,
                      validator: (value){
                        if (value!.isEmpty) {
                          return "* Required";
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (v) {
                        focusPassword.unfocus();
                        if (_formKey.currentState!.validate()) {
                          //
                        }
                      },
                      decoration: inputDecoration(
                        context,
                        prefixIcon: Icons.lock,
                        hintText: "Password",
                        suffixIcon: Theme(
                          data: ThemeData(splashColor: Colors.transparent, highlightColor: Colors.transparent),
                          child: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                isIconTrue = !isIconTrue;
                              });
                            },
                            icon: Icon(
                              (isIconTrue) ? Icons.visibility_rounded : Icons.visibility_off,
                              size: 16,
                              color: appStore.isDarkModeOn ? white : gray,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {

                        name = _nameController.text;
                        email = _emailController.text;
                        password = _passwordController.text;

                        if(name.isEmptyOrNull || email.isEmptyOrNull || password.isEmptyOrNull){
                          print('Data:- ');
                        } else{
                          print('Data:- $name / $email / $password');

                          Map<String, dynamic> registerBody = {
                            DatabaseHelper.NAME : name,
                            DatabaseHelper.EMAIL : email,
                            DatabaseHelper.PASSWORD  : password
                          };
                          final register = await dbHelper.registerUsers(registerBody);

                          if(register == null){
                            const snackBar = SnackBar(content: Text('Already have account!'),);
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else{
                            print('inserted row id: $register');
                            const snackBar = SnackBar(content: Text('Account Created! Please Login'),);
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            Future.delayed(Duration(seconds: 1), (){
                             Get.to(LoginWithPassScreen());
                            });

                          }
                       //   print('query all rows:');
                         // allRows?.forEach(print);
                        }
                      } else {
                        print("Not Validated");
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: const BorderRadius.all(Radius.circular(45)),
                        backgroundColor: appSecBackGroundColor,
                      ),
                      child: Text('Sign Up', style: boldTextStyle(color: white)),
                    ),
                  ),
                  //Divider

                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {

                      Get.to(const LoginWithPassScreen());
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Already have account? ",
                        style: secondaryTextStyle(),
                        children: [
                          TextSpan(text: ' Sign in', style: primaryTextStyle()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
