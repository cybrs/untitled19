

import 'package:flutter/material.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Leave a feedback',textAlign: TextAlign.center),
      content: Form(
        key: _formKey,
        child:
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback here',
                filled: true,
              ),
              maxLines: 5,
              maxLength: 70,
              textInputAction: TextInputAction.done,
              validator: (String? text) {
                if (text == null || text.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
      ),
      actions: [
        TextButton(
          child: const Text('ASK LATER'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('SUBMIT'),
          onPressed: () => Navigator.pop(context),
            /**
             * Here we will add the necessary code to
             * send the entered data to the Firebase Cloud Firestore.
             */

        )
      ],
    );
  }
}