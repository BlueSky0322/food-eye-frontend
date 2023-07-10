import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_decoration/input_decoration.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../register_page/register_page.dart';
import '../register_page/register_page_state.dart';
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
          icon: const Icon(Icons.arrow_back),
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
          child: Column(
            children: [
              Image.asset(
                'assets/images/banner-logo.png',
                fit: BoxFit.cover,
              ),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: 'Outfit',
                ),
              ),
              const Text(
                "Enter email and password to continue.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Outfit',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                    child: Column(
                      children: [
                        ValueListenableBuilder<bool>(
                            valueListenable: loginPageState.isPasswordVisible,
                            builder: (context, isPassWordVisible, _) {
                              return Form(
                                key: loginPageState.formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: (value) =>
                                          loginPageState.validateEmail(value),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: CustomInputDecoration
                                          .customInputDecoration(
                                              hintText: "example@email.com",
                                              labelText: "Email",
                                              prefixIcon: Icons.email_outlined,
                                              suffixIcon: null),
                                      onChanged: (value) =>
                                          loginPageState.email = value,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        validator: (value) => loginPageState
                                            .validatePassword(value),
                                        obscureText: !loginPageState
                                            .isPasswordVisible.value,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: CustomInputDecoration
                                            .customInputDecoration(
                                          hintText: "Enter your password",
                                          labelText: "Password",
                                          prefixIcon:
                                              Icons.lock_outline_rounded,
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
                                        onChanged: (value) =>
                                            loginPageState.password = value),
                                  ],
                                ),
                              );
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              "Dont have an account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                        create: (context) =>
                                            RegisterPageState(context),
                                        child: const RegisterPage(),
                                      ),
                                    ));
                              },
                              child: const Text(
                                "Create one",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 84, 229, 240),
                                  fontSize: 16,
                                  fontFamily: 'Outfit',
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromARGB(255, 84, 229, 240),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (loginPageState.formKey.currentState!
                                  .validate()) {
                                loginPageState.logintest() != true
                                    ? showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                Colors.white.withOpacity(0.9),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(12.0),
                                                    ),
                                                    color: primaryBG,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 0, 16),
                                                    child: Image.asset(
                                                      'assets/images/error-logo.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const Text(
                                                  "Whoops!",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontFamily: 'Outfit',
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "We can't seem to find your account...",
                                                  style: TextStyle(
                                                    color: Colors.red.shade700,
                                                    fontFamily: 'Outfit',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  "Make sure you are registered first!",
                                                  style: TextStyle(
                                                    color: Colors.red.shade700,
                                                    fontFamily: 'Outfit',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/home',
                                        (route) => false,
                                      );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBtnBG),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Login",
                                    style: TextStyle(
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
