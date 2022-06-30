import 'package:flutter/material.dart';

class CilcularProgressIndicationCustom extends StatelessWidget {
  final String text;

  const CilcularProgressIndicationCustom({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          const SizedBox(height: 20),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
