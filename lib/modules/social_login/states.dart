
abstract class SocialLoginStates{}

class InitiSocialLoginStates extends SocialLoginStates{}
class LoadingSocialLoginStates extends SocialLoginStates{}
class SuccessSocialLoginStates extends SocialLoginStates{
  final String uid;

  SuccessSocialLoginStates(this.uid);
}
class ErrorSocialLoginStates extends SocialLoginStates{
  final String error;

  ErrorSocialLoginStates(this.error);
}
class ChangeVisibilitySocialLoginStates extends SocialLoginStates{}