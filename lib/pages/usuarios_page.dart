import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}
class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1',nombre: 'Xnor',       email: 'test1@test.com',online: true),
    Usuario(uid: '1',nombre: 'Mariusal',   email: 'test2@test.com',online: true),
    Usuario(uid: '1',nombre: 'Andresilent',email: 'test3@test.com',online: false),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
      appBar:AppBar(
        title: Text(usuario.nombre,style: TextStyle(color: Colors.white)),
        elevation: 1,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app,color: Colors.white),
          onPressed: (){
            // to do desconectar del socket server 
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right:10),
            child: Icon(Icons.check_circle,color:Colors.green),
            //child: Icon(Icons.offline_bolt,color:Colors.redAccent[200]),  DESCONECTADO
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check,color: Colors.green),
          waterDropColor: Colors.black,
        ),
        child: _listViewUsuarios(),
      )
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_,i)=>_usuarioListTile(usuarios[i]),
      separatorBuilder: (_,i)=>Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),
          backgroundColor: Colors.black,
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color:usuario.online ? Colors.green: Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
      );
  }
  _cargarUsuarios()async{
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}