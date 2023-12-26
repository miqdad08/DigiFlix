import 'package:digi_flix/presentation/extensions/build_context_extension.dart';
import 'package:digi_flix/presentation/misc/methods.dart';
import 'package:digi_flix/presentation/providers/user_data/user_data_provider.dart';
import 'package:digi_flix/presentation/widgets/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/router/router_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('main');
          }
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              children: [
                verticalSpace(100),
                Center(
                  child: Image.asset(
                    width: 200,
                    'assets/images/flix_logo.png',
                  ),
                ),
                verticalSpace(100),
                FlixTextField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                verticalSpace(24),
                FlixTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                verticalSpace(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                ref.read(userDataProvider.notifier).login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                },
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        ref.read(routerProvider).goNamed('register');
                      },
                      child: const Text(
                        'Register here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
