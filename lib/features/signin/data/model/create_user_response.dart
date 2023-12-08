enum CreateUserResponseError{none,emailAlreadyInUse,invalidEmail,operationNotAllowed,weakPassword}

class CreateUserResponse{
  bool isSuccess;
  CreateUserResponseError responseError;

  CreateUserResponse(this.isSuccess,{this.responseError=CreateUserResponseError.none});
}