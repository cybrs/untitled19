import 'package:flutter/material.dart';

class ResetApp extends StatefulWidget {
  const ResetApp({Key? key}) : super(key: key);


  @override
  State<ResetApp> createState() => _RestAppState();
}

class _RestAppState extends State<ResetApp> {
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
      title: Text('Reset App Data'),
      content: Text('Fetch all the data from online and discard local modification'),
      actions: [
        FlatButton(
          textColor: Color(0xff007FFF),
          onPressed: () {},
          child: Text('CANCEL'),
        ),
        FlatButton(
          textColor: Color(0xff007FFF),
          onPressed: () {},
          child: Text('RESET'),
        ),
      ],
    );
  }
}


// class FeedbackDialog extends StatefulWidget {
//   const FeedbackDialog({Key? key}) : super(key: key);
//
//   @override
//   State<FeedbackDialog> createState() => _FeedbackDialogState();
// }
//
// class _FeedbackDialogState extends State<FeedbackDialog> {
//   final TextEditingController _controller = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Reset settings?'),
//       content: Text('This will reset your device to its default factory settings.'),
//       actions: [
//         FlatButton(
//           textColor: Color(0xFF6200EE),
//           onPressed: () {},
//           child: Text('CANCEL'),
//         ),
//         FlatButton(
//           textColor: Color(0xFF6200EE),
//           onPressed: () {},
//           child: Text('ACCEPT'),
//         ),
//       ],
//     );
//   }
// }