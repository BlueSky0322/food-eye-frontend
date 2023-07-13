import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/success_alert_dialog.dart';
import 'package:food_eye_fyp/ui/login_page/login_page.dart';
import 'package:food_eye_fyp/ui/login_page/login_page_state.dart';
import 'package:food_eye_fyp/ui/register_page/register_page_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/custom_input_decoration/input_decoration.dart';
import '../../components/error_alert_dialog.dart';
import '../../utils/constants.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final registerPageState = Provider.of<RegisterPageState>(context);
    TextEditingController dobController = TextEditingController();
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
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Column(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Create a new account.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 20),
                    child: Column(
                      children: [
                        ValueListenableBuilder<bool>(
                            valueListenable:
                                registerPageState.isPasswordVisible,
                            builder: (context, isPassWordVisible, _) {
                              return Form(
                                key: registerPageState.formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: (value) => registerPageState
                                          .validateEmail(value),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: CustomInputDecoration
                                          .customInputDecoration(
                                              hintText: "example@email.com",
                                              labelText: "Email",
                                              prefixIcon: Icons.email_outlined,
                                              suffixIcon: null),
                                      onChanged: (value) =>
                                          registerPageState.email = value,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: (value) => registerPageState
                                          .validatePassword(value),
                                      obscureText: !registerPageState
                                          .isPasswordVisible.value,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: CustomInputDecoration
                                          .customInputDecoration(
                                        hintText: "Enter your password",
                                        labelText: "Password",
                                        prefixIcon: Icons.lock_outline_rounded,
                                        suffixIcon: IconButton(
                                          icon: Icon(!registerPageState
                                                  .isPasswordVisible.value
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          color: const Color.fromARGB(
                                              255, 96, 180, 206),
                                          onPressed: () {
                                            registerPageState
                                                .togglePasswordVisibility();
                                          },
                                        ),
                                      ),
                                      onChanged: (value) =>
                                          registerPageState.password = value,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Name
                                    TextFormField(
                                      validator: (value) =>
                                          registerPageState.validateName(value),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: CustomInputDecoration
                                          .customInputDecoration(
                                              hintText: "Enter your name",
                                              labelText: "Name",
                                              prefixIcon:
                                                  Icons.person_outline_rounded,
                                              suffixIcon: null),
                                      onChanged: (value) =>
                                          registerPageState.name = value,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Age
                                    TextFormField(
                                        validator: (value) {
                                          final parsedAge =
                                              int.tryParse(value ?? '');
                                          return registerPageState
                                              .validateAge(parsedAge);
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: CustomInputDecoration
                                            .customInputDecoration(
                                                hintText: "Enter your age",
                                                labelText: "Age",
                                                prefixIcon:
                                                    Icons.numbers_outlined,
                                                suffixIcon: null),
                                        onChanged: (value) {
                                          int parsedAge = int.parse(value);
                                          registerPageState.age = parsedAge;
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Address
                                    TextFormField(
                                      validator: (value) => registerPageState
                                          .validateAddress(value),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: CustomInputDecoration
                                          .customInputDecoration(
                                              hintText: "Enter your address",
                                              labelText: "Adress",
                                              prefixIcon:
                                                  Icons.home_work_outlined,
                                              suffixIcon: null),
                                      onChanged: (value) =>
                                          registerPageState.address = value,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Date of birth
                                    TextFormField(
                                      readOnly: true,
                                      validator: (value) {
                                        final selectedDate =
                                            DateTime.tryParse(value ?? '');
                                        // DateTime parsedDate =
                                        //     DateTime.parse(value!);

                                        return registerPageState
                                            .validateDob(selectedDate);
                                      },
                                      controller: dobController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: CustomInputDecoration
                                          .customInputDecoration(
                                        hintText: "Enter your date of birth",
                                        labelText: "Date of Birth",
                                        prefixIcon: Icons.cake_outlined,
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          color: Colors.white,
                                          onPressed: () async {
                                            // Show the date picker
                                            final selectedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime.now(),
                                            );
                                            // Handle the selected date
                                            if (selectedDate != null) {
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate);
                                              DateTime parsedDate =
                                                  DateTime.parse(formattedDate);

                                              // Update the value in your registerPageState
                                              registerPageState.dateOfBirth =
                                                  parsedDate;
                                              // Update the text in the TextFormField
                                              dobController.text =
                                                  formattedDate;
                                            }
                                          },
                                        ),
                                      ),
                                      onChanged: (value) {
                                        DateTime parsedDate =
                                            DateTime.parse(value);
                                        registerPageState.dateOfBirth =
                                            parsedDate;
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (registerPageState.formKey.currentState!
                                  .validate()) {
                                if (registerPageState.register() != true) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const CustomErrorAlertDialog(
                                        imageAsset:
                                            'assets/images/error-logo.png',
                                        title: "Whoops!",
                                        subtitle: "Something went wrong...",
                                        description:
                                            "Sorry, but please try again later!",
                                      );
                                    },
                                  );
                                } else {
                                  final currentContext = context;
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const CustomSuccessAlertDialog(
                                        imageAsset:
                                            'assets/images/newuser-logo.png',
                                        title: "Congratulations",
                                        subtitle: "Registration successful!",
                                        description:
                                            "You can now log in with your new account.",
                                      );
                                    },
                                  ).then((_) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                          create: (context) =>
                                              LoginPageState(currentContext),
                                          child: const LoginPage(),
                                        ),
                                      ),
                                    );
                                  });
                                }
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Register",
                                  style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: primaryBtnText),
                                ),
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
