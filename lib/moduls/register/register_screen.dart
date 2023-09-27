import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/widgets/custom_text_form_field.dart';
import 'package:todo_app/layout/home_layout.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register_screen";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmpasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: mediaQuery.size.height * 0.07,
          left: 20,
          right: 20,
        ),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/pattern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 5,
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.2,
                ),
                CustemTextFormField(
                  controller: nameController,
                  label: "Full Name",
                  hint: "Enter your full name",
                  validator: (value) {
                    if (value == null || value!.trim().isEmpty) {
                      return "Please enter your name";
                    }
                    if (value!.trim().length < 6) {
                      return "Your name must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                CustemTextFormField(
                  controller: emailController,
                  label: "E-mail Address",
                  hint: "Enter your e-mail address",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your e-mail address";
                    }
                    var regex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    if (!regex.hasMatch(value)) {
                      return "enter valid e-mail address";
                    }
                    return null;
                  },
                ),
                CustemTextFormField(
                  controller: passwordController,
                  label: "Password",
                  hint: "Enter your password",
                  validator: (value) {
                    if (value == null) {
                      return "Please enter your password";
                    }
                    var regx = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if (!regx.hasMatch(value)) {
                      return "Please enter valid password";
                    }
                    return null;
                  },
                ),
                CustemTextFormField(
                  controller: confirmpasswordController,
                  label: "Confirm Password",
                  hint: "Enter your confirm password",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your confirm password";
                    }
                    if (passwordController.text != value) {
                      return "Please enter correct password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Register();
                  },
                  child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Register() async {
    if (formKey.currentState!.validate()) {
      try {
        EasyLoading.show();
        final userCrediential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        EasyLoading.dismiss();
        Navigator.pushNamedAndRemoveUntil(
            context, HomeLayout.routeName, (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          EasyLoading.dismiss();
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          EasyLoading.dismiss();
          print('The account already exists for that email.');
        }
      } catch (e) {
        EasyLoading.dismiss();
        print(e);
      }
    }
  }
}
