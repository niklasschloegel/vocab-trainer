import 'package:flutter/material.dart';

/// A custom a11y compatible Back Button.
///
/// This button should be set as the leading element
/// of an [AppBar] to improve semantics and specify an own label.
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        enabled: true,
        label: "Zurück", //best case: include i18n
        child: ExcludeSemantics(
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: Navigator.of(context).pop,
          ),
        ),
      );
}
