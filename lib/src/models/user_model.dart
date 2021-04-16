import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {

    String id;
    String nombre = "";
    String apellido = "";
    DateTime nacimiento;
    String mail = "";
    String celular = "";
    bool whatsapp = true;

    UserModel({
        this.id,
        this.nombre,
        this.apellido,
        this.nacimiento,
        this.mail,
        this.celular,
        this.whatsapp,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        nacimiento: DateTime.parse(json["nacimiento"]),
        mail: json["mail"],
        celular: json["celular"],
        whatsapp: json["whatsapp"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "apellido": apellido,
        "nacimiento": "${nacimiento.year.toString().padLeft(4, '0')}-${nacimiento.month.toString().padLeft(2, '0')}-${nacimiento.day.toString().padLeft(2, '0')}",
        "mail": mail,
        "celular": celular,
        "whatsapp": whatsapp,
    };
}
