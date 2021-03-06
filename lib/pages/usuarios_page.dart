import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final usuarios = [
    // Usuario(
    //   isOnline: true,
    //   email: 'luisdejesus200122@gmail.com',
    //   nombre: 'Melissa',
    //   uid: '1',
    // ),
    // Usuario(
    //   isOnline: true,
    //   email: 'luisdejesus200122@gmail.com',
    //   nombre: 'Maria',
    //   uid: '2',
    // ),
    // Usuario(
    //   isOnline: false,
    //   email: 'luisdejesus200122@gmail.com',
    //   nombre: 'Fernando',
    //   uid: '3',
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final socketServices = Provider.of<SocketService>(context);
    final usuario = authServices.usuario;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          usuario!.nombre,
          style: const TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketServices.disconnect();
            Navigator.restorablePushReplacementNamed(context, 'login');
            AuthServices.deleteToken();
          },
          icon: socketServices.serverStatus == ServerStatus.online
              ? const Icon(
                  Icons.exit_to_app,
                  color: Colors.black87,
                )
              : const Icon(Icons.exit_to_app, color: Colors.red),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            // child: Icon(
            //   Icons.check_circle,
            //   color: Colors.blue[400],
            // ),
            child: Icon(
              Icons.offline_bolt,
              color: Colors.blue[400],
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () => _cargarUsuarios(),
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue,
        ),
        child: listiviewUsuarios(),
      ),
    );
  }

  ListView listiviewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: usuarios.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemBuilder: (BuildContext context, int index) {
        return usuarioListTile(usuarios[index]);
      },
    );
  }

  ListTile usuarioListTile(Usuario usuario) {
    return ListTile(
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(
          usuario.nombre.substring(0, 2),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.isOnline ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(20)),
      ),
      title: Text(
        usuario.nombre,
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    return _refreshController.refreshCompleted();
  }
}
