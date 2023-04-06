import { fetchNui } from './fetchNui.js';
import { globalLang } from '../../lang/global.js';

/**
 * Get element by id
 * @param id {string}
 **/
const getElementById = (id) => document.getElementById(id);

/**
 * Set visibility 
 * @param visibility {string}
 **/
const setVisibility = (visibility) => getElementById('um-idcard').style.visibility = visibility;

const closeFunction = () => {
    getElementById('um-idcard').classList.remove('animate__animated', 'animate__fadeInLeft', 'animate__faster');
    setVisibility('hidden');
    fetchNui('closeIdCard');
}

let config;

window.addEventListener('message', (event) => {
  const { type, playerData, configData } = event.data;
  switch (type) {
    case 'playerData':
      const { mugShot, lastName, firstName, dob, sex, nationality, cardtype } = playerData;
      const license = config.Licenses[cardtype];
      getElementById('mugshot').src = mugShot;
      getElementById('smallmugshot').src = mugShot;
      getElementById('lastname').textContent = lastName;
      getElementById('name').textContent = firstName;
      getElementById('sign').textContent = lastName + ' ' + firstName;
      getElementById('dob').textContent = dob;
      getElementById('sex').textContent = sex;
      getElementById('nationality').textContent = nationality;
      getElementById('cardtype').textContent = license.header;
      getElementById('um-idcard').style.backgroundColor = license.background;
      getElementById('um-idcard').classList.add('animate__animated', 'animate__fadeInLeft', 'animate__faster');
      setVisibility('visible');
      if (!config.IdCardSettings.autoClose.status) return;
        setTimeout(() => {
          closeFunction()
        }, config.IdCardSettings.autoClose.time);
      break;
    case 'configData':
      config = configData;
      break;
  }
});

window.addEventListener('load', () => {
  Object.entries(globalLang).forEach(([prop, value]) => {
    getElementById(prop).textContent = value;
  });
});

document.addEventListener('keydown', (e) => {
    if (e.key !== config.IdCardSettings.closeKey) return;
      closeFunction()
  });
