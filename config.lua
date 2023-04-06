Config = {};

Config.IdCardSettings = {
   closeKey = 'Backspace',
   autoClose = {
      status = false, -- or true
      time = 3000
   }
};

Config.Licenses = {
   ["id_card"] = {
      header= "Identity",
      background= "#ebf7fd"
   },
   ["driver_license"] = {
      header= "Driver License",
      background= "#febbbb"
   },
   ["weaponlicense"] = {
      header= "Weapon License",
      background= "#c7ffe5"
   },
   ["lawyerpass"] = {
      header= "Lawyer Pass",
      background= "#f9c491"
   },
}