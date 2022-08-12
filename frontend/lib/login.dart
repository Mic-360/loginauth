import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loginauth/api.dart';
import 'dart:convert';
import 'help.dart';
import 'navigate.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email;
  late String password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  bool hiddenPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    Future<void> Loggedin() async {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Login Successful',
            ),
          ),
        );
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Login failed',
            ),
          ),
        );
      }
    }

    final inputborder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: Divider.createBorderSide(
        context,
        width: 1.0,
        color: Colors.white,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Stack(
                children: <Widget>[
                  SvgPicture.asset(
                    'images/Code4Odisha.svg',
                    height: 200.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Form(
                key: loginKey,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Enter Your Email",
                          labelStyle: TextStyle(color: Colors.white),
                          border: inputborder,
                          focusedBorder: inputborder,
                          enabledBorder: inputborder,
                          filled: false,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please Enter an Email',
                                ),
                                duration: Duration(milliseconds: 1000),
                              ),
                            );
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value!)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please Enter a Valid Email',
                                ),
                                duration: Duration(milliseconds: 1000),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Enter Your Password",
                          labelStyle: TextStyle(color: Colors.white),
                          border: inputborder,
                          focusedBorder: inputborder,
                          enabledBorder: inputborder,
                          filled: false,
                          contentPadding: const EdgeInsets.all(8),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                hiddenPassword = !hiddenPassword;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        keyboardType: TextInputType.text,
                        obscureText: hiddenPassword,
                        validator: (value) {
                          if (value!.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Password Too short',
                                ),
                                duration: Duration(milliseconds: 1000),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () async {
                          await HttpService.login(email, password, context);
                        },
                        child: Container(
                          width: 100.0,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            color: Colors.orangeAccent,
                          ),
                          child: Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Help(),
                    ),
                  );
                  // Help();
                },
                child: const Text(
                  "Help !",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
