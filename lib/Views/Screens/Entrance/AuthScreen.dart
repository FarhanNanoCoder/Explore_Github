import 'package:email_validator/email_validator.dart';
import 'package:explore_github/Utilities/AppColors.dart';
import 'package:explore_github/Views/Components/Core/AppTextFormField.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget{
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
  void dispose(){
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void submitForm()async{
    if(_formKey.currentState?.validate()??false){
      _formKey.currentState?.save();
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
          scrollDirection:Axis.vertical,
          padding:  const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextFormField(
                  validator: (value){return EmailValidator.validate(value ?? "")? null: 'Invalid email';},
                  textEditingController: _emailController, hint: "Email", prefixIcon: Icon(Icons.email_outlined,color: AppColors().primaryColor,),).getField(context),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}