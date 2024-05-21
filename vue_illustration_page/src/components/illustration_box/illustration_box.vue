<template>
    <div class="illustration_box">
        <div class="ill_image">
            <img >
        </div>
        <div class="ill_data">

        </div>
        <div class="float_ill_data">

        </div>
        <div class="work_info">
            <div class="work_title"></div>
            <div class="work_brief_introduction"></div>
            <div class="work_details"></div>
            <div class="tags">
                <span class="age_tag"></span>
                <span class="work_tag"></span>
            </div>
            <div class="interactive"></div>
            <div class="creat_time"></div>
        </div>
        <div class="user_work_list">
            <div class="user_info">
                <div class="user_avatar"></div>
                <div class="username"></div>
                <div class="following_btn"></div>
            </div>
            <div class="work_list">
                <div class="work_item">
                    <div class="item_img">
                        <img>
                    </div>
                    <div class="like_svg">
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import {ref,onMounted,onUnmounted,watch,reactive} from 'vue'
export default{
    name:'illustration_box',
    components:{

    },
}
</script>

<script setup>

</script>

<style scoped>
    .illustration_box{
        display: flex;
        width: 80%;
        height: auto;
    }
</style>