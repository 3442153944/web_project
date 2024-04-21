<template>
  <div class="box_content">
    <div class="novel_cover">
        <img :src="novel_cover_src">
    </div>
    <div class="novel_info">
        <div class="author_say mt "><span>{{author_say}}</span></div>
        <div class="work_title mt "><span><b>{{work_title}}</b></span></div>
        <div class="work_info mt "><span>{{work_info_num}}字&nbsp;&nbsp;{{work_info_readtime}}分钟</span></div>
        <div class="author_say mt "><span>{{author_say_1}}</span></div>
        <div class="work_tag mt "><span style="color:red;font-weight:bold;">{{age_classification}}&nbsp;</span><span v-for="(tag , index) in work_tag" :key="index" style="color:rgb(0,150,250);">#{{tag}}&nbsp;&nbsp;</span></div>
        <div class="novel_data mt ">
            <div class="novel_data_icon"><svg t="1713703776168" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="42200" width="200" height="200"><path d="M0 0m365.714286 0l292.571428 0q365.714286 0 365.714286 365.714286l0 292.571428q0 365.714286-365.714286 365.714286l-292.571428 0q-365.714286 0-365.714286-365.714286l0-292.571428q0-365.714286 365.714286-365.714286Z" fill="#FF5C64" opacity=".1" p-id="42201"></path><path d="M219.428571 512a292.571429 292.571429 0 1 0 292.571429-292.571429 292.571429 292.571429 0 0 0-292.571429 292.571429z" fill="#FF5C64" p-id="42202"></path><path d="M573.202286 664.027429a26.916571 26.916571 0 0 0 32.164571 14.025142c13.202286-5.485714 26.313143-11.209143 39.387429-16.914285 18.285714-7.954286 36.717714-15.378286 54.564571-24.082286a59.428571 59.428571 0 0 0 15.067429-96.237714 57.984 57.984 0 0 0-63.030857-13.001143c-1.517714 0.530286-2.980571 1.115429-3.913143 1.481143a185.6 185.6 0 0 0-11.794286-17.170286 59.721143 59.721143 0 0 0-92.854857 3.803429 58.24 58.24 0 0 0-6.692572 60.141714l37.12 87.954286z" fill="#FFFFFF" p-id="42203"></path><path d="M535.954286 678.326857l-36.955429-89.216a94.793143 94.793143 0 0 1 10.569143-94.281143 91.538286 91.538286 0 0 1 144.292571-5.796571l0.859429 1.042286a92.946286 92.946286 0 0 1 12.8-0.841143 113.536 113.536 0 0 0-15.104-110.208 112.219429 112.219429 0 0 0-176.512-7.314286 359.222857 359.222857 0 0 0-22.436571 33.298286c-1.828571-0.676571-4.571429-1.828571-7.424-2.870857a108.708571 108.708571 0 0 0-119.826286 25.197714 116.242286 116.242286 0 0 0 28.635428 186.404571c33.956571 16.841143 69.101714 31.232 103.753143 46.610286 24.905143 11.081143 49.755429 22.253714 74.971429 32.804571a34.304 34.304 0 0 0 12.909714 2.011429 54.619429 54.619429 0 0 1-10.514286-16.804571z" fill="#FFFFFF" p-id="42204"></path></svg></div>
            <span>{{like_num}}</span>
            <div class="novel_data_icon"><svg t="1713703954974" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="42367" width="200" height="200"><path d="M944.533 142.03c-105.956-106.183-279.339-106.183-385.295 0L512 189.369l-47.238-47.339c-105.956-106.183-279.339-106.183-385.295 0-105.956 106.183-95.699 270.606 0 386.119C177.133 646.035 512 961.607 512 961.607s334.867-315.572 432.533-433.458c95.699-115.512 105.956-279.936 0-386.119zM132.118 322.844c-3.52-38.671 9.516-78.565 39.12-108.169s69.498-42.64 108.169-39.12c-31.833 13.746-61.654 33.616-87.663 59.626s-45.881 55.831-59.626 87.663z m115.363-31.925c-15.886 15.886-28.023 34.1-36.419 53.543-2.15-23.62 5.812-47.986 23.894-66.068 18.082-18.082 42.449-26.044 66.068-23.894-19.442 8.395-37.657 20.532-53.543 36.419z" fill="#4C4C4C" p-id="42368"></path></svg></div>
            <span>{{love_num}}</span>
            <div class="novel_data_icon"><svg t="1713703979895" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="43387" width="200" height="200"><path d="M512 188.2c-266.7 0-482.9 145-482.9 323.8S245.3 835.8 512 835.8s482.9-145 482.9-323.8S778.7 188.2 512 188.2z m0 545.4c-122.4 0-221.6-99.2-221.6-221.6 0-122.4 99.2-221.6 221.6-221.6S733.6 389.6 733.6 512c0 122.4-99.2 221.6-221.6 221.6z" p-id="43388"></path><path d="M512 512m-136.3 0a136.3 136.3 0 1 0 272.6 0 136.3 136.3 0 1 0-272.6 0Z" p-id="43389"></path></svg></div>
            <span>{{look_num}}</span>
        </div>
        <div class="novel_update"><span>{{update_time}}</span></div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'novel_content_box',
}
</script>

<script setup>
let novel_cover_src=ref('../../../image/87328997_p0.jpg');
let author_say=ref('杂事、闲扯、设定集 #10');
let work_title=ref('一些新系列的想法，不知道大家对于阴暗系主角的接受度如何');
let work_info_num=ref('1000');
let work_info_readtime=ref('10');
let author_say_1=ref('大家喜欢阴暗系反派主角吗？');
let age_classification=ref('R-18');
let work_tag=ref({
    'tag1':'中文/中国语/Chinese/中國語/中国語',
    'tag2':'公告',
    'tag3':'萝莉',
    'tag4':'凌辱',
    'tag5':'tag5',
    'tag6':'tag6',
    'tag7':'tag7',
    'tag8':'tag8',
    'tag9':'tag9',
    'tag10':'tag10',
});
let like_num=ref('100');
let love_num=ref('100');
let look_num=ref('100');
let update_time=ref('2024年4月21日20:55:27');
</script>

<style scoped>
/*通用样式*/
.mt{margin-top:5px;}
.mb{margin-bottom:5px;}
.ml{margin-left:5px;}
.mr{margin-right:5px;}
.pt{padding-top:5px;}
.pb{padding-bottom:5px;}
.pl{padding-left:5px;}
.pr{padding-right:5px;}
  .box_content{
    display: flex;
    width:100%;
    height:220px;
    position: relative;
    border-bottom:1px solid rgb(230, 230, 230);
  }
  .novel_cover{
    width:20%;
    height:210px;
    display: flex;
    position: relative;
    overflow: hidden;
    justify-content: center;
    align-items: center;
    margin-top:auto;
    margin-bottom: auto;
  }
  .novel_cover img{
    width:100%;
    height: 100%;
    object-fit: cover;
    margin-left:5px;
    margin-right: 5px;
  }
  .novel_info{
    display: flex;
    flex-direction: column;
    width:80%;
    min-height: 150px;
    height: auto;
    padding: 5px;
    margin-left:5px;
    margin-right: 5px;
  }
  .novel_data{
    display: flex;
    width:100%;
    height: 35px;
    margin-top:10px;
  }
  .novel_data_icon{
    width:25px;
    height: 25px;
    overflow: hidden;
    margin-right: 10px;
    margin-left:10px;
  }
  .novel_data_icon svg{
    width:100%;
    height: 100%;
    object-fit: cover;
  }
</style>