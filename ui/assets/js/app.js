const idcard = Vue.createApp({
    data() {
        return {
            langheader: QB.Idcardlang.header,
            langlast: QB.Idcardlang.langlast,
            langfirst: QB.Idcardlang.langfirst,
            langsex: QB.Idcardlang.langsex,
            langdob: QB.Idcardlang.langdob,
            langnat: QB.Idcardlang.langnat,
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
        eventHandler: function(event) {
        let data = event.data;
        this.Name = data.information.name;
        this.Lastname = data.information.lastname;
        this.Dob = data.information.dob;
        this.Nationality = data.information.nationality;
        this.langsex = QB.Idcardlang.langsex;
        this.langnat = QB.Idcardlang.langnat;
        if (data.gender == 0) {
            this.Sex = 'Male'
            this.picture = 'male.png'
        }
        else if (data.gender == 1) {
            this.Sex = 'Female'
            this.picture = 'female.png'
        }
        else {
            this.Sex = 'None'
            this.picture = 'icon.png'
        }
            this.disabled = false;
            this.nui = true;
            this.show = false;
    switch (data.nui) {
        case 'idcard':
            this.langheader2 = QB.Idcard.header;
            this.background = QB.Idcard.background;
            break;
        case 'driverlicense':
            this.langheader2 = QB.Driverlicense.header;
            this.background = QB.Driverlicense.background;
            this.langsex = 'Type';
            this.Sex = 'CLASS C Driver License';
            this.langnat= '✔️ License';
            break;
        case 'weaponlicense':
            this.show = true;
            this.langheader2 = QB.Weaponlicense.header;
            this.background = QB.Weaponlicense.background;
            break;
        case 'lawyerpass':
            this.show = true;
            this.langheader2 = QB.Lawyerpass.header;
            this.background = QB.Lawyerpass.background;
            break;
        case 'policecard':
            this.langheader2 = QB.Policeidcard.header;
            this.background = QB.Policeidcard.background;
            break;
    }
    if (QB.AutoClose.close) {
        setTimeout(() => {
            this.postMessage('escape')
            this.disabled = true;
            this.nui = false;
          }, QB.AutoClose.time)
      }
        },
        postMessage: function(data) {
	   fetch(`https://${GetParentResourceName()}/${data}`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
            })
		},
        keyupHandler: function(e) {
            if (e.key == QB.CloseKey) {
                this.postMessage('escape')
                this.disabled = true;
                setTimeout(() => {
                    this.nui = false;
                  }, 500)
              }
        },
    },
    mounted(){
        window.addEventListener('message',this.eventHandler);
        document.addEventListener('keyup', this.keyupHandler);
    },
    beforeUnmount() {
        window.removeEventListener('message', this.eventHandler);
        document.removeEventListener('keyup', this.keyupHandler);
    },
}).mount('#card')
