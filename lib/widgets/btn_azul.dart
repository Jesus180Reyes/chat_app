import 'package:flutter/material.dart';

class BotonAzulWidget extends StatelessWidget {
  final String texto;
  final Function onPressed;
  final Color colors;

  const BotonAzulWidget({
    Key? key,
    required this.texto,
    required this.onPressed,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      color: Colors.blue,
      shape: const StadiumBorder(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Text(
            texto,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      onPressed: () => {
        if (onPressed() != null)
          {
            onPressed(),
          }
        else
          null
      },
    );
  }
}
