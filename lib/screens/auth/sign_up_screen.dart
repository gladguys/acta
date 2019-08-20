import 'package:acta/blocs/sign_up_screen.dart';
import 'package:acta/utils/firebase_errors_helper.dart';
import 'package:acta/widgets/at_alert.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:acta/screens/auth/auth_validations.dart';
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
  bool isCreatingUser;
  String errorMessage;

  final TextEditingController _emailController = TextEditingController();

  final SignUpScreenBloc _signUpScreenBloc = BlocProvider.getBloc<SignUpScreenBloc>();

  @override
  void initState() {
    isCreatingUser = false;
    errorMessage = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isCreatingUser
          ? ATWaiting()
      : Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String email) => _signUpInfo['email'] = email,
                  validator: AuthValidations.emailValidator,
                  controller: _emailController,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email Confirmation',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String confirmationEmail) =>
                      AuthValidations.emailsMatchValidator(
                          _emailController.value.text, confirmationEmail),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onSaved: (String email) => _signUpInfo['password'] = email,
                  validator: AuthValidations.passwordValidator,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton.icon(
                      icon: Icon(Icons.transit_enterexit),
                      label: Text('Create'),
                      onPressed: () => _createUser(context),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    FlatButton(
                      child: Text('I have an account'),
                      onPressed: widget.toggler,
                    ),
                  ],
                ),
                _buildAuthErrorMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthErrorMessage() {
    return errorMessage != null ? Text(errorMessage) : Container();
  }

  Future<void> _createUser(BuildContext context) async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();

      setState(() => isCreatingUser = true);
      final userData = await _signUpScreenBloc.createUser(_signUpInfo['email'], _signUpInfo['password']);
      setState(() => isCreatingUser = false);

      if (!userData['hasError']) {
        ATAlert.success('Account created!');
        widget.toggler();
      } else {
        setState(() => errorMessage = FirebaseSignInErrorsHelper.getMessage(userData['code']));
      }
    }
  }
}