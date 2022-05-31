import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return const Center(
            child: Text('Autenticando....'),
          );
        },
      ),
    );
  }

  Future checkLoginState(context) async {
    final authService = Provider.of<AuthServices>(context, listen: false);
    final socketServices = Provider.of<SocketService>(context, listen: false);
    final autenticando = await authService.isLoggedIn();

    if (autenticando!) {
      socketServices.connect();
      Navigator.pushReplacementNamed(context, 'usuarios');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
