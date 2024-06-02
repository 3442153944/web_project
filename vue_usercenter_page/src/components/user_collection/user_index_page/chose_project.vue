<template>
    <div class="chose_project">
        <div class="content_box">
            <div class="title_box">
                <span></span>
                <h3>选择项目</h3>
                <div class="close_btn" @click="chose_close_btn_click()">
                    <img class="icon" :src="close_btn_path">
                </div>
            </div>
            <div class="switch_tag">
                <div class="tag_item" @click="switch_page(0)"><span>插画·漫画</span></div>
                <div class="tag_item" @click="switch_page(1)"><span>小说</span></div>
                <div class="tag_item" @click="switch_page(2)"><span>约稿</span></div>
            </div>
            <div class="ill_page">
                <div class="item_img" v-for="(item, index) in ill_list" :key="index">
                    <img :src="item" class="ill_img">
                    <div class="select_ill_btn" @click="switch_ill_correct_status(index)">
                        <img :src="correct_svg_path" class="icon">
                    </div>
                    <span style="display:none;" id="ill_id">{{ ill_id_list[index] }}</span>
                </div>
            </div>
            <div class="novel_page">
                <div class="series_box">
                    <h3>系列</h3>
                    <div class="series_list">
                        <div class="series_item" v-for="(item, index) in series_list" :key="index">
                            <div class="series_title">
                                <span style="font-size:18px;font-weight:bold" class="list_series_name">{{ item }}</span>
                                <div class="select_btn" @click="swich_correct_status(index)">
                                    <img class="icon" :src="correct_svg_path">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="series_list_count">
                        <span>共{{ series_list.length }}个系列作品</span>
                    </div>
                </div>
                <h3>作品</h3>
                <div class="work_list">
                    <div class="work_item" v-for="(item, index) in back_novel_series_list" :key="index">
                        <div class="work_cover">
                            <img class="cover_img" :src="item.work_cover" alt="">
                        </div>
                        <div class="work_name">
                            <span>{{ item.work_name }}</span>
                            <span id="novel_series">{{ item.work_series }}</span>
                        </div>
                        <div class="select_btn_work" @click="switch_work_correct_status(index)">
                            <img class="icon" :src="correct_svg_path">
                        </div>
                        <span style="display:none;" id="novel_work_id">{{ novel_work_id_list[index] }}</span>
                    </div>
                </div>
            </div>
            <div class="invited_draft">
                <div class="screen_box">
                    <div class="screen_title">
                        <span>筛选约稿状态</span>
                    </div>
                    <div class="screen_content" @click="screen_invited_draft_list()">
                        <rewrite_select
                        :select_title="rewrite_select_title"
                        :select_list="rewrite_select_list"
                        @select-item="set_input_list"
                        class="invited_draft_status"
                        >
                        </rewrite_select>
                    </div>
                </div>
                <div class="invited_draft_list">
                    <div class="invited_draft_item" v-for="(item, index) in back_invited_draft_list" :key="index">
                        <div class="invited_draft_info">
                            <span>发起人：{{ item.launch_user }}</span>
                            <span>标题：{{ item.work_title }}</span>
                            <span id="invited_draft_status">状态：{{ item.working_condition }}</span>
                            <span>简介：{{ item.work_brief_introduction }}</span>
                        </div>
                        <div class="invited_draft_cover">
                            <img class="invited_draft_cover_img" :src="invited_draft_cover_list[index]">
                        </div>
                    </div>
                </div>
            </div>
            <div class="btn_box">
                <div class="save_btn" @click="save_operation()"><span>保存</span></div>
                <div class="cancel_btn" @click="chose_close_btn_click()"><span>取消</span></div>
            </div>
        </div>
    </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted, defineEmits } from 'vue';
import { set_cookie, expireCookie, get_cookie, set_storage, get_storage } from '../../../../../model/cookies'
import rewrite_select from '../../select/select.vue'
export default {
    name: 'chose_project',
    components: {
        rewrite_select
    },
}
</script>

<script setup>
let emit = defineEmits(['chose_close_btn_click']);
let server_ip = 'https://127.0.0.1:4434/'
let close_btn_path = ref(server_ip + 'assets/close.svg');
let ill_image_path = ref(server_ip + 'image/65014220_p0.jpg')
let work_id = ref('1')
let user_id = ref('f575b4d3-0683-11ef-adf4-00ffc6b98bdb');
let user_name = ref('admin');
set_cookie('user_id', user_id.value);
set_cookie('user_name', user_name.value);
let work_info = ref([])
let correct_svg_path = ref(server_ip + 'assets/correct.svg');
let select_correct_svg_path = ref(server_ip + "assets/select_correct.svg")

//设置列表框标题
let rewrite_select_title=ref('选择约稿作品状态')
//设置列表项
let rewrite_select_list=ref(['全部','未审核','审核通过','审核未通过','待接取','进行中','未完成','已完成'])
//接收子组件传入的列表项
let select_input_list=ref('全部');
function set_input_list(list){
    select_input_list.value=list
}


//点击切换选中状态
function swich_correct_status(index) {
    let temp = document.querySelectorAll('.select_btn img');
    let path = temp[index].src;
    if (path == correct_svg_path.value) {
        temp[index].src = select_correct_svg_path.value;
    }
    else {
        temp[index].src = correct_svg_path.value;
    }
    switch_series();
    setTimeout(() => {
        set_novel_select_status();
    },50)
    
}

//根据选择的系列来显示相应系列的作品
let work_list = ref([]);
function set_work_list(index) {

}

function switch_work_correct_status(index) {
    let temp = document.querySelectorAll('.select_btn_work img');
    let path = temp[index].src;
    if (path == correct_svg_path.value) {
        if (count_correct_status()) {
            temp[index].src = select_correct_svg_path.value;
        }
        else {
            temp[index].src = correct_svg_path.value;
            return;
        }
    }
    else {
        temp[index].src = correct_svg_path.value;
    }
}
function switch_ill_correct_status(index) {
    let temp = document.querySelectorAll('.select_ill_btn img')
    let path = temp[index].src
    if (path == correct_svg_path.value) {
        if (count_correct_status()) {
            temp[index].src = select_correct_svg_path.value;
        }
        else {
            temp[index].src = correct_svg_path.value;
            return;
        }
    }
    else {
        temp[index].src = correct_svg_path.value;
    }
}

//获取小说作品的信息
async function get_novel_info() {
    try {
        let res = await fetch('api/get_work_info', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                user_id: user_id.value,
                user_name: user_name.value,
            })
        })
        const data = await res.json()
        if (data.status == "success") {
            work_info.value = data.data;
            set_novel_series_list();
        }
        else {
            console.log('error')
        }
    }
    catch (err) {
        console.log(err)
    }
}

onMounted(() => {
    get_novel_info();
})
//传递关闭消息
function chose_close_btn_click() {
    emit('chose_close_btn_click', false);
}

//切换子页面
function switch_page(index) {
    var page = document.querySelectorAll('.tag_item');
    let temp = document.querySelector('.ill_page');
    let temp2 = document.querySelector('.novel_page');
    let temp3 = document.querySelector('.invited_draft');
    switch (index) {
        case 0:
            page[0].style.backgroundColor = 'rgba(133,133,133,0.5)';
            page[1].style.backgroundColor = '';
            page[2].style.backgroundColor = '';
            temp.style.display = '';
            temp2.style.display = 'none';
            temp3.style.display = 'none';
            break;
        case 1:
            page[0].style.backgroundColor = '';
            page[1].style.backgroundColor = 'rgba(133,133,133,0.5)';
            page[2].style.backgroundColor = '';
            temp.style.display = 'none';
            temp2.style.display = '';
            temp3.style.display = 'none';
            break;
        case 2:
            page[0].style.backgroundColor = '';
            page[1].style.backgroundColor = '';
            page[2].style.backgroundColor = 'rgba(133,133,133,0.5)';
            temp.style.display = 'none';
            temp2.style.display = 'none';
            temp3.style.display = '';
            break;
    }
}
onMounted(() => {
    switch_page(0);
});

//获取系列列表
let series_list = ref([]);
function set_series_list() {
    let temp = work_info.value;
    for (let i = 0; i < temp.length; i++) {
        series_list.value.push(temp[i].work_series)
    }
}
//获取作品封面地址列表
let work_cover_list = ref([]);
let work_name_list = ref([]);
let novel_work_id_list = ref([]);
function set_work_cover_list() {
    let temp = work_info.value;
    for (let i = 0; i < temp.length; i++) {
        work_cover_list.value.push(server_ip + "image/" + temp[i].work_cover)
        work_name_list.value.push(temp[i].work_name)
    }
    novel_work_id_list.value = temp.map(item => item.work_id)
}
//设置系列作品列表
let novel_series_list = ref([]);
let back_novel_series_list = ref([{
    work_id:null,
    work_name:null,
    work_cover:null,
    work_series:null,
}]);
function set_novel_series_list() {
    let temp = work_info.value;
    //获取系列列表
    let series_list = []
    for (let i = 0; i < temp.length; i++) {
        series_list.push(temp[i].work_series)
        //获取作品信息集合
        let work_info = {
            work_id: temp[i].work_id,
            work_name: temp[i].work_name,
            work_cover: server_ip + "image/" + temp[i].work_cover,
            work_series: temp[i].work_series,
        }
        novel_series_list.value.push(work_info)
    }
}
//按系列筛选作品，可以多选系列
function switch_series() {
    const temp = document.querySelectorAll('.list_series_name');
    const status = document.querySelectorAll('.select_btn img');
    const select_status_list = Array.from(status).reduce((acc, item, index) => {
        if (item.src === select_correct_svg_path.value) {
            acc.push(temp[index].textContent);
        }
        return acc;
    }, []);
    const result = novel_series_list.value.filter(work => 
        select_status_list.includes(work.work_series)
    );
    back_novel_series_list.value = result;
}

onMounted(() => {
    setTimeout(() => {
        set_series_list();
        set_work_cover_list();
        get_ill_list();
        get_invited_draft_list();
    }, 100)
    setTimeout(() => {
        set_ill_list();
        switch_series();
    }, 200);
})

//获取用户的插画或漫画作品列表
let ill_list = ref([]);
let ill_id_list = ref([]);
let ill_info_list = ref([]);
async function get_ill_list() {
    try {
        let res = await fetch('api/get_user_IllWork_list', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                user_id: get_cookie('user_id'),
                user_name: get_cookie('user_name'),
            })
        })
        const data = await res.json()
        if (data.status == 'success') {
            ill_info_list.value = data.data;
            set_storage('ill_info_list', JSON.stringify(data.data));
        }
    }
    catch (err) {
        console.log(err)
    }
}
//设置作品列表
function set_ill_list() {
    let temp = get_storage('ill_info_list');
    let temp2 = [];
    let file_list = [];
    if (temp != null) {
        temp2 = JSON.parse(temp);
    }
    for (let i = 0; i < temp2.length; i++) {
        let temp3 = temp2[i].content_file_list.split(',');
        //获取作品中第一个图片文件地址
        if(temp3.length>0)
        {
            file_list.push(server_ip + 'image/' + temp3[0]);
        }
        /*for (let j = 0; j < temp3.length; j++) {
            file_list.push(server_ip + 'image/' + temp3[j]);
        }*/
    }
    ill_list.value = file_list;
    ill_id_list.value = temp2.map(item => item.Illustration_id);
}

//保存操作
function save_operation() {
    //向服务器通信，保存选中的信息
    get_select_work_list();
    //关闭弹窗
    chose_close_btn_click();
}
//请求约稿信息
let invited_draft_list = ref([]);
let back_invited_draft_list=ref([]);
async function get_invited_draft_list() {
    try {
        let res = await fetch('api/AuthorGetInvitedDraftAllInfo', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                request_user: 'author',
                username: get_cookie('user_name'),
                user_id: get_cookie('user_id'),
            })
        })
        let data = await res.json()
        if (data.status == 'success') {
            invited_draft_list.value = data.data;
            set_invited_draft_cover_list();
        }
        else if (data.status == 'error') {
            console.log('error')
        }
    }
    catch (err) {
        console.log(err)
    }
}
//获取约稿作品中内容列表中的第一个内容的地址
let invited_draft_cover_list = ref([]);
function set_invited_draft_cover_list() {
    let temp = invited_draft_list.value;
    for (let i = 0; i < temp.length; i++) {
        let temp2 = temp[i].work_file_list.split(',');
        if (temp2.length > 0) {
            invited_draft_cover_list.value.push(server_ip + 'image/' + temp2[0]);
        }
    }
}

//筛选约稿状态
let screen_status = ref("全部");
function screen_invited_draft_list() {
    const data=invited_draft_list.value;
    back_invited_draft_list.value=[]
    for(let i=0;i<data.length;i++)
{
    if(data[i].working_condition==select_input_list.value||select_input_list.value=="全部")
    {
        back_invited_draft_list.value.push(data[i])
    }
}
}
watch(select_input_list,()=>{
    screen_invited_draft_list()
})
onMounted(()=>{
    setTimeout(() => {
        screen_invited_draft_list();
    }, 110)
})
//统计选中状态
let correct_count = ref(0);
function count_correct_status() {
    let ill_page = document.querySelectorAll('.select_ill_btn img')
    let novel_page = document.querySelectorAll('.select_btn_work img');
    let path = "https://127.0.0.1:4434/assets/select_correct.svg"
    //获取插画页面所有的选中状态
    let ill_page_path = []
    for (let i = 0; i < ill_page.length; i++) {
        ill_page_path.push(ill_page[i].src)
    }
    //获取小说页面所有的选中状态
    let novel_page_path = []
    for (let i = 0; i < novel_page.length; i++) {
        novel_page_path.push(novel_page[i].src)
    }
    //统计插画页面选中数量
    let ill_count = ill_page_path.filter(item => item == path).length
    //统计小说页面选中数量
    let novel_count = novel_page_path.filter(item => item == path).length
    //总计选中数量
    correct_count.value = ill_count + novel_count;
    if (correct_count.value >= 3) {
        alert("最多只可选择三个推荐作品")
        return false;
    }
    else {
        return true;
    }
}

//获取被选中的作品
let select_work_list=ref([]);
async function get_select_work_list() {
    let ill_page=document.querySelectorAll('.item_img');
    let novel_page=document.querySelectorAll('.work_item');
    let ill_select_img=document.querySelectorAll('.select_ill_btn img')
    let novel_select_img=document.querySelectorAll('.select_btn_work img');
    let ill_list=[]
    let novel_list=[]
    for(let i=0;i<ill_page.length;i++){
        if(ill_select_img[i].src==select_correct_svg_path.value){
            let ill_id=ill_page[i].querySelector('#ill_id').textContent;
            ill_list.push(ill_id)
        }    
    }
    for(let i=0;i<novel_page.length;i++){
        if(novel_select_img[i].src==select_correct_svg_path.value)
        {
            let novel_id=novel_page[i].querySelector('#novel_work_id').textContent;
            novel_list.push(novel_id)
        }
    }
    console.log(ill_list)
    console.log(novel_list)
    try{
        const res=await fetch('api/updateUserSelectWork',{
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body:JSON.stringify({
                user_id:get_cookie('user_id'),
                username:get_cookie('user_name'),
                ill_id:ill_list,
                work_id:novel_list,
            })
        })
        const data=await res.json()
        if(data.status=='success'){
            console.log('保存成功')
        }
        else{
            console.log('保存失败')
        }
    }
    catch (err) {
        console.log(err)
    }
}
//设置已经选择的作品
let user_select_work_list=ref([]);
let user_ill_id_list=ref([]);
let user_work_id_list=ref([]);
async function set_select_work_list() {
   
    const res=await fetch('api/getSelectWorkList',{
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body:JSON.stringify({
            user_id:get_cookie('user_id'),
            username:get_cookie('user_name'),
        })
    })
    const data=await res.json()
    if(data.status=="success")
    {
        user_select_work_list.value=data.data;
        user_ill_id_list.value=user_select_work_list.value.ill_id;
        user_work_id_list.value=user_select_work_list.value.work_id;
    }
    else{
        console.log('获取失败')
    }
}
onMounted(()=>{
    set_select_work_list()
    setTimeout(()=>{
        set_ill_select_status()
    },250)
})
//设置选中状态
function set_ill_select_status(){
    let ill_page=document.querySelectorAll('.item_img');
    for(let i=0;i<ill_page.length;i++){
        let ill_id=ill_page[i].querySelector('#ill_id').textContent;
        let ill_select_img=ill_page[i].querySelector('.select_ill_btn img');
        if(user_ill_id_list.value.includes(ill_id))
        {
            ill_select_img.src=select_correct_svg_path.value;
        }
    }
}
function set_novel_select_status(){
    let novel_page=document.querySelectorAll('.work_item');
    for(let i=0;i<novel_page.length;i++){
        let novel_id=novel_page[i].querySelector('#novel_work_id').textContent;
        let novel_select_img=novel_page[i].querySelector('.select_btn_work img');
        if(user_work_id_list.value.includes(novel_id))
        {
            novel_select_img.src=select_correct_svg_path.value;
        }
    }
}

</script>

<style scoped>
.icon {
    width: 25px;
    height: 25px;
    object-fit: cover;
}

.select_btn,
.select_btn_work,
.select_ill_btn {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(133, 133, 133, 0.6);
    margin-left: auto;
    margin-right: 10px;
}

.select_btn:hover,
.select_btn_work:hover,
.select_ill_btn:hover {
    cursor: pointer;
    background-color: rgba(133, 133, 133, 0.8);
    transition: all 0.3s ease-in-out;
}

/*开始倒序编辑*/
.screen_select{
    display: flex;
    width:60%;
    justify-content: center;
    align-items: center;
    text-align: center;
    border-radius: 5px;
    margin:5px auto;
    box-shadow: 0px 0px 5px rgba(255, 0.3);
}
.screen_select option{
    background-color: rgba(133,133,133,0.2);
}
.screen_select option:hover{
    background-color: rgba(133,133,133,0.4);
    transition: all 0.3s ease-in-out;
}
.screen_title{
    display: flex;
    width:90%;
    justify-content: center;
    align-items: center;
    text-align: center;
    margin:5px auto;
}
.invited_draft_item {
    display: flex;
    width: 100%;
    height: auto;
    max-height: 200px;
    min-height: 180px;
    margin: 10px auto;
    padding: 5px;
    border-radius: 15px;
    background-color: rgba(133, 133, 133, 0.1);
    box-shadow: 0px 0px 10px rgba(255, 255, 255, 0.3);
}

.invited_draft_info {
    display: flex;
    width: 60%;
    height: auto;
    flex-direction: column;
    justify-content: space-around;
    overflow: auto;
}

.invited_draft_cover {
    display: flex;
    width: 40%;
    height: auto;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    border-radius: 15px;
}

.invited_draft_cover_img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.series_title {
    display: flex;
    width: 100%;
    height: auto;
    padding: 5px;
    justify-content: space-between
}

.ill_page {
    width: 90%;
    height: auto;
    margin: 5px auto;
    display: flex;
    flex-direction: column;
    overflow: auto;
    max-height: 500px;
}

.novel_page {
    width: 90%;
    height: auto;
    margin: 5px auto;
    display: flex;
    flex-direction: column;
}

.invited_draft {
    width: 90%;
    height: auto;
    margin: 5px auto;
    display: flex;
    flex-direction: column;
}

.invited_draft_list {
    display: flex;
    width: 100%;
    height: auto;
    padding: 5px;
    margin: 5px auto;
    flex-direction: column;
    max-height: 450px;
    overflow: auto;
}

.btn_box {
    display: flex;
    width: 90%;
    margin: 5px auto;
    justify-content: flex-end;
    align-items: center;
    margin-top: 15px;
    border-top: 1px solid #9e9d9d;
}

.save_btn {
    display: flex;
    padding-left: 15px;
    padding-right: 15px;
    padding-top: 5px;
    padding-bottom: 5px;
    border-radius: 15px;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    background-color: rgba(0, 150, 250, 1);
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    margin-top: 10px;
}

.save_btn:hover,
.cancel_btn:hover {
    opacity: 0.6;
    transition: all 0.3s ease-in-out;
}

.cancel_btn {
    display: flex;
    padding-left: 15px;
    padding-right: 15px;
    padding-top: 5px;
    padding-bottom: 5px;
    border-radius: 15px;
    justify-content: center;
    align-items: center;
    margin-left: 10px;
    cursor: pointer;
    background-color: rgba(133, 133, 133, 0.5);
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    margin-top: 10px;
}

.item_img {
    width: 100%;
    height: 200px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 10px;
    overflow: hidden;
    margin-top: 5px;
    justify-content: space-between;
    min-height: 180px;
}

.ill_img {
    width: 150px;
    height: 100%;
    object-fit: cover;
    border-radius: 15px;
}

.series_list {
    display: flex;
    width: 90%;
    height: auto;
    padding: 5px;
    flex-direction: column;
    max-height: 200px;
    overflow: auto;
}

.series_item {
    display: flex;
    width: 100%;
    height: 50px;
    margin: 5px auto;
    align-items: center;
}

.work_list {
    display: flex;
    width: 90%;
    height: auto;
    padding: 5px;
    margin: 5px auto;
    flex-direction: column;
    max-height: 200px;
    overflow: auto;
}

.work_item {
    display: flex;
    width: 100%;
    height: 100px;
    margin: 5px auto;
    align-items: center;
    position: relative;
}

.work_cover {
    width: 80px;
    height: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 10px;
    overflow: hidden;
}

.cover_img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.work_name {
    display: flex;
    width: auto;
    height: auto;
    margin-left: 10px;
    flex-direction: column;
    justify-content: flex-start;
}

/*结束*/
.chose_project {
    display: flex;
    width: 100vw;
    height: 100vh;
    justify-content: center;
    align-items: center;
    position: fixed;
    top: 0;
    left: 0;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 10;
    overflow: auto;
}

.content_box {
    display: flex;
    width: 550px;
    height: auto;
    flex-direction: column;
    border-radius: 15px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
    padding: 10px;
}

.title_box {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 10px auto;
    width: 100%;
}

.close_btn {
    width: 35px;
    height: 35px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-right: 10px;
}

.close_btn:hover {
    cursor: pointer;
    background-color: rgba(133, 133, 133, 0.6);
    border-radius: 50%;
    overflow: hidden;
    transition: all 0.3s ease-in-out;
}

.close_btn img {
    width: 25px;
    height: 25px;
    object-fit: cover;
}

.switch_tag {
    display: flex;
    width: 90%;
    margin: 5px auto;
    justify-content: center;
    align-items: center;
}

.tag_item {
    display: flex;
    padding-left: 15px;
    padding-right: 15px;
    padding-top: 5px;
    padding-bottom: 5px;
    border-radius: 15px;
    justify-content: center;
    align-items: center;
    border-radius: 15px;
    margin-left: 5px;
    margin-right: 5px;
}

.tag_item:hover {
    cursor: pointer;
    background-color: rgba(133, 133, 133, 0.1);
    transition: all 0.3s ease-in-out;
}
</style>