<template>
    <div class="edit_user_avatar">
        <div class="edit_avatar_box">
            <div class="edit_avatar_title">
                <span><b>编辑头像</b></span>
                <div class="edit_avatar_close" @click="close_edit_useravatar()">
                    <img :src="close_svg" class="icon">
                </div>
            </div>
            <div class="avatar_img">
                <img :src="user_avatar">
                <div class="choose_img" @click="choose_img">
                    <img :src="choose_img_path" class="choose_img_icon">
                </div>
                <input type="file" id="choose_avatar_img" style="display:none;">
            </div>
            <div class="tips_img_box">
                <div class="content">
                    <span><b>适用格式</b></span>
                    <span>JPEG/PNG/GIF</span>
                </div>
                <div class="content">
                    <span><b>最大文件容量</b></span>
                    <span>5M</span>
                </div>
            </div>
            <div class="vip_tips_box">
                <span style="font-size:12px;">开通pixiv高级会员，即可将GIF动图设为个人头像。</span>
                <div class="get_vip_btn">
                    <span>成为高级会员</span>
                </div>
            </div>
            <div class="upload_img_tips_box">
                <img :src="tips_ico_path" class="icon">
                <span style="font-size:12px;">上传的图片将会裁切为圆形，并显示于个人资料中。</span>
            </div>
            <div class="upload_tips">
                <span>请不要上传R-18或使用规则中禁止投稿的作品。如果您上传了相关图片，设置可能会被清除。</span>
            </div>
            <div class="btn_box">
                <div class="sure_btn">确定</div>
                <div class="cancel_btn" @click="close_edit_useravatar()">取消</div>
            </div>
        </div>
    </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted, defineEmits } from 'vue';
export default {
    name: 'edit_user_avatar',
}
</script>

<script setup>
let server_ip = 'https://127.0.0.1:4434/';
let close_svg = ref(server_ip + 'assets/close.svg');
let choose_img_path = ref(server_ip + 'assets/image.svg')
let tips_ico_path = ref(server_ip + 'assets/info.svg')

//向父组件传递关闭消息
let emit = defineEmits(['close_edit_useravatar_msg'])
function close_edit_useravatar() {
    emit('close_edit_useravatar_msg', false);
}

//获取用户所有信息
let user_name = ref('admin')
// eslint-disable-next-line no-unused-vars
let user_id = ref('f575b4d3-0683-11ef-adf4-00ffc6b98bdb');
let user_info = ref({})
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
        get_user_avatar();
    }, 100)

})
//获取用户原始头像
let user_avatar = ref(server_ip + 'image/')
function get_user_avatar() {
    user_avatar.value = server_ip + 'image/' + user_info.value.user_avatar;
}
//选择头像
let choose_avatar_img = ref(null)
let file_name = ref('')
let file_path = ref('')
function choose_img() {
    var file_btn = document.getElementById('choose_avatar_img');
    file_btn.click();
    file_btn.onchange = () => {
        choose_avatar_img.value = file_btn.files[0];
        if (choose_avatar_img.value) {
            file_name.value = choose_avatar_img.value.name;
            file_path.value = URL.createObjectURL(choose_avatar_img.value);
            console.log(file_name.value);
        }
    };
}
watch(file_path, () => {
    user_avatar.value = file_path.value;
})
</script>

<style scoped>
.icon {
    width: 20px;
    height: 20px;
    object-fit: cover;
}

/*倒序编辑开始*/
.vip_tips_box {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 80%;
    height: auto;
    padding-top: 5px;
    padding-bottom: 5px;
    padding: 20px;
    flex-direction: column;
    background-color: rgba(133, 133, 133, 0.3);
    margin: 5px auto;
    border-radius: 15px;
}

.get_vip_btn {
    display: flex;
    width: 60%;
    height: auto;
    padding-top: 5px;
    padding-bottom: 5px;
    background-color: #fd9e16;
    margin-top: 10px;
    margin-left: auto;
    margin-right: auto;
    border-radius: 20px;
    justify-content: center;
    align-items: center;
    color: #fff;
    font-size: 14px;
    font-weight: bold;
}

.get_vip_btn:hover {
    cursor: pointer;
    opacity: 0.8;
    transition: all 0.3s ease-in-out;
}

.upload_img_tips_box {
    display: flex;
    width: 90%;
    height: auto;
    padding: 5px;
    margin: 5px auto;
    background-color: rgba(133, 133, 133, 0.3);
    border-radius: 15px;
    justify-content: center;
    align-items: center;
}

.upload_tips {
    display: flex;
    width: 90%;
    height: auto;
    margin: 5px auto;
    justify-content: center;
    align-items: center;
    font-size: 14px;
}
.btn_box{
    display: flex;
    width:80%;
    height: auto;
    margin:10px auto;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}
.sure_btn{
    display: flex;
    width: 100%;
    height: auto;
    padding-top:10px;
    padding-bottom: 10px;
    background-color: rgba(0,155,250,1);
    justify-content: center;
    align-items: center;
    border-radius: 20px;
    color: #fff;
}
.cancel_btn{
    display: flex;
    width: 100%;
    height: auto;
    padding-top:10px;
    padding-bottom: 10px;
    background-color: rgba(133,133,133, 0.8);
    justify-content: center;
    align-items: center;
    border-radius: 20px;
    color: #000;
    margin-top: 10px;
}
.sure_btn:hover,.cancel_btn:hover{
    cursor: pointer;
    opacity: 0.8;
    transition: all 0.3s ease-in-out;
}
/*倒序编辑结束*/
.edit_user_avatar {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
    overflow: auto;
    z-index: 11;
}

.edit_avatar_box {
    width: 350px;
    height: auto;
    border-radius: 15px;
    padding: 5px;
    background-color: rgba(255, 255, 255, 1);
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

.edit_avatar_title {
    display: flex;
    width: 100%;
    margin: 10px auto;
    justify-content: center;
    align-items: center;
    font-size: 18px;
    position: relative;
}

.edit_avatar_close {
    position: absolute;
    right: 5px;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 30px;
    height: 30px;
    border-radius: 50%;
}

.edit_avatar_close:hover {
    background-color: rgba(133, 133, 133, 0.5);
    opacity: 0.8;
    transition: all 0.3s ease-in-out;
    overflow: hidden;
}

.edit_avatar_close img {
    width: 80%;
    height: 80%;
    object-fit: cover;
}

.avatar_img {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 30%;
    position: relative;
    overflow: hidden;
    background-color: rgba(133, 133, 133, 0.2);
}

.avatar_img img {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    overflow: hidden;
    object-fit: cover;
}

.choose_img {
    position: absolute;
    top: 0px;
    left: 0px;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(0, 0, 0, 0.3);
    opacity: 0;
}

.choose_img:hover {
    opacity: 1;
    transition: all 0.3s ease-in-out;
    cursor: pointer;
}

.choose_img img {
    width: 50px;
    height: 50px;
    object-fit: cover;
}

.choose_img_icon {
    width: 50px;
    height: 50px;
    object-fit: cover;
}

.tips_img_box {
    display: flex;
    width: 100%;
    height: auto;
    margin-top: 10px;
    flex-direction: column;
}

.content {
    display: flex;
    width: 90%;
    height: auto;
    margin-top: 10px;
    justify-content: space-between;
    align-items: center;
    margin-left: auto;
    margin-right: auto;
}
</style>