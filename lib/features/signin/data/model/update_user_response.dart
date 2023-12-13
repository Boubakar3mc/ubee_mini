enum UpdateUserResponseError{none,unknown,notLogedIn,unauthorized,retryLimitExceeded}

class UpdateUserResponse{
  bool isSuccess;
  UpdateUserResponseError responseError;
  String message;

  UpdateUserResponse(this.isSuccess,{this.responseError=UpdateUserResponseError.none,this.message=""});
}