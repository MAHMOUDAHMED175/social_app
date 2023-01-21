


abstract class SocialRegisterStates{}
class SocialRegisterInitiState extends SocialRegisterStates{}
class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{


}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String Error;
  SocialRegisterErrorState(this.Error);
}



class SocialCreateUserSuccessState extends SocialRegisterStates{

}
class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserErrorState(this.error);
}
class SocialRegisterChangePassowrdVisibilityState extends SocialRegisterStates{}