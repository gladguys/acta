import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Navigation {
  static void navigateFromInside(
      {@required BuildContext context,
      @required Widget screen,
      bool replace = false}) {
    _navigate(
        context: context,
        screen: screen,
        replace: replace,
        transitionType: PageTransitionType.fade);
  }

  static void navigateFromMenu(
      {@required BuildContext context,
      @required Widget screen,
      bool replace = false}) {
    _navigate(
        context: context,
        screen: screen,
        replace: replace,
        transitionType: PageTransitionType.downToUp);
  }

  static void _navigate(
      {@required BuildContext context,
      @required Widget screen,
      @required PageTransitionType transitionType,
      bool replace = false}) {

    assert(context != null);
    assert(screen != null);
    assert(replace != null);

    if (replace) {
      Navigator.pushReplacement(
        context,
        PageTransition(type: transitionType, child: screen),
      );
    } else {
      Navigator.push(
        context,
        PageTransition(type: transitionType, child: screen),
      );
    }
  }
}
