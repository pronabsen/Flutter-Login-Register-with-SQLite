import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management/database/sp_helper.dart';
import 'package:library_management/screens/register_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../database/database_helper.dart';
import '../main.dart';
import '../store/user_signup.dart';
import '../utils/Colors.dart';
import '../utils/widgets.dart';
import 'home_screen.dart';

class LoginWithPassScreen extends StatefulWidget {
  const LoginWithPassScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithPassScreen> createState() => _LoginWithPassScreenState();
}

class _LoginWithPassScreenState extends State<LoginWithPassScreen> {
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _passwordController  = TextEditingController();

  final dbHelper = DatabaseHelper.instance;

  bool isIconTrue = false;
  bool isChecked = false;

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

  final _formKey = GlobalKey<FormState>();
  var userinfo;

  String email = '';
  String password = '';

  bool? checkBoxValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var userinfo = ModalRoute.of(context)!.settings.arguments;
    /*if (_emailController == null || _passwordController == null) {
      if (userinfo == null) {
        _emailController = TextEditingController();
        _passwordController = TextEditingController();
      } else {
        userinfo as UserCreadential;
        _emailController = TextEditingController(text: userinfo.user_email);
        _passwordController = TextEditingController(text: userinfo.user_password);
      }
    }*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
       // appBar: careaAppBarWidget(context),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(height: 130, width: 130, fit: BoxFit.fitWidth, image: AssetImage('assets/app_icon.png')),
                  Text('Login to Your Account', style: boldTextStyle(size: 24)),
                  const SizedBox(height: 30),
                  TextFormField(
                    focusNode: f1,
                    onFieldSubmitted: (v) {
                      f1.unfocus();
                      FocusScope.of(context).requestFocus(f2);
                    },
                    validator: (k) {
                      if (!k!.contains('@')) {
                        return 'Please enter the correct email';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: inputDecoration(context, prefixIcon: Icons.mail_rounded, hintText: "Email"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: isIconTrue,
                    focusNode: f2,
                    validator: (value) {
                      return Validate.validate(value!);
                    },
                    onFieldSubmitted: (v) {
                      f2.unfocus();
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                  const SizedBox(height: 8),
                  Theme(
                    data: ThemeData(unselectedWidgetColor: appStore.isDarkModeOn ? Colors.white : black),
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text("Remember Me", style: primaryTextStyle()),
                      value: checkBoxValue,
                      dense: true,
                      onChanged: (newValue) {
                        setState(() {
                          checkBoxValue = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {

                      if (_formKey.currentState!.validate()) {

                        email = _emailController!.text;
                        password = _passwordController!.text;

                        if(email.isEmptyOrNull || password.isEmptyOrNull){
                          print('Data:- ');
                        } else{
                          print('Data:- $email / $password');

                          Map<String, dynamic> loginBody = {
                            DatabaseHelper.EMAIL : email,
                            DatabaseHelper.PASSWORD  : password
                          };
                          final login = await dbHelper.loginUsers(loginBody);
                          print(login);
                          if(login == null){
                            toast('Login Failed! Please Verify Credential');
                          } else{
                            toast('Login Success!');

                            SPHelper.setString('userName', login['name'].toString());
                            SPHelper.setString('userMail', login['email'].toString());
                            SPHelper.setInt('isLoggedIn', 1);

                            Future.delayed(const Duration(seconds: 1), (){
                              Get.to(const HomeScreen());
                            });
                          }

                        //  final allRows = await dbHelper.getAllUsers();
                          //   print('query all rows:');
                          // allRows?.forEach(print);
                        }
                      } else {
                        print("Not Validated");
                      }
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: const BorderRadius.all(Radius.circular(45)),
                        backgroundColor: appSecBackGroundColor,
                      ),
                      child: Text('Lgoin', style: boldTextStyle(color: white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPassScreen()));
                    },
                    child: Text('Forgot the password ?', style: boldTextStyle()),
                  ),
                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpScreen()),);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: secondaryTextStyle(),
                        children: [
                          TextSpan(text: ' Create New', style: boldTextStyle(size: 14)),
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
