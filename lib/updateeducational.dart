import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'educationdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';

class UpdateEducationDetails extends StatefulWidget {
  AuthService authService = AuthService();

  String institute = '';
  String degree = '';
  String field = '';
  String startyear = '';
  String endyear = '';
  String description = '';
  String documentRef = '';

  UpdateEducationDetails(
      {this.institute,
      this.degree,
      this.field,
      this.startyear,
      this.endyear,
      this.description,
      this.documentRef});

  @override
  _UpdateEducationDetailsState createState() => _UpdateEducationDetailsState();
}

class _UpdateEducationDetailsState extends State<UpdateEducationDetails> {
  String userId = '';
  String institute = '';
  String degree = '';
  String field = '';
  String startyear = '';
  String endyear = '';
  String description = '';
  String documentRef = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _educationallMap = {
    'institute': null,
    'degree': null,
    'field': null,
    'startyear': null,
    'endyear': null,
    'description': null,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.authService.getCurrentuser().then((userid) {
      setState(() {
        this.userId = userid;
      });
    });

    this.institute = widget.institute;
    this.degree = widget.degree;
    this.field = widget.field;
    this.startyear = widget.startyear;
    this.endyear = widget.endyear;
    this.description = widget.description;
    this.documentRef = widget.documentRef;
  }

  Future updateDatabase(String userId, Map<String, dynamic> personalMap) async {
    Firestore.instance
        .collection('users')
        .document('education')
        .collection(userId)
        .document(documentRef)
        .setData(personalMap)
        .whenComplete(() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EducationalDetails()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Education'),
          backgroundColor: Color(0xFF26D2DC),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              color: Colors.white,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                } else {
                  _formKey.currentState.save();

                  updateDatabase(userId, _educationallMap);
                }
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  new ListTile(
                    leading: const Icon(Icons.account_balance),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Institute/University",
                      ),
                      initialValue: institute,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please fill the Institute/University';
                        }
                      },
                      onSaved: (String value) {
                        _educationallMap['institute'] = value;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.school),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Degree",
                      ),
                      initialValue: degree,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please fill Degree';
                        }
                      },
                      onSaved: (String value) {
                        _educationallMap['degree'] = value;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.local_library),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Field of Study",
                      ),
                      initialValue: field,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please fill Field of Study';
                        }
                      },
                      onSaved: (String value) {
                        _educationallMap['field'] = value;
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 18.0,
                        ),
                        Icon(
                          Icons.today,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Container(
                          width: 90.0,
                          child: TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Start Year",
                            ),
                            initialValue: startyear,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please fill Start Year';
                              }
                            },
                            onSaved: (String value) {
                              _educationallMap['startyear'] = value;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 40.0,
                        ),
                        Container(
                          width: 90.0,
                          child: TextFormField(
                            decoration: new InputDecoration(
                              hintText: "End Year",
                            ),
                            initialValue: endyear,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please fill End Year';
                              }
                            },
                            onSaved: (String value) {
                              _educationallMap['endyear'] = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: new ListTile(
                      leading: const Icon(Icons.library_books),
                      title: new TextFormField(
                        maxLines: 3,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          hintText: "Description",
                        ),
                        initialValue: description,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your Description';
                          }
                        },
                        onSaved: (String value) {
                          _educationallMap['description'] = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}