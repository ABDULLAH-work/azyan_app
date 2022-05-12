abstract class AddSalonStates {}

class AddSalonStatesInitialState extends AddSalonStates {}

class AddSalonImagePickedSuccessState extends AddSalonStates {}

class AddSalonImagePickedErrorState extends AddSalonStates {}

class AddSalonUploadImageSuccessState extends AddSalonStates {}

class AddSalonUploadImageErrorState extends AddSalonStates {}

class AddSalonShowPasswordStates extends AddSalonStates {}

class ChangeDropDownLocationState extends AddSalonStates {}

class ChangeDropDownTimeStartState extends AddSalonStates {}

class ChangeDropDownTimeEndState extends AddSalonStates {}

class AddSalonFillCheckboxServicesHairStates extends AddSalonStates {}

class AddSalonFillCheckboxServicesFaceStates extends AddSalonStates {}

class AddSalonFillCheckboxServicesBodyStates extends AddSalonStates {}

class SalonRegisterLoadingState extends AddSalonStates {}

class SalonRegisterErrorState extends AddSalonStates {}

class RegisterCreateSalonSuccessState extends AddSalonStates {
 final String ?uId;

  RegisterCreateSalonSuccessState(this.uId);
}

class RegisterCreateSalonErrorState extends AddSalonStates {}



