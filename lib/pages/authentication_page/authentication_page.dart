import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/authentication_helper.dart';
import '../../helper/show_snackbar.dart';
import '../../helper/user_provider.dart';
import '../../models/user.dart';
import '../../router.dart';
import '../../theme.dart';
import 'components/custom_checkbox.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isLoginPage = true;
  bool rememberCredential = false;
  bool isLoading = false;
  late TextEditingController _emailController;
  late TextEditingController _pswController;
  late TextEditingController _nameController;
  late TextEditingController _surnameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pswController = TextEditingController();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pswController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.lightColor,
        body: GestureDetector(
          //hide keyboard when user tap on the screen
          onTap: () => unFocus(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: kToolbarHeight / 2,
                left: 10.0,
                right: 10.0,
              ),
              child: _buildBody(),
            ),
          ),
        ),
        bottomNavigationBar: _buildNavBar(),
      );

  Future<void> unFocus() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  Widget _buildBody() {
    //just to test
    final _paddingHeight = SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
    return SingleChildScrollView(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _logoApp(),
              _paddingHeight,
              //name and surname fields
              if (!isLoginPage) ..._registerFields(_paddingHeight),
              _emailField(),
              _paddingHeight,
              _pswField(),
              if (isLoginPage) _rememberMeForgotPsw(),
              _paddingHeight,
              // * login Btn
              SizedBox(
                width: double.infinity,
                child: _loginBtn(),
              ),
              _paddingHeight,
              // * is only text
              _youCanConnectWith(),
              _paddingHeight,
              // * logins btns (google - facebook)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _googleLoginBtn(),
                    ),
                    Expanded(
                      flex: 1,
                      child: _facebookLoginBtn(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar() => Container(
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.0),
            ),
            color: AppColor.buttonColor),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            isLoginPage
                ? "Don't have an Account ?"
                : "Already have an Account ?",
            style: const TextStyle(color: Colors.white),
          ),
          TextButton(
              child: Text(
                isLoginPage ? "Register" : "Login",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(
                  () => isLoginPage = !isLoginPage,
                );
              }),
        ]),
      );

  Widget _logoApp() => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo.png"),
          ),
        ),
      );

  List<Widget> _registerFields(Widget padding) => [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: _nameField(),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 5,
                child: _surnameField(),
              ),
            ],
          ),
        ),
        padding,
      ];

  TextField _nameField() => _buildTextField(
        controller: _nameController,
        icon: const Icon(Icons.people),
        label: "name*",
      );

  TextField _surnameField() => _buildTextField(
        controller: _surnameController,
        icon: const Icon(Icons.people),
        label: "surname *",
      );

  SizedBox _emailField() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: _buildTextField(
          controller: _emailController,
          icon: const Icon(Icons.email),
          label: "email *",
        ),
      );

  SizedBox _pswField() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: _buildTextField(
          controller: _pswController,
          icon: const Icon(Icons.lock),
          label: "password *",
          isPsw: true,
        ),
      );

  TextField _buildTextField({
    required TextEditingController controller,
    required Icon icon,
    required String label,
    bool isPsw = false,
  }) =>
      TextField(
        controller: controller,
        obscureText: isPsw,
        decoration: InputDecoration(
          prefixIcon: icon,
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      );

  SizedBox _rememberMeForgotPsw() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCheckbox(onCheck: (newVal) => rememberCredential = newVal),
            const Text("Remember Me"),
            const Spacer(),
            TextButton(
              child: const Text("Forgot Password"),
              onPressed: () {
                //send new password
              },
            ),
          ],
        ),
      );

  Widget _loginBtn() => isLoading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : ElevatedButton(
          child: Text(isLoginPage ? "Login" : "Register"),
          onPressed: () async => await onAuthRequest(),
        );

//is only text
  Row _youCanConnectWith() => Row(
        children: const [
          Expanded(
            flex: 2,
            child: Divider(
              height: 1.0,
              thickness: 1.0,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              child: Text("You can Connect with"),
            ),
          ),
          Expanded(
            flex: 2,
            child: Divider(
              height: 1.0,
              color: Colors.black,
              thickness: 1.0,
            ),
          ),
        ],
      );

  Container _googleLoginBtn() => Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: const Color(0xFFEA4335),
            ),
            borderRadius: BorderRadius.circular(15.0)),
        child: const Center(
            child: Text(
          "Google",
          style: TextStyle(
            color: Color(0xFFEA4335),
            fontWeight: FontWeight.bold,
          ),
        )),
      );

  Container _facebookLoginBtn() => Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: AppColor.buttonColor),
            borderRadius: BorderRadius.circular(15.0)),
        child: const Center(
            child: Text(
          "Facebook",
          style: TextStyle(
            color: AppColor.buttonColor,
            fontWeight: FontWeight.bold,
          ),
        )),
      );

//user perform authentication: login - register :P
  Future<void> onAuthRequest() async {
    setState(() {
      isLoading = true;
    });
    if (isLoginPage) {
      try {
        final User userResult = await AuthenticationHelper().login(
          _emailController.text,
          _pswController.text,
          rememberCredential,
        );
        //aggiorno utente !
        context.read<UserProvider>().refreshUser(userResult);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRouter.launch, (route) => false);
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    } else {
      try {
        final User userResult = await AuthenticationHelper().register(
          _emailController.text,
          _pswController.text,
          _nameController.text,
          _surnameController.text,
        );
        showSnackBar(context, "Check your Email to verify your account !");
        context.read<UserProvider>().refreshUser(userResult);
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.launch,
          (route) => false,
        );
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
