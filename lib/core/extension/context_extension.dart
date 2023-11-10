import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension MediaQueryExtension on BuildContext {
  double get height =>
      MediaQuery
          .of(this)
          .size
          .height;

  double get width =>
      MediaQuery
          .of(this)
          .size
          .width;

  Size get size =>
      MediaQuery
          .of(this)
          .size;
}

extension ThemeExtension on BuildContext {
  ColorScheme get appColors =>
      Theme
          .of(this)
          .colorScheme;

  TextTheme get appTextStyle =>
      Theme
          .of(this)
          .textTheme;
}

extension FocusExtension on BuildContext {
  void removeFocus() {
    if (mounted) FocusScope.of(this).unfocus();
  }

  void requestFocus(FocusNode focus) {
    if (mounted) FocusScope.of(this).requestFocus(focus);
  }
}

extension ToastExtension on BuildContext {
  void showSnackBar(String text, {
    String? ctaText,
    VoidCallback? onTap,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: appTextStyle.bodyMedium?.copyWith(
              color: AppColors.white,
          ),
        ),

        action: ctaText != null
            ? SnackBarAction(
          label: ctaText ?? '',
          onPressed: onTap ?? () {},
          textColor: AppColors.primary,
        )
            : null,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

extension BlockExtension on BuildContext {
  T readBloc<T extends StateStreamableSource<Object?>>() {
    return BlocProvider.of<T>(this);
  }
}

extension NavigatorExtension on BuildContext {
  Future<T?> push<T extends Object?>(Widget page) =>
      Navigator.of(this).push(
        MaterialPageRoute(builder: (_) => page),
      );

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(Widget page,
      {
        TO? result,
      }) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop<T>(result);

  void maybePop<T extends Object?>([T? result]) =>
      Navigator.of(this).maybePop<T>(result);

  void popUntil(RoutePredicate predicate) =>
      Navigator.of(this).popUntil(predicate);

  Future<T?> pushAndRemoveUntil<T extends Object?>(Widget page,
      RoutePredicate predicate,) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      predicate,
    );
  }

  void replace<T extends Object?>({
    required Route<dynamic> oldRoute,
    required Route<T> newRoute,
  }) {
    Navigator.of(this).replace(
      oldRoute: oldRoute,
      newRoute: newRoute,
    );
  }

  bool canPop() => Navigator.of(this).canPop();

  Future<T?> pushNamed<T extends Object?>(String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
      String routeName, {
        TO? result,
        Object? arguments,
      }) {
    return Navigator.of(this).popAndPushNamed(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(String newRouteName,
      RoutePredicate predicate, {
        Object? arguments,
      }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      String routeName, {
        TO? result,
        Object? arguments,
      }) {
    return Navigator.of(this).pushReplacementNamed(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  Object? get getArguments =>
      ModalRoute
          .of(this)
          ?.settings
          .arguments;

  NavigatorState get getNavigator => Navigator.of(this);
}
