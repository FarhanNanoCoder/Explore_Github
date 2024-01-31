import 'package:email_validator/email_validator.dart';
import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/app_user.dart';
import 'package:explore_github/Providers/app_auth_provider.dart';
import 'package:explore_github/Repositories/auth_repository.dart';
import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Utilities/utility.dart';
import 'package:explore_github/Views/Components/Core/app_button.dart';
import 'package:explore_github/Views/Components/Core/app_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/AuthScreen';
  bool isLoginState = false;
  AuthScreen({this.isLoginState = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void handleFormSubmit() async {
    if(AppAuthProvider().loader) return;
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      APIResponse<AppUser?> res;
      if (widget.isLoginState) {
        res = await AuthRepository.loginUser(
            email: _emailController.text, password: _passwordController.text);
      } else {
        res = await AuthRepository.registerUser(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text);
      }

      if (res.data != null) {
     
      } else {
       
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isLoginState ? "Sign in" : "Register"),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Form(
              key: _formKey,
              child: Consumer<AppAuthProvider>(
                builder: (context, appAuhtProvider, child) {
                  return Column(
                    children: [
                      if (!widget.isLoginState)
                        AppInputFormField(
                          validator: (value) {
                            return (value?.toString().trim().length ?? 0) > 0
                                ? null
                                : 'Name is required';
                          },
                          controller: _nameController,
                          label: "Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors().primaryColor,
                          ),
                        ),
                      if (!widget.isLoginState)
                        const SizedBox(
                          height: 24,
                        ),
                      AppInputFormField(
                        validator: (value) {
                          return EmailValidator.validate(value ?? "")
                              ? null
                              : 'Invalid email';
                        },
                        controller: _emailController,
                        label: "Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors().primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      AppInputFormField(
                          obscureText: hidePassword,
                          goNextOnComplete: true,
                          textInputType: TextInputType.visiblePassword,
                          prefixIcon: Icon(
                            Icons.password,
                            color: AppColors().primaryColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(
                              !hidePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors().primaryColor,
                            ),
                          ),
                          validator: (value) {
                            return (value?.toString().trim().length ?? 0) > 0
                                ? null
                                : 'Password is required';
                          },
                          controller: _passwordController,
                          label: "Password"),
                      if (!widget.isLoginState)
                        const SizedBox(
                          height: 24,
                        ),
                      if (!widget.isLoginState)
                        AppInputFormField(
                          obscureText: hideConfirmPassword,
                          goNextOnComplete: true,
                          textInputType: TextInputType.visiblePassword,
                          prefixIcon: Icon(
                            Icons.password,
                            color: AppColors().primaryColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hideConfirmPassword = !hideConfirmPassword;
                              });
                            },
                            icon: Icon(
                              !hideConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors().primaryColor,
                            ),
                          ),
                          validator: (value) {
                            return (value?.toString().trim().length ?? 0) > 0
                                ? null
                                : 'Confirm password is required';
                          },
                          controller: _confirmPasswordController,
                          label: "Confirm password",
                        ),
                      const SizedBox(
                        height: 48,
                      ),
                      AppButton(context: context).getTextButton(
                          title: widget.isLoginState ? "Login" : "Register",
                          onPressed: handleFormSubmit),
                      const SizedBox(
                        height: 24,
                      ),
                      if (appAuhtProvider.loader)
                        SizedBox(
                          width: 100,
                          child: LinearProgressIndicator(
                            minHeight: 8,
                            backgroundColor: AppColors().secondaryColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors().primaryColor),
                          ),
                        )
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}
