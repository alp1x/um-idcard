const idcard = Vue.createApp({
    data() {
       return {
          lang: QB.IDCardLang,
          background: '',
          picture: '',
          langheader2: '',
          Name: '',
          Lastname: '',
          Dob: '',
          Nationality: '',
          Sex: '',
          show: false,
          nui: false,
          disabled: false
       }
    },
    methods: {
       async fetchNui(eventName) {
          const resource = GetParentResourceName();
          const response = await fetch(`https://${resource}/${eventName}`, {
             method: 'post',
             headers: {
                'Content-Type': 'application/json; charset=UTF-8',
             },
             body: JSON.stringify({}),
          });
          return await response.json();
       },
       cardSet(bool, nui) {
          this.show = bool;
          this.langheader2 = QB.Licenses[nui].header;
          this.background = QB.Licenses[nui].background;
       },
       keyupHandler(e) {
          if (e.key == QB.CloseKey) {
             this.fetchNui('qb-idcard:nuicallback:closeNui')
             this.disabled = true;
             setTimeout(() => {
                this.nui = false;
             }, 500)
          }
       },
       eventHandler: function (event) {
          const data = event.data;
          const nui = data.nui
          this.Name = data.information.name;
          this.Lastname = data.information.lastname;
          this.Dob = data.information.dob;
          this.Nationality = data.information.nationality;
          this.lang.langsex = 'Sex';
          this.lang.langnat = 'Nationality';
          if (data.information.gender == 0) {
             this.Sex = 'Male'
             this.picture = 'male.png'
          } else if (data.information.gender == 1) {
             this.Sex = 'Female'
             this.picture = 'female.png'
          } else {
             this.Sex = 'None'
             this.picture = 'icon.png'
          }
          this.disabled = false;
          this.show = false;
          this.nui = true;
          switch (nui) {
             case 'idcard':
                this.cardSet(false, nui)
                break;
             case 'driverlicense':
                this.lang.langsex = 'Type';
                this.Sex = 'CLASS C Driver License';
                this.lang.langnat = '✔️ License';
                this.cardSet(false, nui)
                break;
             case 'weaponlicense':
                this.cardSet(true, nui)
                break;
             case 'lawyerpass':
                this.cardSet(true, nui)
                break;
             case 'policecard':
                this.cardSet(false, nui)
                break;
          }
          if (QB.AutoClose.close) {
             setTimeout(() => {
                this.fetchNui('qb-idcard:nuicallback:closeNui')
                this.disabled = true;
                this.nui = false;
             }, QB.AutoClose.time)
          }
       },
    },
    mounted() {
       window.addEventListener('message', this.eventHandler);
       document.addEventListener('keyup', this.keyupHandler);
    },
    beforeUnmount() {
       window.removeEventListener('message', this.eventHandler);
       document.removeEventListener('keyup', this.keyupHandler);
    },
 }).mount('#card')
