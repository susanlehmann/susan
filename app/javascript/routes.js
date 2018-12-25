import Vue from 'vue';
import VueRouter from 'vue-router';

import UserPage from './components/user-page.vue';

Vue.use(VueRouter);

const router = new VueRouter({
	mode: 'history',
	base: '${I18n.prefix}',
	routes: [
		{ path: '/u/:id', component: UserPage, name: 'userpage_path'}
	]
});

export default router;