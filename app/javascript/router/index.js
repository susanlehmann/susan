import Router from "vue-router";

Vue.use(Router);

export default new Router({
	routes: [
		{
			path: "/u/${username}",
			component: () => import("@/components/user-info"),
			children:[
				{
					path: "",
					name: "profile",
					component: () => import("@/components/message-list")
				},
				{
					name: "profile-favorites",
					name: "favorites"
					component: () => import("@/components/message-list")
				}
			]
		}
	]
});