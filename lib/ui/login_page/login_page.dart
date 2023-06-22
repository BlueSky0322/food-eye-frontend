import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/input_decoration.dart';
import 'package:food_eye_fyp/components/my_textfield.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'login_page_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginPageState = Provider.of<LoginPageState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBG,
        elevation: 0,
        toolbarHeight: 70,
        // Remove the shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Back",
            style: TextStyle(
                fontFamily: 'Outfit', fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: primaryBG,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: Image.asset(
              'assets/images/login-page-blank.png',
            ).image,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/banner-logo.png',
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome back, you\'ve been missed!",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Outfit'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: loginPageState.isPasswordVisible,
                    builder: (context, isPassWordVisible, _) {
                      return Form(
                        key: loginPageState.formKey,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              35, 0, 35, 0),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) =>
                                    loginPageState.validateEmail(value),
                                style: const TextStyle(color: Colors.white),
                                decoration:
                                    CustomInputDecoration.customInputDecoration(
                                        hintText: "example@email.com",
                                        labelText: "Email",
                                        prefixIcon: Icons.email_outlined,
                                        suffixIcon: null),
                                onChanged: (value) {
                                  loginPageState.email;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  validator: (value) =>
                                      loginPageState.validatePassword(value),
                                  obscureText:
                                      !loginPageState.isPasswordVisible.value,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: CustomInputDecoration
                                      .customInputDecoration(
                                    hintText: "Enter your password",
                                    labelText: "Password",
                                    prefixIcon: Icons.lock_outline_rounded,
                                    suffixIcon: IconButton(
                                      icon: Icon(!loginPageState
                                              .isPasswordVisible.value
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      color: const Color.fromARGB(
                                          255, 96, 180, 206),
                                      onPressed: () {
                                        loginPageState
                                            .togglePasswordVisibility();
                                      },
                                    ),
                                  ),
                                  onChanged: (value) {
                                    loginPageState.email;
                                  }),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
