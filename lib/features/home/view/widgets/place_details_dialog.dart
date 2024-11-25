import 'package:cafedating/features/home/notifier/place_details_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceDetailsDialog extends ConsumerWidget {
  const PlaceDetailsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeDetails = ref.watch(placeDetailsNotifierProvider);
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
