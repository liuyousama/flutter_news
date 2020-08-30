import 'package:flutter/material.dart';
import 'package:flutter_news/core/color/color.dart';
import 'package:flutter_news/core/extensions/extension.dart';

class LYSignInPage extends StatefulWidget {
  static const routeName = "/signin";

  @override
  _LYSignInPageState createState() => _LYSignInPageState();
}

class _LYSignInPageState extends State<LYSignInPage> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // GestureDetector: 点击界面空白处回收键盘
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: LYAppColor(context).primaryBackground,
        // SingleChildScrollView: 键盘弹出时，界面可滚动
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTopLogo(context),
              ..._buildLogoText(context),
              _buildTextField(context, emailController, "Email", false),
              _buildTextField(context, pwdController, "Password", true),
              _buildActionButton(context),
              _buildForgetPwd(context),
              _buildExplainText(context),
              _buildSocialLogin(context),
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
              color: LYAppColor(context).primaryBackground,
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
      Text("SECTOR", style: TextStyle(
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
        color: LYAppColor(context).primaryText,
        fontSize: 24.lyFont
      )),
      Text("news", style: TextStyle(
        fontFamily: "Avenir",
        fontWeight: FontWeight.normal,
        color: LYAppColor(context).primaryText,
        fontSize: 16.lyFont
      ),),
      SizedBox(height: 50.lyHeight,)
    ];
  }
  /// 创建两个输入框
  Widget _buildTextField(BuildContext context, TextEditingController controller,
      String placeholder, bool isSecure)
  {
    final inputDecoration = InputDecoration(
      hintStyle: TextStyle(
        fontFamily: "Avenir",
        color: LYAppColor(context).primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 18.lyFont
      ),
      hintText: placeholder,
      icon: SizedBox(width: 5.lyWidth),
      // 当输入框中有内容时，出现一个清除按钮
      suffixIcon: (controller.text != "")
          ? GestureDetector(
              child: Icon(Icons.close,color: LYAppColor(context).primaryText),
              onTap: ()=>setState((){controller.text = "";}),
            )
          : null,
      border: InputBorder.none
    );

    return Container(
      height: 44.lyHeight,
      width: 295.lyWidth,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.lyWidth),
        color: LYAppColor(context).secondaryElement,
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
    final textStyle = TextStyle(
      fontSize: 18.lyFont,
      color: LYAppColor(context).primaryElementText,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 44.lyHeight,
          width: 140.lyWidth,

          child: FlatButton(
            color: LYAppColor(context).thirdElement,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.lyWidth)),
            child: Text("Sign up", style: textStyle),
            onPressed: ()=>print("登录"),
          ),
        ),
        Container(
          height: 44.lyHeight,
          width: 140.lyWidth,
          margin: EdgeInsets.only(left: 15.lyWidth),
          child: FlatButton(
            color: LYAppColor(context).primaryElement,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.lyWidth)),
            child: Text("Sign in", style: textStyle),
            onPressed: ()=>print("注册"),
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
        child: Text("Forgot password?", style: TextStyle(
          color: LYAppColor(context).secondaryElementText,
          fontFamily: "Avenir",
          fontWeight: FontWeight.normal,
          fontSize: 16.lyFont
        ),),
      ),
    );
  }
  /// 说明文字
  Widget _buildExplainText(BuildContext context) {
    const explainText = "Or sign in with social networks";
    return Container(
      margin: EdgeInsets.only(top: 110.lyHeight,bottom: 20.lyHeight),
      child: Text(explainText, style: TextStyle(
        fontFamily: "Avenir",
        fontWeight: FontWeight.normal,
        fontSize: 16.lyFont,
        color: LYAppColor(context).primaryText
      )),
    );
  }
  /// 社交登录按钮
  Widget _buildSocialLogin(BuildContext context) {
    final btn = (String icon, String url) {
      return GestureDetector(
        onTap: ()=>print("点击了$url"),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 88.lyWidth,
              height: 44.lyHeight,
              decoration: BoxDecoration(
                color: LYAppColor(context).primaryBackground,
                borderRadius: BorderRadius.circular(6.lyWidth),
                border: Border.all(
                  color: LYAppColor(context).borderColor1,
                  width: 1.lyWidth
                )
              ),
            ),
            Image.asset("assets/images/$icon.png",
              height: 24.lyWidth,
              width: 24.lyWidth,
              fit: BoxFit.fill,
            )
          ]

        ),
      );
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        btn("signin_twitter", "推特"), SizedBox(width: 15.lyWidth,),
        btn("signin_google", "谷歌"), SizedBox(width: 15.lyWidth,),
        btn("signin_facebook", "Facebook")
      ],
    );
  }
  /// 底部的注册按钮
  Widget _buildBottomSignUp(BuildContext context) {
    return GestureDetector(
      onTap: ()=>print("注册"),
      child: Container(
        width: 295.lyWidth,
        height: 44.lyHeight,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 40.lyHeight),
        decoration: BoxDecoration(
          color: LYAppColor(context).secondaryElement,
          borderRadius: BorderRadius.circular(6.lyWidth)
        ),
        child: Text("Sign up", style: TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
          color: LYAppColor(context).primaryText,
          fontSize: 16.lyFont
        )),
      ),
    );
  }
}
