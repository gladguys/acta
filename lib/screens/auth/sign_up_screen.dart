import 'package:acta/blocs/sign_up_screen_bloc.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/i18n/at_messages.dart';
import 'package:acta/screens/auth/auth_validations.dart';
import 'package:acta/utils/firebase_errors_helper.dart';
import 'package:acta/widgets/at_alert.dart';
import 'package:acta/widgets/at_simple_text_logo.dart';
import 'package:acta/widgets/at_text_form_field.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({@required this.toggler});

  final Function toggler;

  @override
  State<StatefulWidget> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final Map<String, String> _signUpInfo = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode emailConfirmFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isCreatingUser;

  final SignUpScreenBloc _signUpScreenBloc =
      BlocProvider.getBloc<SignUpScreenBloc>();

  @override
  void initState() {
    isCreatingUser = false;
    super.initState();
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
    return isCreatingUser
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
                      text: 'Register an account',
                      fontSize: 60.0,
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
          onSaved: (String email) => _signUpInfo['email'] = email,
          validator: AuthValidations.emailValidator,
          textInputAction: TextInputAction.next,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(passwordFocusNode),
        ),
        SizedBox(
          height: 16.0,
        ),
        ATTextFormField(
          hintText: 'Password',
          prefixIcon: Icons.lock,
          isRequired: true,
          focusNode: passwordFocusNode,
          textInputAction: TextInputAction.done,
          onEditingComplete: () => _createUser(context),
          obscureText: true,
          onSaved: (String email) => _signUpInfo['password'] = email,
          validator: AuthValidations.passwordValidator,
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
            child: Text(ATLabels.CREATE),
            color: Colors.brown[800],
            textColor: Colors.brown[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            onPressed: () => _createUser(context),
          ),
        ),
        FlatButton(
          textColor: Colors.brown[800],
          child: Text(ATMessages.HAVE_ACCOUNT),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          onPressed: widget.toggler,
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Future<void> _createUser(BuildContext context) async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();

      setState(() => isCreatingUser = true);
      final userData = await _signUpScreenBloc.createUser(
          _signUpInfo['email'], _signUpInfo['password']);
      setState(() => isCreatingUser = false);

      if (!userData['hasError']) {
        ATAlert.success('Account created!');
        widget.toggler();
      } else {
        ATAlert.failure(
            FirebaseSignInErrorsHelper.getMessage(userData['code']));
        setState(() => isCreatingUser = false);
      }
    }
  }
}
