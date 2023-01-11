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
            Citizenid: '',
            Sex: '',
            show: false,
            nui: false,
            disabled: false,
            closeon: '',
        }
    },
    methods: {
        eventHandler: function(event) {
                let data = event.data;
                if (data.action == "open")
                {
                    this.Name = data.information.name;
                    this.Lastname = data.information.lastname;
                    this.Dob = data.information.dob;
                    this.Nationality = data.information.nationality;
                    this.Citizenid = data.information.citizenid;
                    this.langsex = QB.Idcardlang.langsex;
                    this.langnat = QB.Idcardlang.langnat;
                    if (data.information.gender == 0) {
                        this.Sex = 'Male';
                        this.picture = data.information.image;
                        if(this.picture === undefined)
                        {
                            this.picture = 'assets/img/male.png';
                        }
                    }
                    else if (data.information.gender == 1) {
                        this.Sex = 'Female';
                        this.picture = data.information.image;
                        if(this.picture === undefined)
                        {
                            this.picture = 'assets/img/female.png';
                        }
                    }
                    else {
                        this.Sex = 'None';
                        this.picture = 'icon.png';
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
                            this.langsex = 'Serial Number';
                            this.Sex = data.information.type;
                            this.langnat= 'Validity';
                            this.Nationality = data.information.date;
                            break;
                        case 'weaponlicense':
                            this.langsex = 'Type';
                            this.Sex = 'Weapon License';
                            this.langnat= 'Serial Number';
                            this.langheader2 = QB.Weaponlicense.header;
                            this.background = QB.Weaponlicense.background;
                            this.Nationality = data.information.type;
                            break;
                        case 'lawyerpass':
                            this.langheader2 = QB.Lawyerpass.header;
                            this.background = QB.Lawyerpass.background;
                            break;
                        case 'policecard':
                            this.langheader2 = QB.Policeidcard.header;
                            this.background = QB.Policeidcard.background;
                            break;
                        case 'emscard':
                            this.langheader2 = QB.Emsidcard.header;
                            this.background = QB.Emsidcard.background;
                            break;
                        case 'governmentcard':
                            this.langheader2 = QB.Govidcard.header;
                            this.background = QB.Govidcard.background;
                            break;
                        case 'judgecard':
                            this.langheader2 = QB.Dojidcard.header;
                            this.background = QB.Dojidcard.background;
                            break;
                        case 'newsidcard':
                            this.langheader2 = QB.Weazelcard.header;
                            this.background = QB.Weazelcard.background;
                            break;
                    }
                    if (QB.AutoClose.close) {
                        
                        this.closeon = setTimeout(() => {
                            this.postMessage('escape')
                            this.disabled = true;
                            this.nui = false;
                        }, QB.AutoClose.time)
                    }
                }
                else
                {
                    setTimeout(() => {
                        clearTimeout(this.closeon);
                        this.postMessage('escape')
                        this.disabled = true;
                        this.nui = false;
                    }, 1)
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
                clearTimeout(this.closeon);
                this.postMessage('escape')
                this.disabled = true;
                setTimeout(() => {
                    this.nui = false;
                  }, 500)
            }
            if (e.key == "Backspace") {
                clearTimeout(this.closeon);
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
