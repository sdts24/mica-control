import 'package:flutter/material.dart';
import 'package:mica_control/src/models/user_model.dart';
import 'package:mica_control/src/providers/users_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final usersProvider = new UsersProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: usersProvider.obtenerUser(),
        //initialData: InitialData,
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, i) => _crearListTile(users[i], context),
            );
          } else {
            return Center(
                child: Container(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }

  Widget _crearListTile(UserModel user, BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        usersProvider.borrarUser(user.id);
      },
      child: Card(
        color: Colors.white70,
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            // (miembro.estado == true ) ?
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 30.0,
                child: Icon(
                  Icons.person,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
              title: Text('Miembro: ${user.nombre} ${user.apellido} '),
              subtitle: Text('Teléfono: ${user.celular}'),
              // onTap: () => Navigator.pushNamed(context, 'producto',
              //     arguments: producto),
              onTap: () => _crearAlerta(context, user),
            ),
          ],
        ),
      ),
    );
  }

  _crearAlerta(BuildContext context, UserModel user) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selecione'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('Desea Editar el Usuario: ${user.nombre} ${user.apellido}'),
              Icon(
                Icons.info,
                size: 75.0,
              )
            ]),
            actions: <Widget>[
              FlatButton(
                onPressed: () =>
                    Navigator.pushNamed(context, 'user', arguments: user),
                child: Text('Editar'),
              ),
            ],
          );
        });
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'user'),
    );
  }
}
