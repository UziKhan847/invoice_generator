import 'dart:async';

import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/main.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_profile_data.dart';
import 'package:markaz_umaza_invoice_generator/pages/login_signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStatePageView extends StatefulWidget {
  const AuthStatePageView({super.key});

  @override
  State<AuthStatePageView> createState() => _AuthRouterPageViewState();
}

class _AuthRouterPageViewState extends State<AuthStatePageView> {
  late final PageController pageController;
  late StreamSubscription<AuthState> authSub;
  late int initialPage;

  @override
  void initState() {
    super.initState();

    initialPage = supabase.auth.currentSession == null ? 1 : 0;
    pageController = PageController(initialPage: initialPage);

    authSub = supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 1000), curve: Curves.ease);
      } else if (event == AuthChangeEvent.signedOut) {
        pageController.jumpToPage(1);
      }
    });
  }

  @override
  void dispose() {
    authSub.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: const [
        LoadingProfileData(),
        LoginSignupPage(),
      ],
    );
  }
}
