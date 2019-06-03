import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'professionaldetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';

class UpdateProfessionalDetails extends StatefulWidget {
  String company = '';
  String designation = '';
  String startyear = '';
  String endmonth = '';
  String endyear = '';
  String startmonth = '';
  String descriptiom = '';
  String location = '';
  String documentref = '';

  UpdateProfessionalDetails(
      {this.company,
      this.designation,
      this.startyear,
      this.endmonth,
      this.endyear,
      this.startmonth,
      this.descriptiom,
      this.location,
      this.documentref});

  AuthService authService = AuthService();

  @override
  _UpdateProfessionalDetailsState createState() =>
      _UpdateProfessionalDetailsState();
}

class _UpdateProfessionalDetailsState extends State<UpdateProfessionalDetails> {
  String company = '';
  String designation = '';
  String startyear = '';
  String endmonth = '';
  String endyear = '';
  String startmonth = '';
  String descriptiom = '';
  String location = '';
  String documentref = '';


  var onpress;

  String userid = '';
  final Map<String, dynamic> _professionalMap = {
    'company': null,
    'designation': null,
    'startmonth': null,
    'endmonth': null,
    'startyear': null,
    'endyear': null,
    'location': null,
    'description': null,
  };
  int groupValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool val = false;

  Widget box(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 18.0,
        ),
        Icon(
          Icons.date_range,
          color: Colors.grey,
        ),
        SizedBox(
          width: 25.0,
        ),
        Container(
          width: 90.0,
          child: TextFormField(
            decoration: InputDecoration(hintText: 'End Year'),
            initialValue: endyear,
            validator: (String value) {
              if (value.isEmpty ||
                  value.length > 4 ||
                  value.length < 4 ||
                  !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value) ||
                  !(int.parse(value) >= 1980) ||
                  !(int.parse(value) <= 2022)) {
                return 'Not valid Year';
              }
            },
            onSaved: (String value) {
              _professionalMap['endyear'] = value;
            },
          ),
        ),
        SizedBox(
          width: 40.0,
        ),
        Container(
          width: 90.0,
          child: TextFormField(
            decoration: InputDecoration(hintText: 'End Month'),
            initialValue: endmonth,
            validator: (String value) {
              if (value.isEmpty ||
                  value.length > 3 ||
                  value.length < 3 ||
                  RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                      .hasMatch(value) ||
                  !checkMonth(value)) {
                return 'Not valid Month';
              }
            },
            onSaved: (String value) {
              _professionalMap['endmonth'] = value;
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.authService.getCurrentuser().then((userid) {
      setState(() {
        this.userid = userid;
      });
    });

    this.company = widget.company;
    this.endyear = widget.endyear;
    this.documentref = widget.documentref;
    this.descriptiom = widget.descriptiom;
    this.startyear = widget.startyear;
    this.endmonth = widget.endmonth;
    this.location = widget.location;
    this.designation = widget.designation;
    this.startmonth = widget.startmonth;

    if (endyear == 'present') {
      val = true;
    }

    onpress = false;
  }

  Future updateDatabase(String userId, Map<String, dynamic> personalMap) async {
    Firestore.instance
        .collection('users')
        .document('professional')
        .collection(userId)
        .document(documentref)
        .setData(personalMap)
        .whenComplete(() {
          progress(false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProfessionalDetails()));
    });
  }
  bool checkMonth(String value) {

    if (value == 'Jan' || value == 'jan') {
      return true;
    } else if (value == 'Feb' || value == 'feb') {
      return true;
    } else if (value == 'Mar' || value == 'mar') {
      return true;
    } else if (value == 'Apr' || value == 'apr') {
      return true;
    } else if (value == 'May' || value == 'may') {
      return true;
    } else if (value == 'Jun' || value == 'jun') {
      return true;
    } else if (value == 'Jul' || value == 'jul') {
      return true;
    } else if (value == 'Aug' || value == 'aug') {
      return true;
    } else if (value == 'Sep' || value == 'sep') {
      return true;
    } else if (value == 'Oct' || value == 'oct') {
      return true;
    } else if (value == 'Nov' || value == 'nov') {
      return true;
    } else if (value == 'Dec' || value == 'dec') {
      return true;
    }
    return false;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text('Professional'),
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

                  updateDatabase(userid, _professionalMap);
                  setState(() {
                    onpress = true;
                  });
                }
              },
            ),
          ],
        ),
        body:  (onpress == true)?  progress(true):  Form(
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
                        hintText: "Company",
                      ),
                      initialValue: company,
                      validator: (String value) {
                        if (value.isEmpty ||
                            RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                .hasMatch(value)) {
                          return 'Please fill the valid Company Name';
                        }
                      },
                      onSaved: (String value) {
                        _professionalMap['company'] = value;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.face),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Designation",
                      ),
                      initialValue: designation,
                      validator: (String value) {
                        if (value.isEmpty ||
                            RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                .hasMatch(value)) {
                          return 'Please fill valid Designation';
                        }
                      },
                      onSaved: (String value) {
                        _professionalMap['designation'] = value;
                      },
                    ),
                  ),
                  Divider(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: new ListTile(
                      leading: const Icon(Icons.timer),
                      title: const Text('Time Period'),
                      subtitle: Container(
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('I currently work here'),
                                Checkbox(
                                  activeColor: Color(0xFF26D2DC),
                                  value: val,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val = value;
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 18.0,
                      ),
                      Icon(
                        Icons.date_range,
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
                            if (value.isEmpty ||
                                value.length > 4 ||
                                value.length < 4 ||
                                !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                    .hasMatch(value) ||
                                !(int.parse(value) >= 1980) ||
                                !(int.parse(value) <= 2022)) {
                              return 'Not valid Year';
                            }
                          },
                          onSaved: (String value) {
                            _professionalMap['startyear'] = value;
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
                            hintText: "Start Month",
                          ),
                          initialValue: startmonth,
                          validator: (String value) {
                            if (value.isEmpty ||
                                value.length > 3 ||
                                value.length < 3 ||
                                RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                    .hasMatch(value) ||
                                !checkMonth(value)) {
                              return 'Not valid Month';
                            }
                          },
                          onSaved: (String value) {
                            _professionalMap['startmonth'] = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  appear(context, val),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(),
                  new ListTile(
                    leading: const Icon(Icons.location_on),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Location",
                      ),
                      initialValue: location,
                      validator: (String value) {
                        if (value.isEmpty ||
                            RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                .hasMatch(value)) {
                          return 'Please fill valid Location';
                        }
                      },
                      onSaved: (String value) {
                        _professionalMap['location'] = value;
                      },
                    ),
                  ),
                  Divider(),
                  new ListTile(
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
                      initialValue: descriptiom,
                      validator: (String value) {
                        if (value.isEmpty ||
                            RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                .hasMatch(value)) {
                          return 'Please enter valid Description';
                        }
                      },
                      onSaved: (String value) {
                        _professionalMap['description'] = value;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        )




      );
  }

  Widget appear(BuildContext context, bool valu) {
    if (valu) {
      _professionalMap['endyear'] = 'present';
      _professionalMap['endmonth'] = '';

      return Container();
    } else {
      return box(context);
    }
  }

  Widget progress(bool visibility) {
    return Visibility(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF26D2DC)),
          ),
        ),
        visible: visibility);
  }

}
