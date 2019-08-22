import 'package:acta/blocs/configs_bloc.dart';
import 'package:acta/blocs/user_bloc.dart';
import 'package:acta/blocs/sign_in_screen_bloc.dart';
import 'package:acta/screens/auth/auth_validations.dart';
import 'package:acta/screens/home_screen.dart';
import 'package:acta/screens/intro_screen.dart';
import 'package:acta/utils/firebase_errors_helper.dart';
import 'package:acta/utils/navigation.dart';
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
  String errorMessage;

  final _signInScreenBloc = BlocProvider.getBloc<SignInScreenBloc>();

  @override
  void initState() {
    isAuthenticating = false;
    errorMessage = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isAuthenticating
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
                          labelText: 'E-mail',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String email) => _signInInfo['email'] = email,
                        validator: AuthValidations.emailValidator,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(passwordFocusNode),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String password) =>
                            _signInInfo['password'] = password,
                        validator: AuthValidations.passwordValidator,
                        obscureText: true,
                        focusNode: passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () => _signInUser(context),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton.icon(
                        icon: Icon(Icons.transit_enterexit),
                        label: Text('Login'),
                        onPressed: () => _signInUser(context),
                      ),
                      _buildAuthErrorMessage(),
                      FlatButton(
                        child: Text('Create an account'),
                        onPressed: widget.toggler,
                      ),
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
              context: context, screen: IntroScreen());
        }
      } else {
        setState(() {
          errorMessage =
              FirebaseSignInErrorsHelper.getMessage(userData['code']);
          isAuthenticating = false;
        });
      }
    }
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }
}
