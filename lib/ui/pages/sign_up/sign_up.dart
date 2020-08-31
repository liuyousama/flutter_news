import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:flutter_news/core/assets/font.dart';
import 'package:flutter_news/core/extensions/extension.dart';
import 'package:flutter_news/ui/widgets/sign_in_social.dart';

class LYSignUpPage extends StatefulWidget {
  static const routeName = "/sign-up";
  @override
  _LYSignUpPageState createState() => _LYSignUpPageState();
}

class _LYSignUpPageState extends State<LYSignUpPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var pwdController = TextEditingController();

  var pwdSecure = true;
  @override
  Widget build(BuildContext context) {
    // GestureDetector：点击界面退键盘
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: AppColor(context).primaryBackground,
        appBar: _buildAppBar(context),
        // SingleChildScrollView：键盘弹出可滚动
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderTitle(context),
              SizedBox(height: 50.lyHeight,),
              _buildTextField(context, nameController, 0, false),
              _buildTextField(context, emailController, 1, false),
              _buildTextField(context, pwdController, 2, pwdSecure),
              _buildSubmitBtn(context),
              _buildComplainText(context),
              SizedBox(height: 88.lyHeight,),
              SignInSocialWidget(),
              _buildBottomSignUp(context)
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:AppColor(context).primaryBackground,
      elevation: 2,
      toolbarHeight: 44.lyHeight,
      actions: [IconButton(
        icon: Icon(Icons.info_outline, size: 24, color: AppColor(context).primaryText),
        onPressed: ()=>print("点击了info按钮"),
      )],
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 24, color: AppColor(context).primaryText,),
        onPressed: _handlePopToSignUp,
      ),
    );
  }

  Widget _buildHeaderTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.lyHeight),
      alignment: Alignment.center,
      child: Text("Signup", style: AppFont.montserratSemiBold(24.lyFont, AppColor(context).primaryText)),
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController controller,
      int index, bool isSecure)
  {
    final placeholder = ["Full Name", "Email", "Password"][index];
    final appColor = AppColor(context);
    final suffixIcon = (index!=2||pwdController.text == null||pwdController.text=="")
        ? null
        : GestureDetector(
          child: Icon(Icons.remove_red_eye, color: isSecure?appColor.primaryText:appColor.primaryElement),
          onTap: (){setState(() {pwdSecure = !pwdSecure;});},
        );
    final inputDecoration = InputDecoration(
      hintStyle: AppFont.avenirBook(18.lyFont, AppColor(context).primaryText),
      hintText: placeholder,
      icon: SizedBox(width: 5.lyWidth),
      // 当邮箱输入框中有内容时，出现一个清除按钮，密码输入框中有内容时，出现一个眼图标
      suffixIcon: suffixIcon,
      border: InputBorder.none,
    );

    return Container(
      height: 44.lyHeight,
      width: 295.lyWidth,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.lyWidth),
        color: AppColor(context).secondaryElement,
      ),
      child: TextField(
        decoration: inputDecoration,
        controller: controller,
        obscureText: isSecure,
        onChanged: (_)=>setState((){}),
        onEditingComplete: ()=>FocusScope.of(context).requestFocus(FocusNode()),
        onSubmitted: (_)=>FocusScope.of(context).requestFocus(FocusNode()),
      ),
    );
  }

  Widget _buildSubmitBtn(BuildContext context) {
    return Container(
      height: 40.lyHeight,
      width: 295.lyWidth,
      child: FlatButton(
        onPressed: ()=>print("注册"),
        color: AppColor(context).primaryElement,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.lyWidth)),
        child: Text(
            "Create an account",
            style: AppFont.montserratSemiBold(18.lyFont, AppColor(context).primaryElementText)
        ),
      ),
    );
  }

  Widget _buildComplainText(BuildContext context) {
    final normalStyle = AppFont.avenirBook(16.lyFont, AppColor(context).primaryText);
    final highlightStyle = normalStyle.copyWith(
      color: AppColor(context).primaryElement
    );

    return Container(
      margin: EdgeInsets.only(top: 20.lyHeight),
      width: 295.lyWidth,
      height: 44.lyHeight,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "By signing up you agree to our\n", style: normalStyle),
            WidgetSpan(child: GestureDetector(
              onTap: ()=>print("点击了Terms"),
              child: Text("Terms", style: highlightStyle,),
            )),
            TextSpan(text: " and ", style: normalStyle),
            WidgetSpan(child: GestureDetector(
              onTap: ()=>print("点击了Conditions of Use"),
              child: Text("Conditions of Use", style: highlightStyle),
            ))
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBottomSignUp(BuildContext context) {
    return GestureDetector(
      onTap: _handlePopToSignUp,
      child: Container(
        width: 295.lyWidth,
        height: 44.lyHeight,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 40.lyHeight),
        decoration: BoxDecoration(
            color: AppColor(context).secondaryElement,
            borderRadius: BorderRadius.circular(6.lyWidth)
        ),
        child: Text(
            "I have an account",
            style: AppFont.montserratMedium(16.lyFont, AppColor(context).primaryText)
        ),
      ),
    );
  }

  _handlePopToSignUp() {
    Navigator.pop(context);
  }
}
