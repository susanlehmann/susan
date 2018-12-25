import '../setup';
import Vue from 'vue';

import VueI18n from 'vue-i18n';
import router from '../routes.js';

import UserPage from '../components/user-page.vue';

$.ajaxPrefilter(function( options){
	options.url = '/${I18n.prefix}api/${options.url}';
})

Vue.use(VueI18n);
const i18n = new VueI18n({
	locale: 'current',
	messages: translations
})

document.addEventListener('DOMContentLoaded', () => {
  const json = document.getElementById('js-user').getAttribute('data');
  const data = JSON.parse(json);
  console.log(data);	  
  const app = new Vue({
  	i18n,
  	router,
    render: h => h(UserPage, { props: { messages: data.messages, account: data.account } })
  }).$mount('#js-user');
})