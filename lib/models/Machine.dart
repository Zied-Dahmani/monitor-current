// ignore_for_file: file_names

class Machine{

  Machine(this._id,this._name,this._power,this._maxTemperature,this._minTemperature,this._image, {id,name,power,maxTemperature,minTemperature,image});

  var _id,_name,_power,_maxTemperature,_minTemperature,_image;

  getId() => _id;
  getName() => _name;
  getPower() => _power;
  getMaxTemperature() => _maxTemperature;
  getMinTemperature() => _minTemperature;
  getImage() => _image;

  setName(name){ _name= name;}
  setPower(power){ _power= power;}
  setMaxTemperature(temperature){_maxTemperature=temperature;}
  setMinTemperature(temperature){_minTemperature=temperature;}

}