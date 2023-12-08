enum UpdateNamesAndBirthdateRepsonseError{none,notLogedIn}

class UpdateNamesAndBirthdateResponse{
  bool isSuccess;
  UpdateNamesAndBirthdateRepsonseError responseError;
  String message;

  UpdateNamesAndBirthdateResponse(this.isSuccess,{this.responseError=UpdateNamesAndBirthdateRepsonseError.none,this.message=""});
}