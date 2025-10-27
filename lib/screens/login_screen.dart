import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:salon_appointment_app/provider/user_provider.dart';
import 'package:salon_appointment_app/screens/bottom_nav.dart';
import 'package:salon_appointment_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// -----------VARIABLES
  bool _hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: GoogleFonts.notoSansYi(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Glad to meet you again!, please login to use the app.',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1A1A1A),
                  ),
                ),
                SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// ------ EMAIL
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff156778),
                          ),
                          focusColor: Color(0xff156778),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xff156778),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),

                      /// ------PASSWORD
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff156778),
                          ),
                          focusColor: Color(0xff156778),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff156778),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xff156778),
                            ),
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 25),

                      /// --------FORGOT PASSWORD
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Forgot your password? ',
                              style: GoogleFonts.dmSans(
                                color: Color(0xff156778),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            Text(
                              'Reset yout password',
                              style: GoogleFonts.dmSans(
                                color: Color(0xff156778),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // -----------Submit Button
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool isLogin = await context
                                .read<UserProvider>()
                                .loginUser(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                            if (isLogin) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login Successful')),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNav(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login failed')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff156778),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.dmSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 200,
                                child: Divider(
                                  thickness: 1.2,
                                  color: Color(0xff156778),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Or',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                color: Color(0xff156778),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: SizedBox(
                                width: 200,
                                child: Divider(
                                  thickness: 1.2,
                                  color: Color(0xff156778),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: GoogleFonts.dmSans(
                        color: Color(0xff1A1A1A),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      ),
                      child: Text(
                        'Join',
                        style: GoogleFonts.dmSans(
                          color: Color(0xff1A1A1A),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
