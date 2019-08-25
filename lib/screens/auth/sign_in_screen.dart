import 'package:acta/blocs/configs_bloc.dart';
import 'package:acta/blocs/sign_in_screen_bloc.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/i18n/at_messages.dart';
import 'package:acta/screens/auth/auth_validations.dart';
import 'package:acta/screens/home_screen.dart';
import 'package:acta/screens/intro_screen.dart';
import 'package:acta/utils/firebase_errors_helper.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/widgets/at_alert.dart';
import 'package:acta/widgets/at_simple_text_logo.dart';
import 'package:acta/widgets/at_text_form_field.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({@required this.toggler});

  final Function toggler;

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Map<String, String> _signInInfo = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();
  bool isAuthenticating;

  final _signInScreenBloc = BlocProvider.getBloc<SignInScreenBloc>();

  @override
  void initState() {
    isAuthenticating = false;
    super.initState();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Center(
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return isAuthenticating
        ? ATWaiting()
        : Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ATSimpleTextLogo(
                      text: ATLabels.ACTA,
                      duration: Duration(seconds: 3),
                      isRepeatingAnimation: false,
                      fontSize: 80.0,
                    ),
                    _buildFields(),
                    SizedBox(height: 24.0),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildFields() {
    return Column(
      children: <Widget>[
        ATTextFormField(
          hintText: 'E-mail',
          prefixIcon: Icons.mail,
          isRequired: true,
          textInputType: TextInputType.emailAddress,
          onSaved: (String email) => _signInInfo['email'] = email,
          validator: AuthValidations.emailValidator,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(passwordFocusNode),
        ),
        SizedBox(height: 16.0),
        ATTextFormField(
          hintText: 'Password',
          prefixIcon: Icons.lock,
          isRequired: true,
          onSaved: (String password) => _signInInfo['password'] = password,
          validator: AuthValidations.passwordValidator,
          obscureText: true,
          focusNode: passwordFocusNode,
          textInputAction: TextInputAction.done,
          onEditingComplete: () => _signInUser(context),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        Container(
          width: 200.0,
          height: 40.0,
          child: RaisedButton(
            child: Text(ATLabels.LOGIN),
            color: Colors.brown[800],
            textColor: Colors.brown[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            onPressed: () => _signInUser(context),
          ),
        ),
        FlatButton(
          textColor: Colors.brown[800],
          child: Text(ATMessages.CREATE_ACCOUNT),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          onPressed: widget.toggler,
        ),
      ],
    );
  }

  Future<void> _signInUser(BuildContext context) async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();

      setState(() => isAuthenticating = true);
      final userData = await _signInScreenBloc.signInUser(
          _signInInfo['email'], _signInInfo['password']);

      if (!userData['hasError']) {
        if (ConfigsBloc.isFirstLoginDone) {
          Navigation.navigateFromInside(
              context: context, screen: HomeScreen(), replace: true);
        } else {
          Navigation.navigateFromInside(
              context: context, screen: IntroScreen(), replace: true);
        }
      } else {
        ATAlert.failure(
            FirebaseSignInErrorsHelper.getMessage(userData['code']));
        setState(() => isAuthenticating = false);
      }
    }
  }
}
