import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/product/widgets/appbar_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/description_text_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/title_text_widget.dart';
import 'package:flutter_haberler/ui/login/login_current_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

var _action = AuthAction.signIn;

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrentUser().setCurrentUser(FirebaseAuth.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                  title: _action == AuthAction.signIn
                      ? StringConstants.loginPageTitle
                      : StringConstants.loginPageSignUpTitle),
              DescriptionText(
                  description: _action == AuthAction.signIn
                      ? StringConstants.loginPageText
                      : StringConstants.loginPageSignUpText,
                  textAlign: TextAlign.left),
              const SizedBox(height: 8),
              Theme(
                data: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(10),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.purplePrimary),
                      foregroundColor: MaterialStateProperty.all<Color>(ColorConstants.white),
                    ),
                  ),
                ),
                child: FirebaseUIActions(
                  actions: [
                    AuthStateChangeAction<SignedIn>((context, state) {
                      if (state.user != null) {
                        print("giriş yapıldı");
                      }
                    })
                  ],
                  child: LoginView(
                    showPasswordVisibilityToggle: true,
                    showTitle: false,
                    action: _action,
                    providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
                    footerBuilder: (context, action) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: InkWell(
                          splashColor: ColorConstants.transparent,
                          highlightColor: ColorConstants.transparent,
                          hoverColor: ColorConstants.transparent,
                          onTap: () => setState(() {
                            _action == AuthAction.signUp ? _action = AuthAction.signIn : _action = AuthAction.signUp;
                          }),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: _action == AuthAction.signUp
                                  ? StringConstants.loginPageHaveAccount
                                  : StringConstants.loginPageDontHaveAccount,
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                    text: _action == AuthAction.signUp
                                        ? StringConstants.loginPageSignIn
                                        : StringConstants.loginPageSignUp,
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
