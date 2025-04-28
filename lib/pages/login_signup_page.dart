import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/main.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/utils/regular_expressions.dart';
import 'package:markaz_umaza_invoice_generator/widgets/flexible_column_row.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginSignupPage extends ConsumerStatefulWidget {
  const LoginSignupPage({super.key});

  @override
  ConsumerState<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends ConsumerState<LoginSignupPage>
    with SingleTickerProviderStateMixin {
// Form State & Keys
  late final _formKey = GlobalKey<FormState>();

// State Flags
  late bool _isLoading = false;
  late bool onLoginPage = true;
  late bool isObscure = true;
  double lerp = 0.0;

// Duration
  late final duration = const Duration(milliseconds: 350);

// Controllers
  late final controllers = [
    TextEditingController(),
    TextEditingController(),
  ];

// Focus Nodes
  late final focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

// Theme & Animation
  late AppTheme themeMode;
  late ThemeNotifier themeNotifier;
  late AnimationController animController;
  late Animation<double> animation;

// Getters
  String get email => controllers[0].text;
  String get password => controllers[1].text;

// Color Calculations
  Color? get colorfulModePrimary =>
      Color.lerp(MyThemes.primaryRed, MyThemes.primaryBlue, lerp);

  Color? get textColor {
    if (themeMode == AppTheme.colorful) {
      return MyThemes.primaryLight;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    animController = AnimationController(vsync: this, duration: duration);

    animation = Tween<double>(begin: 0, end: 1).animate(animController)
      ..addListener(() {
        lerp = animation.value;
        print('onLoginPage: $onLoginPage, lerp: ${animation.value}');

        setState(() {});
      });
  }

  @override
  void dispose() {
    for (TextEditingController e in controllers) {
      e.dispose();
    }
    animController.dispose();
    super.dispose();
  }

// 1. UI State Management
  void loadCircle() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void showPassword() {
    setState(() => isObscure = !isObscure);
  }

  Widget buildAnimatedSwitcher({
    required Duration duration,
    required Widget? animatedChild,
  }) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.2),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: animatedChild,
    );
  }

// 2. Text Field Management
  void clearText() {
    for (TextEditingController e in controllers) {
      e.clear();
    }
  }

// 3. Authentication Methods
  Future<void> _login(String email, String password) async {
    try {
      loadCircle();
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (mounted) {
        clearText();
      }
    } on AuthException catch (error) {
      if (mounted) {
        context.showSnackBar(error.message, isError: true);
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    } finally {
      if (mounted) {
        loadCircle();
      }
    }
  }

  Future<void> _signUp(String email, String password) async {
    try {
      loadCircle();
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (mounted) {
        context.showSnackBar("Success! Please login.");
        clearText();
      }
    } on AuthException catch (error) {
      if (mounted) {
        context.showSnackBar(error.message, isError: true);
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    } finally {
      if (mounted) {
        loadCircle();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    themeMode = ref.watch(themeProvider);
    themeNotifier = ref.read(themeProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          themeMode == AppTheme.colorful ? colorfulModePrimary : null,
      body: SizedBox(
        child: Stack(
          children: [
            Positioned(
                top: orientation == Orientation.portrait ? 60 : 30,
                left: 40,
                child: FlexibleColumnRow(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, ",
                      style: TextStyle(fontSize: 34, color: textColor),
                    ),
                    Row(
                      children: [
                        Text(
                          "Sign ",
                          style: TextStyle(fontSize: 34, color: textColor),
                        ),
                        buildAnimatedSwitcher(
                          duration: duration,
                          animatedChild: SizedBox(
                            width: 60,
                            key: ValueKey(onLoginPage),
                            child: Text(
                              onLoginPage ? "In!" : "Up!",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 34, color: textColor),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            Positioned(
              bottom: 0,
              left: size.width / 2 -
                  ((orientation == Orientation.portrait
                          ? size.width
                          : size.height) /
                      2),
              height: size.height * 0.75,
              width: orientation == Orientation.portrait
                  ? size.width
                  : size.height,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? MyThemes.secondaryDark
                        : MyThemes.primaryLight,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(34),
                        topLeft: Radius.circular(34))),
                //height: size.height * 0.75,
                //width: size.width,
                child: Form(
                  key: _formKey,
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? MyThemes.primaryLight
                                    : MyThemes.primaryDark,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            spacing: 22,
                            children: [
                              Margins.vertical40,
                              //Email
                              SizedBox(
                                height: 65,
                                child: TextFormField(
                                  focusNode: focusNodes[0],
                                  controller: controllers[0],
                                  keyboardType: TextInputType.emailAddress,
                                  onTapOutside: (_) => focusNodes[0].unfocus(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an Email';
                                    } else if (!RegularExpressions.emailRegex
                                        .hasMatch(value)) {
                                      return 'Please enter a valid Email';
                                    }
                                    return null;
                                  },
                                  decoration: MyThemes.loginSignupTextField(
                                      labelText: " Email*",
                                      labelColor:
                                          Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? MyThemes.tertiaryLight
                                                  .withAlpha(100)
                                              : null,
                                      floatingLabelColor:
                                          themeMode == AppTheme.colorful
                                              ? colorfulModePrimary
                                              : null),
                                ),
                              ),
                              //Password
                              SizedBox(
                                height: 65,
                                //width: 285,
                                child: TextFormField(
                                  focusNode: focusNodes[1],
                                  controller: controllers[1],
                                  obscureText: isObscure,
                                  onTapOutside: (_) => focusNodes[1].unfocus(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    } else if (value.length < 8) {
                                      return 'Password must be 8 or more characters';
                                    } else if (!value
                                        .contains(RegExp(r"[A-Z]"))) {
                                      return 'Must include at least one uppercase letter';
                                    } else if (!value
                                        .contains(RegExp(r"[a-z]"))) {
                                      return 'Must include at least one lowercase letter';
                                    } else if (!value.contains(RegExp(r"\d"))) {
                                      return 'Must include at least one number';
                                    } else if (!value
                                        .contains(RegExp(r"[^A-Za-z\d]"))) {
                                      return 'Must include at least one symbol';
                                    }

                                    return null;
                                  },
                                  decoration: MyThemes.loginSignupTextField(
                                      labelText: " Password*",
                                      floatingLabelColor:
                                          themeMode == AppTheme.colorful
                                              ? colorfulModePrimary
                                              : null,
                                      suffixIcon: GestureDetector(
                                        onTap: showPassword,
                                        child: Icon(
                                          isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      )),
                                ),
                              ),
                              Margins.vertical26,
                              ElevatedButton(
                                style: ButtonStyle(
                                    minimumSize: const WidgetStatePropertyAll(
                                        Size(double.infinity, 50)),
                                    backgroundColor: WidgetStatePropertyAll(
                                      themeMode == AppTheme.colorful
                                          ? colorfulModePrimary
                                          : null,
                                    ),
                                    foregroundColor: WidgetStatePropertyAll(
                                      themeMode == AppTheme.colorful
                                          ? Colors.white
                                          : null,
                                    )),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    onLoginPage
                                        ? await _login(email, password)
                                        : await _signUp(email, password);
                                  }
                                },
                                child: buildAnimatedSwitcher(
                                    duration: duration,
                                    animatedChild: Text(
                                      key: ValueKey(onLoginPage),
                                      onLoginPage ? "SIGN IN" : "SIGN UP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: textColor),
                                    )),
                              ),
                              Margins.vertical14,
                              buildAnimatedSwitcher(
                                duration: duration,
                                animatedChild: Row(
                                  key: ValueKey(onLoginPage),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      onLoginPage
                                          ? "Not a member yet? "
                                          : "Already a member? ",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        onLoginPage
                                            ? animController.forward()
                                            : animController.reverse();

                                        _formKey.currentState!.reset();

                                        for (TextEditingController e
                                            in controllers) {
                                          e.clear();
                                        }

                                        isObscure = true;

                                        onLoginPage = !onLoginPage;
                                      },
                                      child: Text(
                                        onLoginPage ? "SIGN UP" : "SIGN IN",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: themeMode == AppTheme.colorful
                                              ? colorfulModePrimary
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (orientation == Orientation.landscape)
                                Margins.vertical134,
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          Text(
            switch (themeMode) {
              AppTheme.light => "Light Mode",
              AppTheme.dark => "Dark Mode",
              _ => "Colorful Mode"
            },
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeMode == AppTheme.colorful &&
                        orientation == Orientation.landscape
                    ? Colors.white
                    : null),
          ),
          FloatingActionButton(
            backgroundColor:
                themeMode == AppTheme.colorful ? colorfulModePrimary : null,
            onPressed: () {
              switch (themeMode) {
                case AppTheme.light:
                  themeNotifier.setTheme(AppTheme.dark);
                case AppTheme.dark:
                  themeNotifier.setTheme(AppTheme.colorful);
                default:
                  themeNotifier.setTheme(AppTheme.light);
              }
            },
            child: Icon(
              switch (themeMode) {
                AppTheme.light => Icons.light_mode_outlined,
                AppTheme.dark => Icons.mode_night_outlined,
                _ => Icons.color_lens_outlined
              },
            ),
          ),
        ],
      ),
    );
  }
}
