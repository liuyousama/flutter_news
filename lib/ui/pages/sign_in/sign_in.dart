import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:flutter_news/core/assets/font.dart';
import 'package:flutter_news/core/extensions/extension.dart';
import 'package:flutter_news/core/model/error_model.dart';
import 'package:flutter_news/core/network/api/user.dart';
import 'package:flutter_news/core/storage/global_storage.dart';
import 'package:flutter_news/core/utils/validator.dart';
import 'package:flutter_news/ui/pages/home/home.dart';
import 'package:flutter_news/ui/widgets/sign_in_social.dart';
import 'package:flutter_news/ui/widgets/toast.dart';

class LYSignInPage extends StatefulWidget {
  static const routeName = "/signin";

  @override
  _LYSignInPageState createState() => _LYSignInPageState();
}

class _LYSignInPageState extends State<LYSignInPage> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  var signDisabled = false;
  var pwdSecure = true;
  @override
  Widget build(BuildContext context) {
    // GestureDetector: 点击界面空白处回收键盘
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: AppColor(context).primaryBackground,
        // SingleChildScrollView: 键盘弹出时，界面可滚动
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTopLogo(context),
              ..._buildLogoText(context),
              _buildTextField(context, emailController, true, false),
              _buildTextField(context, pwdController, false, pwdSecure),
              _buildActionButton(context),
              _buildForgetPwd(context),
              SizedBox(height: 110.lyHeight,),
              SignInSocialWidget(),
              _buildBottomSignUp(context)
            ],
          ),
        ),
      ),
    );
  }
  /// logo
  Widget _buildTopLogo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 84.lyHeight),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 76.lyWidth,
            width: 76.lyWidth,
            decoration: BoxDecoration(
              color: AppColor(context).primaryBackground,
              borderRadius: BorderRadius.circular((76/2).lyWidth),
              boxShadow: [BoxShadow(
                  color: Color(0x261B1B1D),
                  offset: Offset(0, 5.lyWidth),
                  blurRadius: 10.lyWidth)],
            ),
          ),
          Image.asset("assets/images/signin_icon.png",
            width: 36.lyWidth,
            height: 48.lyHeight,
            fit: BoxFit.fill,
          )
        ],
      )
    );
  }
  /// logo下方的文字
  List<Widget> _buildLogoText(BuildContext context) {
    return [
      SizedBox(height: 15.lyHeight,),
      Text("SECTOR", style: AppFont.montserratSemiBold(24.lyFont, AppColor(context).primaryText)),
      Text("news", style: AppFont.avenirBook(16.lyFont, AppColor(context).primaryText)),
      SizedBox(height: 50.lyHeight,)
    ];
  }
  /// 创建两个输入框
  Widget _buildTextField(BuildContext context, TextEditingController controller,
      bool isEmail, bool isSecure)
  {
    final placeholder = isEmail ? "Email" : "Password";
    final appColor = AppColor(context);
    final suffixIcon = ((controller.text ?? "") == "")
      ? null
      : isEmail
        ? GestureDetector(
            onTap: (){
              emailController.text = "";
              pwdController.text = "";
              pwdSecure = true;
              setState(() {});
            },
            child: Icon(
              Icons.close,
              color: appColor.primaryText,
            )
          )
        : GestureDetector(
            onTap: (){
              setState(() {pwdSecure = !pwdSecure;});
            },
            child: Icon(
              Icons.remove_red_eye,
              color: isSecure?appColor.primaryText:appColor.primaryElement
            ),
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
  /// 注册登录按钮
  Widget _buildActionButton(BuildContext context) {
    final textStyle = AppFont.montserratSemiBold(18.lyFont, AppColor(context).primaryElementText);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 44.lyHeight,
          width: 140.lyWidth,

          child: FlatButton(
            color: AppColor(context).thirdElement,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.lyWidth)),
            child: Text("Sign up", style: textStyle),
            onPressed: _handleSignUp,
          ),
        ),
        Container(
          height: 44.lyHeight,
          width: 140.lyWidth,
          margin: EdgeInsets.only(left: 15.lyWidth),
          child: FlatButton(
            color: AppColor(context).primaryElement,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.lyWidth)),
            child: Text("Sign in", style: textStyle),
            onPressed: _handleSignIn,
          ),
        )
      ],
    );
  }
  /// 忘记密码
  Widget _buildForgetPwd(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.lyHeight),
      child: GestureDetector(
        onTap: ()=>print("忘记密码"),
        child: Text(
          "Forgot password?",
          style: AppFont.avenirBook(16.lyFont, AppColor(context).secondaryElementText)
        ),
      ),
    );
  }
  /// 底部的注册按钮
  Widget _buildBottomSignUp(BuildContext context) {
    return GestureDetector(
      onTap: _handleSignUp,
      child: Container(
        width: 295.lyWidth,
        height: 44.lyHeight,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 40.lyHeight),
        decoration: BoxDecoration(
          color: AppColor(context).secondaryElement,
          borderRadius: BorderRadius.circular(6.lyWidth)
        ),
        child: Text("Sign up", style: AppFont.montserratMedium(16.lyFont, AppColor(context).primaryText)),
      ),
    );
  }

  _handleSignIn() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (signDisabled) {return;}
    signDisabled = true;
    final email = emailController.text;
    final pwd = pwdController.text;
    if (!isEmail(email)) {await LYToast.showToast(context, "请输入正确的邮箱地址");signDisabled=false;return;}
    if (pwd == null||pwd.isEmpty) {await LYToast.showToast(context, "请输入密码");signDisabled=false;return;}
    if (pwd.length<8||pwd.length>16) {await LYToast.showToast(context, "密码错误");signDisabled=false;return;}
    try {
      final user = await loginUser(email, pwd);
      GlobalStorage.userProfile = user;
      Navigator.pushReplacementNamed(context, LYHomePage.routeName);
    } on LYErrorModel catch(e) {
      await LYToast.showToast(context, e.toString());
      signDisabled = false;
      return;
    }
  }

  _handleSignUp() {
    Navigator.pushNamed(context, "/sign-up");
  }
}
