<template>
    <div class="interactive_box" @mousewheel="isEleview">
        <div class="setting_novel_page">
            <div class="setting_font">
                <div class="icon1" @click="setting_font_action"><svg t="1713746811598" class="icon" viewBox="0 0 1024 1024" version="1.1"
                        xmlns="http://www.w3.org/2000/svg" p-id="3313" width="30" height="30">
                        <path
                            d="M940.6208 870.254933a21.367467 21.367467 0 0 0-28.219733 3.0976c-1.390933 0.964267-8.712533 5.367467-27.818667 7.2192 3.336533-41.642667 24.968533-153.9584 47.428267-254.429866a21.316267 21.316267 0 0 0-16.170667-25.472 21.256533 21.256533 0 0 0-24.942933 14.574933c-13.704533-8.046933-48.093867-24.8832-86.6048-17.792-29.226667 5.4016-53.930667 22.920533-73.429334 52.087467-13.610667 20.352-29.738667 48.213333-43.6736 78.583466-27.1104-18.346667-57.250133-37.589333-89.685333-55.714133l-58.052267-561.314133a21.333333 21.333333 0 0 0-23.415466-19.0208c-0.0512 0-0.093867 0.0256-0.136534 0.0256a21.265067 21.265067 0 0 0-21.666133 14.208L326.7584 589.841067c-42.820267 0.0256-86.621867 6.775467-130.304 23.492266-76.6464 29.329067-113.979733 108.663467-123.3664 173.141334-8.567467 58.88 4.9408 109.917867 35.259733 133.179733 20.625067 15.8208 39.9616 20.7104 55.970134 20.7104 8.251733 0 15.616-1.297067 21.819733-3.054933 66.628267-18.952533 106.24-118.9632 110.754133-130.884267l59.758934-172.526933c61.533867 5.623467 127.889067 27.383467 200.772266 65.621333l22.801067 220.424533a21.333333 21.333333 0 1 0 42.427733-4.386133l-19.703466-190.498133a1248.913067 1248.913067 0 0 1 60.8256 38.7328c2.346667 1.595733 4.906667 2.628267 7.5264 3.182933-18.824533 52.846933-25.9072 106.9312 1.1008 138.9056 14.421333 17.083733 35.6096 25.634133 63.880533 25.634133 28.433067 0 64.136533-8.763733 107.264-26.077866 1.1776 5.6576 2.9952 7.9872 4.514133 9.8816a23.04 23.04 0 0 0 18.030934 8.7296c56.3456 0 74.3936-16.827733 79.530666-24.055467a21.2992 21.2992 0 0 0-5.000533-29.738667z m-683.8272-78.3872c-9.6256 25.275733-43.195733 93.312-82.3552 104.405334-8.302933 2.3552-21.4784 3.822933-40.106667-10.4704-17.527467-13.448533-25.173333-50.901333-19.012266-93.192534 7.287467-50.0992 36.906667-116.676267 96.392533-139.434666a311.876267 311.876267 0 0 1 100.224-20.5056l-55.1424 159.197866z m114.193067-199.3472l135.048533-389.896533 46.139733 446.122667c-55.995733-27.1616-117.316267-48.904533-181.188266-56.226134z m334.011733 285.841067c-24.942933-29.533867 12.305067-131.7888 61.3376-205.1072 12.791467-19.131733 28.0832-30.498133 45.44-33.792 30.882133-5.819733 60.5696 14.421333 60.859733 14.634667 2.705067 1.8944 5.7088 3.003733 8.772267 3.498666-22.596267 104.055467-32.989867 165.0432-36.974933 201.233067-102.493867 44.612267-131.677867 28.7232-139.434667 19.5328z"
                            :fill="set_font_fill" p-id="3314"></path>
                    </svg></div>
            </div>
            <div class="collection_novel" @click="collection_novel">
                <div class="icon1" @click="collection_novel_action"><svg t="1713747204764" class="icon" viewBox="0 0 1024 1024" version="1.1"
                        xmlns="http://www.w3.org/2000/svg" p-id="4326" width="200" height="200">
                        <path
                            d="M931.479305 1023.72653a44.607686 44.607686 0 0 1-26.473404-8.47149L511.611119 730.930682 118.216336 1015.122673a44.740053 44.740053 0 0 1-46.857924 4.103378A45.137154 45.137154 0 0 1 47.135247 979.515945V45.004787A45.004787 45.004787 0 0 1 92.140034 0h839.471638a45.004787 45.004787 0 0 1 45.004787 45.004787v933.716956a45.269521 45.269521 0 0 1-45.137154 45.004787z"
                            :fill="collection_novel_fill" p-id="4327"></path>
                        <path
                            d="M277.850962 223.83263a38.783537 38.783537 0 0 0 38.783537 38.65117h390.482708a38.783537 38.783537 0 0 0 0-77.434707h-390.482708a38.783537 38.783537 0 0 0-38.783537 38.783537zM277.850962 472.55026a38.783537 38.783537 0 0 0 38.783537 38.783537h390.482708a38.783537 38.783537 0 0 0 0-77.434707h-390.482708a38.783537 38.783537 0 0 0-38.783537 38.65117z"
                            fill="#FFFFFF" p-id="4328"></path>
                    </svg></div>
                <div class="action" :style="{opacity:action_opacity1,transform: `translateY(${setting_font_action_add1}px)`}"><span>{{coll_text}}</span></div>
            </div>
            <div class="action" :style="{opacity:action_opacity,transform: `translateY(${setting_font_action_add}px)`}"><span>达令~是想要设置字体吗？
            </span></div>
        </div>
        <div class="user_interactive">
            <div class="user_like" @click="user_like">
                <div class="icon1" @click="user_like_action"><svg data-v-f55d67da="" t="1713703776168" class="icon" viewBox="0 0 1024 1024"
                        version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="42200" width="200" height="200">
                        <path data-v-f55d67da=""
                            d="M0 0m365.714286 0l292.571428 0q365.714286 0 365.714286 365.714286l0 292.571428q0 365.714286-365.714286 365.714286l-292.571428 0q-365.714286 0-365.714286-365.714286l0-292.571428q0-365.714286 365.714286-365.714286Z"
                            :fill="user_like_fill" opacity=".1" p-id="42201"></path>
                        <path data-v-f55d67da=""
                            d="M219.428571 512a292.571429 292.571429 0 1 0 292.571429-292.571429 292.571429 292.571429 0 0 0-292.571429 292.571429z"
                            :fill="user_like_fill" p-id="42202"></path>
                        <path data-v-f55d67da=""
                            d="M573.202286 664.027429a26.916571 26.916571 0 0 0 32.164571 14.025142c13.202286-5.485714 26.313143-11.209143 39.387429-16.914285 18.285714-7.954286 36.717714-15.378286 54.564571-24.082286a59.428571 59.428571 0 0 0 15.067429-96.237714 57.984 57.984 0 0 0-63.030857-13.001143c-1.517714 0.530286-2.980571 1.115429-3.913143 1.481143a185.6 185.6 0 0 0-11.794286-17.170286 59.721143 59.721143 0 0 0-92.854857 3.803429 58.24 58.24 0 0 0-6.692572 60.141714l37.12 87.954286z"
                            fill="#FFFFFF" p-id="42203"></path>
                        <path data-v-f55d67da=""
                            d="M535.954286 678.326857l-36.955429-89.216a94.793143 94.793143 0 0 1 10.569143-94.281143 91.538286 91.538286 0 0 1 144.292571-5.796571l0.859429 1.042286a92.946286 92.946286 0 0 1 12.8-0.841143 113.536 113.536 0 0 0-15.104-110.208 112.219429 112.219429 0 0 0-176.512-7.314286 359.222857 359.222857 0 0 0-22.436571 33.298286c-1.828571-0.676571-4.571429-1.828571-7.424-2.870857a108.708571 108.708571 0 0 0-119.826286 25.197714 116.242286 116.242286 0 0 0 28.635428 186.404571c33.956571 16.841143 69.101714 31.232 103.753143 46.610286 24.905143 11.081143 49.755429 22.253714 74.971429 32.804571a34.304 34.304 0 0 0 12.909714 2.011429 54.619429 54.619429 0 0 1-10.514286-16.804571z"
                            fill="#FFFFFF" p-id="42204"></path>
                    </svg></div>
                    <div class="action" :style="{opacity:action_opacity2,transform: `translateY(${setting_font_action_add2}px)`}"><span>{{user_like_text}}</span></div>
            </div>
            <div class="user_collection" @click="user_collection">
                <div class="icon1" @click="user_collection_action"><svg data-v-f55d67da="" t="1713703954974" class="icon" viewBox="0 0 1024 1024"
                        version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="42367" width="200" height="200">
                        <path data-v-f55d67da=""
                            d="M944.533 142.03c-105.956-106.183-279.339-106.183-385.295 0L512 189.369l-47.238-47.339c-105.956-106.183-279.339-106.183-385.295 0-105.956 106.183-95.699 270.606 0 386.119C177.133 646.035 512 961.607 512 961.607s334.867-315.572 432.533-433.458c95.699-115.512 105.956-279.936 0-386.119zM132.118 322.844c-3.52-38.671 9.516-78.565 39.12-108.169s69.498-42.64 108.169-39.12c-31.833 13.746-61.654 33.616-87.663 59.626s-45.881 55.831-59.626 87.663z m115.363-31.925c-15.886 15.886-28.023 34.1-36.419 53.543-2.15-23.62 5.812-47.986 23.894-66.068 18.082-18.082 42.449-26.044 66.068-23.894-19.442 8.395-37.657 20.532-53.543 36.419z"
                            :fill="user_collection_fill" p-id="42368"></path>
                    </svg></div>
                    <div class="action" :style="{opacity:action_opacity3,transform: `translateY(${setting_font_action_add3}px)`}"><span>{{user_collection_text}}</span></div>
            </div>
            <div class="user_share">
                <div class="icon1"><svg t="1713748225543" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="7045" width="200" height="200"><path d="M543.503059 102.068706l-2.831059 530.55247a30.117647 30.117647 0 0 1-60.235294-0.301176l2.800941-528.715294-160.768 160.768a30.117647 30.117647 0 0 1-42.586353-42.586353L492.845176 8.824471a30.117647 30.117647 0 0 1 42.586353 0l212.961883 212.961882a30.117647 30.117647 0 1 1-42.586353 42.586353l-162.334118-162.334118zM708.306824 391.529412a30.117647 30.117647 0 0 1 0-60.235294H873.411765a60.235294 60.235294 0 0 1 60.235294 60.235294v572.235294a60.235294 60.235294 0 0 1-60.235294 60.235294H150.588235a60.235294 60.235294 0 0 1-60.235294-60.235294V391.529412a60.235294 60.235294 0 0 1 60.235294-60.235294h163.056941a30.117647 30.117647 0 0 1 0 60.235294H150.588235v572.235294h722.82353V391.529412h-165.104941z" fill="#7F7F7F" p-id="7046"></path></svg></div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { ref } from 'vue'
export default {
    name: 'interactive_box',
    data(){
        return {
            set_font_fill:'#969696',
            collection_novel_fill:'#ff717e',
            user_like_fill:'#FF5C64',
            user_collection_fill:'#4C4C4C',
        }
    },
    methods:{
        collection_novel(){
            this.isEleview();
            if(this.collection_novel_fill=='#ff717e'){
                this.collection_novel_fill='#bdbdbd';
            }
            else{
                this.collection_novel_fill='#ff717e';
            }
        },
        user_like(){
            if(this.user_like_fill=='#FF5C64'){
                this.user_like_fill='#bdbdbd';
            }
            else{
                this.user_like_fill='#FF5C64';
            }
        },
        user_collection(){
            if(this.user_collection_fill=='#4C4C4C'){
                this.user_collection_fill='#FF5C64';
            }
            else{
                this.user_collection_fill='#4C4C4C';
            }
        },
        isEleview(){
            var main_page=document.querySelector('.interactive_box');
           
            //获取主窗口高度
            var root_hight=window.innerHeight;
            var sub_hight=main_page?.getBoundingClientRect().top;
           
        },
    },
   mounted(){
    
    this.isEleview();
   },
}
</script>


<script setup lang="ts">

//一些动画效果的实现
let setting_font_action_add=ref(-100);
let action_opacity=ref(0);
function setting_font_action() {
    setting_font_action_add.value=-100;
    action_opacity.value=1;
    const intervalId = setInterval(() => {
        // 每50毫秒减小setting_font_action_add和action_opacity的值
        setting_font_action_add.value -= 2;
        action_opacity.value -= 0.05;

        // 满足条件时停止动画
        if (setting_font_action_add.value <= -200 || action_opacity.value <= 0) {
            clearInterval(intervalId); // 停止间隔循环
        }
    }, 50);
}
let setting_font_action_add1=ref(-100);
    let action_opacity1=ref(0);
    let coll_text=ref('感谢达令的收藏呢~');
function collection_novel_action(){
    setting_font_action_add1.value=-70;
    action_opacity1.value=1;
    if(coll_text.value=='感谢达令的收藏呢~'){
        coll_text.value='达令是认为有什么做的不好吗？伦家会努力改正的！';
    }
    else{
        coll_text.value='感谢达令的收藏呢~';
    }
   
    const intervalId = setInterval(() => {
        setting_font_action_add1.value-=2;
        action_opacity1.value-=0.05;
        if (setting_font_action_add1.value <= -170 || action_opacity1.value <= 0) {
            clearInterval(intervalId); // 停止间隔循环
        }
    }, 50);
}
let action_opacity2=ref(0);
let setting_font_action_add2=ref(-100);
let user_like_text=ref('感谢达令的点赞呢~');
function user_like_action(){
    setting_font_action_add2.value=-70;
    action_opacity2.value=1;
    if(user_like_text.value=='感谢达令的点赞呢~'){
        user_like_text.value='达令是认为有什么做的不好吗？伦家会努力改正的！';
    }
    else{
        user_like_text.value='感谢达令的点赞呢~';
    }
    const intervalId = setInterval(() => {
        setting_font_action_add2.value-=2;
        action_opacity2.value-=0.05;
        if (setting_font_action_add2.value <= -170 || action_opacity2.value <= 0) {
            clearInterval(intervalId); // 停止间隔循环
        }
    }, 50);
}
let user_collection_text=ref('感谢达令的喜欢呢~');
let action_opacity3=ref(0);
let setting_font_action_add3=ref(-100);
function user_collection_action(){
    setting_font_action_add3.value=-70;
    action_opacity3.value=1;
    if(user_collection_text.value=='感谢达令的喜欢呢~'){
        user_collection_text.value='如果达令不喜欢也记得喜欢自己哦~';
    }
    else{
        user_collection_text.value='感谢达令的喜欢呢~';
    }
    const intervalId = setInterval(() => {
        setting_font_action_add3.value-=2;
        action_opacity3.value-=0.05;
        if (setting_font_action_add3.value <= -170 || action_opacity3.value <= 0) {
            clearInterval(intervalId); // 停止间隔循环
        }
    }, 50);
}

</script>

<style scoped>
.action{
    position: absolute;
    bottom: 0px;
    left:20px;
    width:100px;
    height: auto;
    align-self: center;
    opacity: 0;
    color:#f889fc;
}
.user_interactive{
    display: flex;
    width:200px;
    padding:5px;
    justify-content: center;
    height: 100%;
    align-items: center;
}
.user_like,.user_collection,.user_share{
    width:30px;
    height: 30px;
    margin-left:10px;
    margin-right: 10px;
    position: relative;
}
.interactive_box {
    width: 85%;
    height: 60px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    align-self: center;
    margin: 0 auto;
    background-color: rgb(245, 245, 245);
}

.setting_novel_page {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 110px;
    height: 100%;
    position: relative;
}

.setting_font {
    display: flex;
    width: 30px;
    height: 30px;
    align-items: center;
    align-self: center;
    margin-left: 10px;
    margin-right: 10px;
}

.collection_novel {
    display: flex;
    width: 30px;
    height: 30px;
    align-items: center;
    align-self: center;
    margin-left: 10px;
    margin-right: 10px;
    position: relative;
}

.icon1 {
    width: 30px;
    height: 30px;
    overflow: hidden;
}
.icon1 svg{
    width:30px;
    height: 30px;
    object-fit: cover;
}

.icon1:hover {
    width: 100%;
    height: 100%;
    object-fit: cover;
    cursor: pointer;
    background-color: rgba(188,188,188,0.5);
    border-radius: 50%;
    transition:0.2s;
}

</style>