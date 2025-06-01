import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/core/components/button.dart';
import 'package:talent_insider_app/core/constants/app_label.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';
import 'package:talent_insider_app/models/apis/login_api_controller/login_api_controller.dart';
import 'package:talent_insider_app/models/user_model/user_model.dart';
import 'package:talent_insider_app/view/login/widgets/continue_with_divider.dart';
import 'package:talent_insider_app/view/nav_bar/nav_bar_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/loginScreen';

  final void Function(UserModel user)? onLoginSuccess;
  final void Function(String errorMessage)? onLoginError;

  const LoginScreen({super.key, this.onLoginSuccess, this.onLoginError});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  final LoginApiController loginController = LoginApiController();
  late SharedPreferences _prefs;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    _prefs = await SharedPreferences.getInstance();
    newUser = _prefs.getBool('login') ?? true;

    if (!newUser) {
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const NavBarScreen(initialIndex: 0),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: loginController.emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: TalentTextStyle.smRegular.copyWith(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: AppLabel.hintEmail,
        hintStyle: TalentTextStyle.smRegular.copyWith(
          color: AppColors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AppColors.blackDark,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: loginController.passwordController,
      textInputAction: TextInputAction.done,
      style: TalentTextStyle.smRegular.copyWith(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: AppLabel.hintPassword,
        hintStyle: TalentTextStyle.smRegular.copyWith(
          color: AppColors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AppColors.blackDark,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.blackDark,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(ResourcePath.logo, height: 100, width: 100),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 50.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLabel.loginTitle,
                          style: TalentTextStyle.xsMedium.copyWith(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLabel.loginDescription,
                          style: TalentTextStyle.xsLightHindGuntur.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLabel.email,
                          style: TalentTextStyle.xsMedium.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: emailField,
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLabel.password,
                          style: TalentTextStyle.xsMedium.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: passwordField,
                    ),
                    const SizedBox(height: 40),

                    TalentButton(
                      buttonLabel: AppLabel.login,
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        await Future.delayed(const Duration(seconds: 1));

                        // ignore: use_build_context_synchronously
                        if (mounted) await loginWithEmail(context);

                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    ),
                    const ContinueWithDividerNew(),
                    TalentButton(
                      buttonLabel: AppLabel.withOutLogin,
                      onPressed: () {},
                      style: TalentButtonStyle.disabled,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.4),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Future<void> loginWithEmail(BuildContext context) async {
    final String email = loginController.emailController.text.trim();
    final String password = loginController.passwordController.text;

    if (email.isEmpty || !isValidEmail(email)) {
      return showError('Masukkan email terlebih dahulu dengan benar');
    }

    if (password.isEmpty) {
      return showError('Masukkan Kata Sandi');
    } else if (password.length < 2) {
      return showError('Kata sandi minimal 2 karakter');
    }

    final UserModel? user = await loginController.loginUser(
      email,
      password,
      context,
    );

    if (user != null) {
      _prefs.setBool('login', false);

      if (widget.onLoginSuccess != null) {
        widget.onLoginSuccess!(user);
      }

      if (!mounted) return;
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const NavBarScreen(initialIndex: 0),
        ),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Login Berhasil'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      if (widget.onLoginError != null) {
        widget.onLoginError!("Login gagal: email atau password salah");
      }

      showError('Login gagal password salah');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(email);
}
