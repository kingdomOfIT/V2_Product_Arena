import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';

class WebLoginForm extends StatefulWidget {
  const WebLoginForm({super.key});

  @override
  State<WebLoginForm> createState() => _WebLoginFormState();
}

class _WebLoginFormState extends State<WebLoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool emailErrored = false;
  bool passwordErrored = false;
  bool viewPassword = false;

  var emailColor = const Color(0xFF605D66);
  var passwordColor = const Color(0xFF605D66);

  RegExp emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: SizedBox(
        width: 340,
        child: Column(
          children: [
            TextFormField(
              key: const Key('emailField'),
              controller: emailController,
              onChanged: (value) {
                if (value.isNotEmpty && !emailErrored) {
                  setState(() {
                    emailColor = const Color(0xFF000000);
                  });
                } else if (!emailErrored) {
                  setState(() {
                    emailColor = const Color(0xFF605D66);
                  });
                }
              },
              validator: (value) {
                if (value == '' || value == null) {
                  setState(() {
                    emailErrored = true;
                    emailColor = const Color(0xFFB3261E);
                  });
                  return 'Please fill the required field.';
                } else if (!emailRegExp.hasMatch(value)) {
                  setState(() {
                    emailErrored = true;
                    emailColor = const Color(0xFFB3261E);
                  });
                  return 'Invalid email format.';
                }
                setState(() {
                  emailErrored = false;
                  emailColor = const Color(0xFF000000);
                });
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    //color: emailColor,
                  ),
                ),
                fillColor: Colors.black,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF22E974),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: emailColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: emailColor,
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFB3261E),
                  ),
                ),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              key: const Key('passwordField'),
              controller: passwordController,
              onChanged: (value) {
                if (value.isNotEmpty && !passwordErrored) {
                  setState(() {
                    passwordColor = const Color(0xFF000000);
                  });
                } else if (!passwordErrored) {
                  setState(() {
                    passwordColor = const Color(0xFF605D66);
                  });
                }
              },
              obscureText: viewPassword ? false : true,
              validator: (value) {
                if (value == '' || value == null) {
                  setState(() {
                    passwordErrored = true;
                    passwordColor = const Color(0xFFB3261E);
                  });
                  return 'Please fill the required field.';
                } else if (!passwordRegExp.hasMatch(value)) {
                  setState(() {
                    passwordErrored = true;
                    passwordColor = const Color(0xFFB3261E);
                  });
                  return 'Invalid password format';
                }
                setState(() {
                  passwordErrored = false;
                  passwordColor = const Color(0xFF000000);
                });

                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      viewPassword = !viewPassword;
                    });
                  },
                  child: Icon(
                    viewPassword ? Icons.visibility : Icons.visibility_off,
                    color: viewPassword
                        ? Colors.black
                        : const Color.fromARGB(255, 96, 93, 102),
                    size: 30,
                  ),
                ),
                label: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    color: passwordColor,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF22E974),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: emailColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: passwordColor,
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFB3261E),
                  ),
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_loginFormKey.currentState!.validate()) {
                  Navigator.of(context)
                      .pushReplacementNamed(WebHomeScreen.routeName);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
