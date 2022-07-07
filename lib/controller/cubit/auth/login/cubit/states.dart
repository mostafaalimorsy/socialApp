
abstract class SocialAppLoginStates {}



class IntialShopAppLoginStates extends SocialAppLoginStates {}
class SocialAppLoadingStates extends SocialAppLoginStates {}
class SocialAppScuccessStates extends SocialAppLoginStates {
  final String Uid;

  SocialAppScuccessStates(this.Uid);
}
class SocialAppErrorStates extends SocialAppLoginStates {}

class SocialChangPasswordVisabilityStates extends SocialAppLoginStates {}




class SocialAppLoadingRigesterStates extends SocialAppLoginStates {}
class SocialAppScuccessRigesterStates extends SocialAppLoginStates {}
class SocialAppErrorRigesterStates extends SocialAppLoginStates {}

class SocialChangPasswordVisabilityRigesterStates extends SocialAppLoginStates {}

