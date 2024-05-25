<template>
    <div class="edit_self_info">
        <div class="edit_box">
            <div class="title_box">
                <span>编辑个人信息</span>
                <div class="close_btn" @click="close_edit_self_info">
                    <img :src="close_btn_path" class="icon">
                </div>
            </div>
            <div class="user_avatar">
                <span class="box_title mt">个人头像</span>
                <div class="img_box">
                    <img :src="get_user_avatar_path()">
                </div>
            </div>
            <div class="user_name_box">
                <span class="box_title mt">昵称</span>
                <input type="text" maxlength="15" id="uses_name" class="mt">
            </div>
            <div class="self_introduce_box">
                <span class="box_title mt">自我介绍</span>
                <textarea id="self_introduce" class="mt">自我介绍</textarea>
            </div>
            <div class="person_website_box">
                <span class="box_title mt">个人网站</span>
                <input type="text" id="person_website" class="mt">
            </div>
            <div class="sex_box">
                <span class="box_title mt">性别</span>
                <div class="sex_box_item mt">
                    <label for="male"><input type="radio" id="male" name="sex" value="男">男</label>

                    <label for="female"><input type="radio" id="female" name="sex" value="女">女</label>
                    <label for="secret"><input type="radio" id="secret" name="sex" value="保密">保密</label>
                </div>
            </div>
            <div class="address_box">
                <span class="box_title mt">地址</span>
                <input type="text" id="address" class="mt">
            </div>
            <div class="birthday_box">
                <span class="box_title mt">出生年份</span>
                <select id="year" v-model="v_years">
                    <option value="">请选择</option>
                    <option v-for="i in years" :key="i">{{ i }}年</option>
                </select>
                <div class="month_and_day_box">
                    <span class="box_title ml mt">生日</span>
                    <div class="select_box mt" style="display:flex;width:100%;padding:0px;">
                        <select id="month" style="margin-left:10px;margin-right:10px;" v-model="v_months">
                            <option value="">请选择</option>
                            <option v-for="i in 12" :key="i">{{ i }}月</option>
                        </select>

                        <select id="day" style="margin-left:10px;margin-right:10px;" v-model="v_days">
                            <option value="">请选择</option>
                            <option v-for="i in day_list" :key="i">{{ i }}日</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="occupation_box mt">
                <span class="box_title mt">职业</span>
                <input type="text" id="occupation" class="mt">
            </div>
            <div class="btn_box mt">
                <div class="sava_btn mt" @click="sava_click"><span>保存修改</span></div>
                <div class="cancel_btn mt" @click="close_edit_self_info"><span>取消</span></div>
            </div>
        </div>
    </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted ,defineEmits} from 'vue';
export default {
    name: 'edit_self_info',
}
</script>

<script setup>
let server_ip = ref('https://127.0.0.1:4434/');
let close_btn_path = ref(server_ip.value + 'assets/close.svg');
let user_name = ref('admin')
let user_id=ref('f575b4d3-0683-11ef-adf4-00ffc6b98bdb');
let user_info = ref({})
let emit=defineEmits(['close_edit_self_info'])

//向父组件传递关闭消息
function close_edit_self_info() {
    emit('close_edit_self_info',false);
}

async function get_user_info() {
    try {
        const res = await fetch('api/get_all_userinfo', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                user_name: user_name.value
            })
        })
        const data = await res.json()
        if (data.status != 'success') {
            console.log(data.message)
        }
        else {
            user_info.value = data.data;

            console.log(user_info.value)
        }
    }
    catch (err) {
        console.log(err)
    }
}

onMounted(() => {
    get_user_info();
    setTimeout(() => {
        set_username();
        set_self_introduce();
        set_sex();
        set_address();
        set_person_website();
        set_year_list();
        set_birthday();
        set_occupation();
    }, 100)

})
function get_user_avatar_path() {
    return server_ip.value + 'image/' + user_info.value.user_avatar;
}
function set_username() {
    const name = document.getElementById('uses_name');
    name.value = user_info.value.username;
}
function set_self_introduce() {
    const introduce = document.getElementById('self_introduce');
    if (user_info.value.user_self_introduction == null || user_info.value.user_self_introduction == '') {
        introduce.placeholder = '自我介绍';
    }
    introduce.value = user_info.value.user_self_introduction;
}
function set_sex() {

    const male = document.getElementById('male');
    const female = document.getElementById('female');
    const secret = document.getElementById('secret');
    if (user_info.value.sex == '男') {
        male.checked = true;
    }
    else if (user_info.value.sex == '女') {
        female.checked = true;
    }
    else {
        secret.checked = true;
    }
}
function set_address() {
    const address = document.getElementById('address');
    address.value = user_info.value.user_address;
}
function set_person_website() {
    const website = document.getElementById('person_website');
    website.value = user_info.value.user_self_website;
}
let years = ref([]);
function set_year_list() {
    const currentYear = new Date().getFullYear();
    for (let i = currentYear; i >= 1900; i--) {
        years.value.push(i);
    }
}
//时间处理
let v_years = ref('');
let v_months = ref('');
let v_days = ref('');
let day_list = ref([]);
function getDaysInMonth(year, month) {
    // 获取指定月份的天数
    return new Date(year, month, 0).getDate();
}
function set_day_list(year, month) {
    year = year.slice(0, 4);
    month = month.slice(0, 1);
    const days = getDaysInMonth(year, month);
    day_list.value = [];
    console.log(year + month)
    for (let i = 1; i <= days; i++) {
        day_list.value.push(i);
    }
}
function set_birthday() {
    let birthday = user_info.value.birthday
    const year_select = document.getElementById('year');
    const month_select = document.getElementById('month');
    const day_select = document.getElementById('day');
    if (birthday == null || birthday == '') {
        year_select.value = '2000';
        month_select.value = '1';
        set_day_list(2000, 1);
        day_select.value = '1';
    }
    let year = birthday.slice(0, 5);
    console.log(year)
    let month = birthday.slice(5, 7);
    console.log(month)
    let day = birthday.slice(7, 11);
    console.log(day)
    setTimeout(() => {
        year_select.value = year;
        month_select.value = month;
    }, 100);
    set_day_list(year, month);

    setTimeout(() => {
        day_select.value = day;
    }, 100);
}
watch(() => [v_years.value, v_months.value], () => {
    set_day_list(v_years.value, v_months.value);
});
function set_occupation() {
    const occupation = document.getElementById('occupation');
    occupation.value = user_info.value.occupation;
    if (user_info.value.occupation == null || user_info.value.occupation == '') {
        occupation.placeholder = '职业';
    }
}
//保存修改
async function  sava_click() {
    let username=document.getElementById('uses_name').value;
    let self_introduce=document.getElementById('self_introduce').value;
    let sex=document.querySelector('input[name="sex"]:checked').value;
    let address=document.getElementById('address').value;
    let person_website=document.getElementById('person_website').value;
    let year=document.getElementById('year').value;
    let month=document.getElementById('month').value;
    let day=document.getElementById('day').value;
    let occupation=document.getElementById('occupation').value;
    if(username==''||username==null){
        alert('昵称不能为空')
        return;
    }
    try{
        const res=await fetch('api/update_user_info',{
            method:'post',
            headers:{
                'Content-Type':'application/json'
            },
            body:JSON.stringify({
                user_id:user_id.value,
                user_name:username,
                user_self_introduction:self_introduce,
                sex:sex,
                user_address:address,
                user_self_website:person_website,
                birthday:year+month+day,
                occupation:occupation
            })
        })
        const data=await res.json()
        if(data.status!='success'){
            alert(data.message)
        }
        else{
            alert('修改成功')
            close_edit_self_info();
        }
    }

    catch(err){
        console.log(err)
    }
}
</script>

<style scoped>
/*现在开始倒序编写样式*/
.sava_btn {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 40px;
    background-color: rgba(0, 150, 250, 1);
    opacity: 1;
    cursor: pointer;
    border-radius: 25px;
}

.sava_btn:hover {
    opacity: 0.8;
    transition: all 0.3s ease-in-out;
}

.cancel_btn {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 40px;
    background-color: rgba(133, 133, 133, 1);
    opacity: 1;
    cursor: pointer;
    border-radius: 25px;
}

.cancel_btn:hover {
    opacity: 0.8;
    transition: all 0.3s ease-in-out;
}

.box_title {
    font-size: 16px;
    font-weight: bold;
}

.self_introduce_box {
    display: flex;
    width: 90%;
    margin: 10px auto;
    flex-direction: column;
}

.self_introduce_box textarea {
    width: 100%;
    height: auto;
    resize: vertical;
}

.person_website_box {
    display: flex;
    width: 90%;
    margin: 10px auto;
    flex-direction: column;
}

.sex_box {
    display: flex;
    width: 90%;
    margin: 10px auto;
    flex-direction: column;
}

.address_box {
    display: flex;
    width: 90%;
    margin: 10px auto;
    flex-direction: column;
}

.birthday_box {
    display: flex;
    width: 90%;
    margin: 10px auto;
    flex-direction: column;
}

.month_and_day_box {
    display: flex;
    flex-direction: column;
}

.occupation_box {
    display: flex;
    width: 90%;
    margin: 10px auto;
    flex-direction: column;
}

.btn_box {
    display: flex;
    width: 90%;
    margin: 10px auto;
    justify-content: space-between;
    flex-direction: column;
}

/*结束*/
.edit_self_info {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
    background-color: rgba(0, 0, 0, 0.3);
    z-index: 8;
    overflow: auto;
}

.edit_box {
    display: flex;
    width: 350px;
    height: auto;
    justify-content: center;
    align-items: center;
    background-color: #fff;
    border-radius: 15px;
    flex-direction: column;
    margin-bottom: 40px;
    margin-top: 230px;
}

.title_box {
    display: flex;
    margin: 10px auto;
    align-items: center;
    position: relative;
    width: 100%;
    justify-content: center;
}

.close_btn {
    position: absolute;
    width: 35px;
    height: 35px;
    right: 5px;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    overflow: hidden;
}

.close_btn:hover {
    background-color: rgba(133, 133, 133, 0.5);
    transition: all 0.3s ease-in-out;
}

.close_btn img {
    width: 80%;
    height: 80%;
    object-fit: cover;
}

.user_avatar {
    display: flex;
    width: 90%;
    margin: 10px auto;
    flex-direction: column;
}

.img_box {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    overflow: hidden;
    margin-top: 10px;
}

.img_box img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.user_name_box {
    display: flex;
    flex-direction: column;
    width: 90%;
    margin: 10px auto;
}

.mt {
    margin-top: 5px;
}

.ml {
    margin-left: 10px;
}
</style>