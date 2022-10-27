import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isCreatingAccount == true ? 'Sign in' : 'Log in'),
              TextField(
                controller: widget.emailController,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              TextField(
                controller: widget.passwordController,
                decoration: const InputDecoration(hintText: "Password"),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(errorMessage),
              ElevatedButton(
                onPressed: () async {
                  if (isCreatingAccount == true) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                    //rejestracja
                  } else {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                    //logowanie
                  }
                },
                child: Text(isCreatingAccount == true ? 'Sign in' : 'Log in'),
              ),
              const SizedBox(
                height: 20,
              ),
              if (isCreatingAccount == false) ...[
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        isCreatingAccount = true;
                      },
                    );
                  },
                  child: const Text('Create account'),
                ),
              ],
              if (isCreatingAccount == true) ...[
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        isCreatingAccount = false;
                      },
                    );
                  },
                  child: const Text('Already have an account?'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
