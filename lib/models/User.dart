class User{

  User(this._email,this._lastName,this._firstName, {email,lastName,firstName});

  var _email,_lastName,_firstName;

  getEmail()=> _email;
  getFirstName() => _firstName;
  getLastName() => _lastName;

  setFirstName(name) { _firstName=name;}
  setLastName(name) { _lastName=name;}


}