
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/components/component.dart';
import 'package:social_app/layout/Social_Layout.dart';
import 'package:social_app/modules/social_login/cubit.dart';
import 'package:social_app/modules/social_login/states.dart';
import 'package:social_app/modules/social_register/social_register_screen.dart';

import '../../components/cache_helper.dart';

class SocialLogin extends StatelessWidget {
//https://student.valuxapps.com/api/
  SocialLogin({Key key}) : super(key: key);

var formKey=GlobalKey<FormState>();
var emailController=TextEditingController();
var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is ErrorSocialLoginStates)
            {
              showToast(
                  text:
                  //state.error دى رساله من الداتا بيز نفسها
                  "الايميل غلط يابن الناصح اكتب صح  او الباسورد مش عارف شوف انت!!!",
                  state: ToastStates.ERROR,
              );
            }
          else if(state is SuccessSocialLoginStates)
          {
            CachHelper.saveData(key: 'uid', value: state.uid).then((value){
            navigateAndFinish(context, SocialLayout());
            });
          }
          // if(state is SuccessLoginStates){
          //   if(state.loginModel.status!){
          //     // دى علشان تظهر رساله كدا على السريع بنقول فيها لليوزر مبروك او error
          //     // Fluttertoast.showToast(
          //     //     msg:state.loginModel.message,// "اكتب الايميل والباسورد صح ياابن الناصح "
          //     //     toastLength: Toast.LENGTH_LONG,
          //     //     gravity: ToastGravity.SNACKBAR,
          //     //     timeInSecForIosWeb: 4,
          //     //     backgroundColor: Colors.white,
          //     //     textColor: Colors.black,
          //     //     fontSize: 20.2
          //     // );
          //     showToast(
          //         text: state.loginModel.message!,
          //         state:ToastStates.SUCCECC
          //     );
          //     CacheHelper.savedData(
          //         key: "token",
          //         value: state.loginModel.data!.token
          //     ).then((value){
          //       token=state.loginModel.data!.token;
          //
          //       navigateAndFinish(context, ShopLayout());
          //     });
          //
          //   }else{
          //
          //     showToast(
          //         text: state.loginModel.message!,
          //         state:ToastStates.ERROR
          //     );
          //   }
          // }
        },
        builder:(context, state) {
          return Scaffold(
            backgroundColor: HexColor('#B5AEA8'),
            appBar: AppBar(
              backgroundColor: HexColor('#B5AEA8'),

              title: const Text(
                'TASAOQ',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.9),

                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.grey[350],

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            defaultFormField(
                              controller: emailController,
                              labelText: 'Email',
                              hintText: 'email',

                              prefix: Icons.email,
                              type: TextInputType.emailAddress,
                              submit: (value) {
                                if (formKey.currentState.validate()) {

                                }
                              },
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return 'email must not be empty';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: passwordController,
                              labelText: 'Password',
                              prefix: Icons.lock,
                              suffixIcon: SocialLoginCubit.get(context).icons,
                              hintText: 'password',

                              isPassword: SocialLoginCubit.get(context).isPasswordshowen,
                              suffixPressd: ()
                              {
                                SocialLoginCubit.get(context).ChangeVisibility();
                              },
                              type: TextInputType.visiblePassword,
                              submit: (value){
                                if(formKey.currentState.validate())
                                 {
                                //   SocialLoginCubit.get(context).UserLogin(
                                //       email: emailController.text,
                                //       password: passwordController.text,
                                //   );
                                }
                              },
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return 'password is too short';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoadingSocialLoginStates,
                              builder:(context)=> defaultButton(
                                text: 'login',
                                isUppercase: true,

                                onPressed: ()
                                {
                                  if(formKey.currentState.validate())
                                  {
                                    //   Navigator.push(context,MaterialPageRoute(builder:(context)=>NewsLayout() ));
                                    //
                                    SocialLoginCubit.get(context).UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );


                                  }
                                  return null;
                                },
                              ),
                              fallback: (context)=>const Center(child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account?',
                                ),
                                TextButton(

                                  child: const Text(
                                    'Register Now',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>SocialRegister()
                                    )
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      );

  }
}
