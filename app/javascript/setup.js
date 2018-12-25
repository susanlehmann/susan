import "babel-polyfill";

import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';
import VueObserveVisibility from 'vue-observe-visibility';
import {Tabs, Tab} from 'vue-tabs-component';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

Vue.use(VueObserveVisibility);
Vue.use(BootstrapVue);
Vue.component('tabs', Tabs);
Vue.component('tab', Tab);

import FollowButton from './components/follow-button.vue';
Vue.component('follow-button', FollowButton);

import Message from './components/message.vue';
Vue.component('message', Message);

import UserCard from './components/user-card.vue';
Vue.component('user-card', UserCard);

import UserInfo from './components/user-info.vue';
Vue.component('user-info', UserInfo);

import Demo from './components/demo.vue';
Vue.component('demo', Demo);

import Image from './components/image.vue';
Vue.component('image', Image);

import MessagesList from './components/messages-list.vue';
Vue.component('messages-list', MessagesList);

import SendBlobloButton from './components/send-bloblo-button.vue';
Vue.component('send-bloblo-button', SendBlobloButton);

import SendTipModal from './components/send-tip-modal.vue';
Vue.component('send-tip-modal', SendTipModal);

import MessageBody from './components/message-body.vue';
Vue.component('message-body', MessageBody);

import UploadWizard from './components/upload-wizard.vue';
Vue.component('upload-wizard', UploadWizard);

import Alerts from './components/alerts.vue';
Vue.component('alerts', Alerts);

import CheckNetwork from './components/check-network.vue';
Vue.component('check-network', CheckNetwork);

import Common from './components/common.vue';
Vue.component('common', Common);

import Batch from './components/batch.vue';
Vue.component('batch', Batch);

import AlertsMixin from './components/mixins/alert-mixins';
Vue.mixin(AlertsMixin);

import Notifications from 'vue-notification';
Vue.use(Notifications);