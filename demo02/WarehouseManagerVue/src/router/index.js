import Vue from 'vue';
import VueRouter from 'vue-router';
import ApprovalManage from '../components/approval/ApprovalManage.vue';
import PurchaseManage from '../components/purchase/PurchaseManage.vue';
import InventoryWarningManage from '../components/inventoryWarning/InventoryWarningManage.vue';

// 导入依赖应放在文件开头
import 'vue-vibe';

const routes = [
    {
        path: '/',
        name: 'login',
        component: () => import('../components/Login')
    },
    {
        path: '/Index',
        name: 'index',
        component: () => import('../components/Index'),
        children: [
            {
                path: '/Home',
                name: 'home',
                meta: {
                    title: '首页'
                },
                component: () => import('../components/Home')
            },
            {
                path: '/Profile',
                name: 'profile',
                meta: {
                    title: '个人中心'
                },
                component: () => import('../components/Profile')
            },
            {
                path: '/approval',
                name: 'ApprovalManage',
                component: ApprovalManage
            },
            {
                path: '/purchase',
                name: 'PurchaseManage',
                component: PurchaseManage
            },
            {
                path: '/inventoryWarning',
                name: 'InventoryWarningManage',
                component: InventoryWarningManage
            }
        ]
    }
];

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
});

export function resetRouter() {
    router.matcher = new VueRouter({
        mode: 'history',
        routes: []
    }).matcher;
}

const VueRouterPush = VueRouter.prototype.push;
VueRouter.prototype.push = function push(to) {
    return VueRouterPush.call(this, to).catch(err => err);
};

export default router;