return {

   -- fivemanage or local (local option saves to the web/assets/mugshots folder)
   -- recommended to use fivemanage
   mugshotsUpload = 'local',

   settings = {
      closeKey = 'Backspace',
      autoClose = {
         status = false, -- or true
         time = 3000
      },
      mugshotScale = 0.88
   },

   licenses = {
      ['id_card'] = {
         header = 'Identity',
         background = '#ebf7fd',
         prop = `prop_franklin_dl`
      },
      ['driver_license'] = {
         header = 'Driver License',
         background = '#febbbb',
         prop = `prop_franklin_dl`,
      },
      ['weaponlicense'] = {
         header = 'Weapon License',
         background = '#c7ffe5',
         prop = `prop_franklin_dl`,
      },
      ['lawyerpass'] = {
         header = 'Lawyer Pass',
         background = '#f9c491',
         prop = `prop_cs_r_business_card`
      },
   }

}
