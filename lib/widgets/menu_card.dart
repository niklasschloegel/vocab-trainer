import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String description;
  final Function(BuildContext) navigate;

  const MenuCard({
    Key? key,
    required this.title,
    required this.description,
    required this.navigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: true,
      label: "$title.$description",
      // textDirection: TextDirection.ltr,
      child: ExcludeSemantics(
        excluding: true,
        child: Card(
          color: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () => navigate(context),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  Text(description),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
