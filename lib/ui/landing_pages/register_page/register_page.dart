import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_fields/register_fields/date_field.dart';
import 'package:food_eye_fyp/components/custom_input_fields/register_fields/int_field.dart';
import 'package:food_eye_fyp/components/custom_input_fields/register_fields/text_field.dart';
import 'package:food_eye_fyp/components/custom_input_fields/register_fields/userrole_field.dart';
import 'package:food_eye_fyp/components/success_alert_dialog.dart';
import 'package:food_eye_fyp/ui/landing_pages/login_page/login_page.dart';
import 'package:food_eye_fyp/ui/landing_pages/login_page/login_page_state.dart';
import 'package:food_eye_fyp/ui/landing_pages/register_page/register_page_state.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_input_decoration/input_decoration_landing.dart';
import '../../../components/error_alert_dialog.dart';
import '../../../utils/constants.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegisterPageState>(context);
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
                            valueListenable: state.isPasswordVisible,
                            builder: (context, isPassWordVisible, _) {
                              return Form(
                                key: state.formKey,
                                child: Column(
                                  children: [
                                    // Email
                                    CustomTextFormField(
                                      validator: (s) => state.validateEmail(s),
                                      onChanged: (s) => state.email = s,
                                      controller: state.emailController,
                                      labelText: "Email",
                                      hintText: "example@email.com",
                                      textcolour: Colors.white,
                                      prefixicon: Icons.email_outlined,
                                      suffixIcon: null,
                                    ),
                                    _gap(),
                                    // Password
                                    TextFormField(
                                      validator: (value) =>
                                          state.validatePassword(value),
                                      obscureText:
                                          !state.isPasswordVisible.value,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: LandingPagesInputDecoration
                                          .inputDecoration(
                                        hintText: "Enter your password",
                                        labelText: "Password",
                                        prefixIcon: Icons.lock_outline_rounded,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                              !state.isPasswordVisible.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                          color: const Color.fromARGB(
                                              255, 96, 180, 206),
                                          onPressed: () {
                                            state.togglePasswordVisibility();
                                          },
                                        ),
                                      ),
                                      onChanged: (value) =>
                                          state.password = value,
                                    ),
                                    _gap(),
                                    // Name
                                    CustomTextFormField(
                                      validator: (s) => state.validateName(s),
                                      onChanged: (s) => state.name = s,
                                      controller: state.nameController,
                                      labelText: "Name",
                                      hintText:
                                          "Enter your name (e.g., John Doe)",
                                      textcolour: Colors.white,
                                      prefixicon: Icons.person_outline_rounded,
                                      suffixIcon: null,
                                    ),
                                    _gap(),
                                    // Age
                                    CustomIntFormField(
                                      validator: (value) {
                                        final parsedAge =
                                            int.tryParse(value ?? '');
                                        return state.validateAge(parsedAge);
                                      },
                                      onChanged: (value) {
                                        int parsedAge = int.parse(value);
                                        state.age = parsedAge;
                                      },
                                      controller: state.ageController,
                                      labelText: "Age",
                                      hintText: "Enter your age (1-100)",
                                      textcolour: Colors.white,
                                      prefixicon: Icons.onetwothree_rounded,
                                      suffixIcon: null,
                                    ),
                                    _gap(),
                                    // Address
                                    CustomTextFormField(
                                      validator: (s) =>
                                          state.validateIfEmpty(s),
                                      onChanged: (s) => state.address = s,
                                      controller: state.addressController,
                                      labelText: "Adress",
                                      hintText: "Enter your address",
                                      textcolour: Colors.white,
                                      prefixicon: Icons.home_work_outlined,
                                      suffixIcon: null,
                                    ),
                                    _gap(),
                                    // Date of birth
                                    DateFormField(
                                      validator: (value) {
                                        final selectedDate =
                                            DateTime.tryParse(value ?? '');
                                        return state.validateDate(selectedDate);
                                      },
                                      onChanged: (String value) {
                                        state.dateOfBirth =
                                            DateTime.parse(value);
                                      },
                                      controller: state.dobController,
                                      onPressed: () async {
                                        await state.selectAndAssignDate();
                                      },
                                      labelText: "Date of Birth",
                                      hintText: "Enter your date of birth",
                                      prefixicon: Icons.cake_outlined,
                                      suffixIcon: Icons.calendar_today_rounded,
                                      initialValue: null,
                                    ),
                                    _gap(),
                                    // User Roles
                                    UserRoleFormField(
                                      validator: (s) =>
                                          state.validateIfEmpty(s),
                                      onChanged: (s) => state.userRole = s!,
                                    )
                                  ],
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 32,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (state.formKey.currentState!.validate()) {
                                await state.register() != true
                                    ? showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const CustomErrorAlertDialog(
                                            imageAsset:
                                                'assets/images/error-logo.png',
                                            title: "Whoops!",
                                            subtitle: "Something went wrong...",
                                            description:
                                                "Account already exists, try something different",
                                          );
                                        },
                                      )
                                    : showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const CustomSuccessAlertDialog(
                                            imageAsset:
                                                'assets/images/newuser-logo.png',
                                            title: "Congratulations",
                                            subtitle:
                                                "Registration successful!",
                                            description:
                                                "You can now log in with your new account.",
                                          );
                                        },
                                      ).then(
                                        (_) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider(
                                                create: (context) =>
                                                    LoginPageState(context),
                                                child: const LoginPage(),
                                              ),
                                            ),
                                          );
                                        },
                                      );
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
                                    color: primaryBtnText,
                                  ),
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

Widget _gap() => const SizedBox(height: 10);
