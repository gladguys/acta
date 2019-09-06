# Flow of Flutter app:

## The beginning of everything: lib/main.dart
--------------------------------

the file main.dart is where our `main()` is. So, that's the entrypoint of our app.
It will call a private method called  `_loadApp()`

### _loadApp()

Here, we'll get all the basic info we need to start the app:
configuration of CatcherOptions, which is a handler of error in our app.
at the end of the method, we call Catcher() passing as parameter our big first Widget, so from this widget below, the catcher will handle errors. This mother widget is called MyApp() and it's at the same file


### MyApp()
It's the main Widget, that starts our app UI. It's wrapped by a BlocProvider. The child of this blocProvider, is the MainApp(), which stays in another file: *main_app.dart*

------------------
## main_app.dart
------------------

Here's where the real game really starts. It's a statelessWidget. It works with a FutureBuilder, and we did that for verify if the user has valid token. 
So, if it's the user's first time accessing the app, the private method _userHasValidToken() will return false. But what this `_userHasValidToken()` does?

### _userHasValidToken()

It will access SharedPreferences, which is used to store key-value in android and IOS devices. So, our implementation will go looking for a value for key 'token-expire' which is a date of expiration of user's token. if it's outdated or it's null... return false! if not, true.


### Our MaterialApp()
So finally we got at the `MaterialApp()`, this guy will do some configurations, for example:
- localizationDelegates, which will handle internacionalization of our app.
- supportedLocales, saying types of languages we support for i18n
obs: flutter will get the locale of your mobile device. So the language which is configured in your app, is the language that Acta will go with.
- we fix our theme
- and then set our **home**: Here we check the return of the previous step. if it returns false (no token) it redirect to `AuthScreen()`, if it do has token: `HomeScreen()`

--------------
## AuthScreen
--------------
Thats the screen where we do signin and signup!

Here we will use a logic of switching between signin and signup screen. So, he got an enum: 

```dart  
enum AuthMode { SIGN_IN, SIGN_UP } 
```

### initState()

and in the `initState()` method we already set the AuthMode object to SIGN_IN as default.


Also, in this method, we set configuration for the **BlocConfig** calling the method `initConfigs()`. 

### build()

Here is where we see if we call a widget for *signin* or for *signup*

```dart
@override
  Widget build(BuildContext context) {
    return authMode == AuthMode.SIGN_IN
        ? SignInScreen(toggler: toggleScreens)
        : SignUpScreen(toggler: toggleScreens);
  }
```

you can see that there's indeed the both widgets. This **toggleScreens** is actually a function, so we are passing a callback. for what? To set the page signin or signup according to an event in one of the screens: SigninScreen or SignUpScreen (both screens have the ability to change to the other page switching).

didn't put the method impl here because it's pretty elementar, trust me. It's just an if and else to change to the other page, according to the current page.

____________________________
## SignInPage and SignUpPage
_____________________________

The logic in both is very similar. So I'll focus in explain the main logic.

The wrapper is a `Scaffold` whit a `Card` and this card has as child an private method responsable for build the builder method.

Those are mainly normal form classes in flutter: 
- fields setted as `ATTextFormField()` which is an implementation. But it's in fact an TextFormField customized with own styles.
- Validations
- onsaved:  here we are setting the inputs in a map

this is the method that is executed when we click in button to submit:

```dart
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
  ```
good to notice that we call validations. 
To submit the data in form, we call 

```
_signUpScreenBloc.createUser(
          _signUpInfo['email'], _signUpInfo['password']);
```

The _signUpInfo is a return of BlocProvider of ` BlocProvider.getBloc<SignUpScreenBloc>();`

Within it we got the method `createUser()`:

```dart
Future<Map<String, dynamic>> createUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return {'hasError': false};
    } catch (e) {
      return {'hasError': true, 'code': e.code};
    }
  }
```

which will communicate with **Firebase** create a user.

**obs**: The signInPage also has its Bloc, that has a method responsable for connect to Firebase and to the signin:

```dart
 Future<Map<String, dynamic>> signInUser(String email, String password) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = getUserFromAuthResult(authResult);
      storeUserInfo(user);

      return {
        'hasError': false,
        'user': user
      };
    } catch (e) {
      return {
        'hasError': true,
        'code': e.code
      };
    }
  }
```

Once the login and password were validated by the firebase, it will return an object containing the id and email of the user logged. So we build a user instance by getting those values returned by firebase (see method ``getUserFromAuthResult()` ) , and after we update or save for the first time the user data on memory (see method `storeUserInfo`).


### After sign in

After the signin is done, ti redirects to the HomeScreen() widget:

## HomeScreen()

### blocs and provider

in home we have 2 types of blocProvider and 1 news provider:

```dart
 final _newsBloc = BlocProvider.getBloc<NewsBloc>();
 final _configsBloc = BlocProvider.getBloc<ConfigsBloc>();
 final _provider = NewsProvider();
 ```

the first one can:
- update country
- refreshNews

the second one:
- you can set the view of news

the newsProvider:
- can getTopHeadlines();

### the build method

Returns A **ATBaseScreen** widget, and as body we pass a private method:  the `_buildHomeScreen`()`

### _buildHomeScreen()

This method will be feeded by the newsBloc commented earlier. It will create a StreamBuilder:

```dart
Widget _buildHomeScreen() {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: StreamBuilder<bool>(
        stream: _newsBloc.newsObservable,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
            _buildScreenFromStream(context, snapshot),
      ),
    );
  }

```

To explain, the stream parameter receives the observable given by the blocNews, and the builder is receiving a private method which will return a **FutureBuilder**, that receives as future the getTopHeadlines() from newsProvider and builder as `NewCardsList()` each element of the list.

obs: to this widget `NewCardsList()` we pass:

```dart
 return NewsCardsList(
              news: futureSnapshot.data,
              viewType: _configsBloc.currentViewType,
              newsRefresher: _getTopHeadlines,
            );
```

to set the type of view (given by the bloc) and a refence to the method responsable for get refresh of news.







