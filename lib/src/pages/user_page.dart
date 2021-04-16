import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mica_control/src/models/user_model.dart';
import 'package:mica_control/src/providers/users_provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final formKey = GlobalKey<FormState>();

  final usuarioProvider = new UsersProvider();

  UserModel usuario = new UserModel();
  String _fecha = '';
  bool whatsapp = true;

  TextEditingController _inputDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserModel userData = ModalRoute.of(context).settings.arguments;

    if (userData != null) {
      usuario = userData;
      _fecha = new DateFormat('yyyy-MM-dd').format(usuario.nacimiento);
      _inputDateController.text = _fecha;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuario'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                SizedBox(height: 20.0),
                _crearApellido(),
                SizedBox(height: 20.0),
                _crearMail(),
                SizedBox(height: 20.0),
                _crearCelular(),
                SizedBox(height: 20.0),
                _crearWhatsapp(),
                //SizedBox(height: 10.0),
                _crearFecha(context),
                SizedBox(height: 20.0),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: usuario.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombres',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (value) => usuario.nombre = value,
      validator: (value) {
        if (value.length < 2) {
          return 'Ingrese su Nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellido() {
    return TextFormField(
      initialValue: usuario.apellido,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Apellidos',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (value) => usuario.apellido = value,
      validator: (value) {
        if (value.length < 2) {
          return 'Ingrese Su Apellido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearMail() {
    return TextFormField(
      initialValue: usuario.mail,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (value) => usuario.mail = value,
      validator: (value) {
        if (value.length < 2) {
          return 'Ingrese Su Correo';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCelular() {
    return TextFormField(
      initialValue: usuario.celular,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Celular',
        prefixIcon: Icon(Icons.phone_android),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (value) => usuario.celular = value,
      validator: (value) {
        if (value.length < 10) {
          return 'Ingrese Su Número Celular de 10 Digitos';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearWhatsapp() {
    setState(() {
      usuario.whatsapp = whatsapp;
    });

    return SwitchListTile(
      value: usuario.whatsapp,
      title: Text('Whatsapp'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        whatsapp = value;
        usuario.whatsapp = whatsapp;
      }),
    );
  }

  Widget _crearFecha(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0),
      child: TextField(
        controller: _inputDateController,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Fecha de Nacimiento',
          labelText: 'Fecha de Nacimiento',
          prefixIcon: Icon(Icons.calendar_today),
          suffixIcon: Icon(Icons.perm_contact_calendar),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(
            new FocusNode(),
          );
          _selectDate(context);
        },
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2070));

    if (picked != null) {
      setState(() {
        usuario.nacimiento = picked;
        String _fecha = new DateFormat('yyyy-MM-dd').format(picked);
        _inputDateController.text = _fecha;
      });
    }
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      onPressed: _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    if (usuario.id == null) {
      usuarioProvider.crearUser(usuario);
    }else {
      usuarioProvider.editarUser(usuario);
    }

    Navigator.pushNamed(context, 'home');
  }
}