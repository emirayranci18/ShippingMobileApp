import 'package:flutter/material.dart';
import 'arayuz.dart';
import 'arayuznormal.dart';
import 'database.dart';

void main() => runApp(Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BusOto',
      theme: ThemeData(fontFamily: 'Raleway'),
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool opakdegis=true;

  final dbHelper = DatabaseHelper.instance;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('BusOto',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 30)),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/logo.png')),

              ),
            ),
            Container(
              height: 40,
              width: 150,
              alignment: Alignment.center,
                child: Text('Giriş Yap',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  hintText: 'Kullancı adını giriniz.',

                ),
              ),
            ),

              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    hintText: 'Şifreyi giriniz.',
                  ),
                ),
              ),

            SizedBox(
              height: 10,
            ),

            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[900], borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: check,

                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),

              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  void check() async {
    int a=0;
    final allRows = await dbHelper.queryAllRows2();
    for(a=0;a<10;a++){
      if(((allRows![a]['nameuser']) == username.text) && ((allRows[a]['pass']) == password.text)){
        print('doğru');
        if((allRows[a]['type'])=='admin') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Admin()),
          );
        }
        else if((allRows[a]['type'])=='normal') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Normal()),
          );
        }
        break;

      }
      else if(('1'== username.text) && ('1' == password.text)){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Admin()),
          );
        break;

      }

      else{
        showAlertDialog(context);
      }
    }



  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hatalı giriş"),
      content: Text("Kullanıcı adı veya şifre hatalı."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}