<!--
 * @Description: 
 * @Author: 
 * @Date: 2024-03-04 15:31:03
-->
<!--侧边菜单栏组件-->
<template>
    <el-menu
            background-color="#6495ED"
            text-color="white"
            active-text-color="lightgrey"
            style="height: 100%;"
            default-active="/Home"
            :collapse="isCollapse"
            :collapse-transition="false"
            router
    >
       <el-menu-item >
           <span slot="title" style="font-size: 22px;"><b>春镭激光</b></span>
       </el-menu-item>
       <el-menu-item index="/Home" style="font-size: 16px;">
           <i class="iconfont icon-r-home" style="color: white;font-size: 26px;"></i>
           <span slot="title"><b> 首页</b></span>
       </el-menu-item>
       <el-menu-item index="/Profile" style="font-size: 16px;">
           <i class="iconfont icon-r-love" style="color: white;font-size: 26px;"></i>
           <span slot="title"><b> 个人中心</b></span>
       </el-menu-item>

       <!--动态获取菜单-->
        <el-menu-item :index="'/'+item.menuclick" v-for="(item,i) in menu" :key="i" style="font-size: 16px;">
            <i :class="item.menuicon" style="color: white;font-size: 26px;"></i>
            <span slot="title"><b> {{item.menuname}}</b></span>
        </el-menu-item>

    </el-menu>
</template>

<script>
    export default {
        name: "Aside",
        data(){
            return {
                
            }
        },
        computed:{
            "menu":{
                get(){
                    return this.$store.state.menu
                }
            }
        },
        props:{
            isCollapse:Boolean  //导航栏菜单伸缩
        }
    }
</script>

<style scoped>

</style>