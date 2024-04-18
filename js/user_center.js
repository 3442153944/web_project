/* eslint-disable no-undef */
/* eslint-disable vue/no-dupe-keys */
var model = `<div class="edit_userinfo_box_contact_information_text">
<div class="edit_userinfo_box_contact_information_text_fun">
    <input placeholder="请输入联系方式">
</div>
<div class="edit_userinfo_box_contact_information_text_choose">
    <select>
        <option>
            <div class="edit_userinfo_box_contact_information_text_choose_box">
                <div class="edit_userinfo_box_contact_information_text_choose_ico">
                    <svg t="1712890771404" class="icon" viewBox="0 0 1025 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2340"
                        width="200" height="200">
                        <path
                            d="M483.84768 867.808C466.37568 885.792 441.73568 896 415.87968 896 390.05568 896 365.41568 885.792 347.94368 867.808L27.46368 547.552C-9.17632 508.864-9.17632 450.336 27.46368 411.648 44.26368 394.944 67.30368 385.088 91.68768 384.256 118.72768 383.008 144.93568 393.024 163.46368 411.648L415.87968 664 860.61568 219.552C878.31168 201.952 902.88768 192 928.58368 192 954.24768 192 978.82368 201.952 996.51968 219.552 1033.15968 258.208 1033.15968 316.704 996.51968 355.36L483.84768 867.808Z"
                            p-id="2341"></path>
                    </svg>
                </div>
                <div class="edit_userinfo_box_contact_information_text_choose_text">QQ</div>
            </div>
        </option>
        <option>
            <div class="edit_userinfo_box_contact_information_text_choose_box">
                <div class="edit_userinfo_box_contact_information_text_choose_ico"></div>
                <div class="edit_userinfo_box_contact_information_text_choose_text">微信</div>
            </div>
        </option>
    </select>
</div>
</div>`;
const eventbus = new Vue();

Vue.component('sub-main-usercenter-selected-works', {
    props: ['item'],
    template: `
        <div class="sub_main_usercenter_selected_works">
            <div class="sub_main_usercenter_selected_works_img">
                <img :src="item.imgsrc">
                <div class="sub_main_usercenter_selected_works_ico">
                <svg t="1713083347358" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="9142" width="200" height="200" class="icon">
                    <path d="M783.1 831.7H347c-34.1 0-61.8-27.7-61.8-61.8V197.7c0-34.1 27.7-61.8 61.8-61.8h436c34.1 0 61.8 27.7 61.8 61.8V770c0 34-27.7 61.7-61.7 61.7zM347 163.9c-18.6 0-33.8 15.1-33.8 33.8V770c0 18.6 15.1 33.8 33.8 33.8h436c18.6 0 33.8-15.1 33.8-33.8V197.7c0-18.6-15.1-33.8-33.8-33.8H347z" fill="#263554" p-id="9143"></path>
                    <path d="M654.1 916.1H244.7c-37.2 0-67.5-27.9-67.5-62.3V291.5c0-34.3 30.3-62.3 67.5-62.3H296c7.7 0 14 6.3 14 14s-6.3 14-14 14h-51.3c-21.8 0-39.5 15.4-39.5 34.3v562.3c0 18.9 17.7 34.3 39.5 34.3h409.4c17 0 30.8-13.8 30.8-30.8v-39.5c0-7.7 6.3-14 14-14s14 6.3 14 14v39.5c0 32.4-26.4 58.8-58.8 58.8z" fill="#263554" p-id="9144"></path>
                </svg>
                <div>{{ item.imgnum }}</div>
            </div>
            </div>
        </div>`,
});

Vue.component('collect_work_info_box', {
    props: ['items'],
    data: function () {
        return {
            switch_box_content_2_love_show_1: true,
            switch_box_content_2_love_show_2: false,
            content_box_title: false,
            author_introduction_show: false,
            content_box_privacy: false,
            setpublic: '设为私密',
            setcollection: '取消收藏',
            settag: '设置标签',
            
            img1:'image/117349407_p0_master1200.jpg',
            imgnum1:'3',
            img2:'image/117214493_p0_master1200.jpg',
            imgnum2:'1',
            img3: 'image/116707350_p0_master1200.jpg', 
            imgnum3:'2',
        }
    },
    template: `
    <div class="switch_box_content_2_content_1_page_content_box">
  <div class="switch_box_content_2_content_1_page_content_box_img">
    <img src="image/82181448_p0(1).jpg">
    <div class="switch_box_content_2_content_1_page_content_box_img_moreico">
      <svg t="1713083347358" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
        p-id="9142" width="200" height="200">
        <path
          d="M783.1 831.7H347c-34.1 0-61.8-27.7-61.8-61.8V197.7c0-34.1 27.7-61.8 61.8-61.8h436c34.1 0 61.8 27.7 61.8 61.8V770c0 34-27.7 61.7-61.7 61.7zM347 163.9c-18.6 0-33.8 15.1-33.8 33.8V770c0 18.6 15.1 33.8 33.8 33.8h436c18.6 0 33.8-15.1 33.8-33.8V197.7c0-18.6-15.1-33.8-33.8-33.8H347z"
          fill="#263554" p-id="9143"></path>
        <path
          d="M654.1 916.1H244.7c-37.2 0-67.5-27.9-67.5-62.3V291.5c0-34.3 30.3-62.3 67.5-62.3H296c7.7 0 14 6.3 14 14s-6.3 14-14 14h-51.3c-21.8 0-39.5 15.4-39.5 34.3v562.3c0 18.9 17.7 34.3 39.5 34.3h409.4c17 0 30.8-13.8 30.8-30.8v-39.5c0-7.7 6.3-14 14-14s14 6.3 14 14v39.5c0 32.4-26.4 58.8-58.8 58.8z"
          fill="#263554" p-id="9144"></path>
      </svg>
      1
    </div>
    <div class="switch_box_content_2_content_1_page_content_box_img_love">
      <div v-show="switch_box_content_2_love_show_1" @click="switch_box_content_2_love_show_1_btn1">
        <svg t="1713083415377" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
          p-id="10166" width="200" height="200">
          <path
            d="M512 901.746939c-13.583673 0-26.122449-4.179592-37.093878-13.061225-8.881633-7.314286-225.697959-175.020408-312.424489-311.379592C133.746939 532.37551 94.040816 471.24898 94.040816 384.522449c0-144.718367 108.146939-262.269388 240.326531-262.269388 67.395918 0 131.657143 30.82449 177.632653 84.636735 45.453061-54.334694 109.191837-84.636735 177.110204-84.636735 132.702041 0 240.326531 117.55102 240.326531 262.269388 0 85.159184-37.093878 143.673469-67.395919 191.216327l-1.044898 1.567346c-86.726531 136.359184-303.542857 304.587755-312.424489 311.379592-10.44898 8.359184-22.987755 13.061224-36.571429 13.061225z"
            fill="#E5404F" p-id="10167"></path>
        </svg>
      </div>
      <div v-show="switch_box_content_2_love_show_2" @click="switch_box_content_2_love_show_1_btn1">
        <svg t="1713085520923" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
          p-id="12188" width="200" height="200">
          <path
            d="M667.786667 117.333333C832.864 117.333333 938.666667 249.706667 938.666667 427.861333c0 138.250667-125.098667 290.506667-371.573334 461.589334a96.768 96.768 0 0 1-110.186666 0C210.432 718.368 85.333333 566.112 85.333333 427.861333 85.333333 249.706667 191.136 117.333333 356.213333 117.333333c59.616 0 100.053333 20.832 155.786667 68.096C567.744 138.176 608.170667 117.333333 667.786667 117.333333z m0 63.146667c-41.44 0-70.261333 15.189333-116.96 55.04-2.165333 1.845333-14.4 12.373333-17.941334 15.381333a32.32 32.32 0 0 1-41.770666 0c-3.541333-3.018667-15.776-13.536-17.941334-15.381333-46.698667-39.850667-75.52-55.04-116.96-55.04C230.186667 180.48 149.333333 281.258667 149.333333 426.698667 149.333333 537.6 262.858667 675.242667 493.632 834.826667a32.352 32.352 0 0 0 36.736 0C761.141333 675.253333 874.666667 537.6 874.666667 426.698667c0-145.44-80.853333-246.218667-206.88-246.218667z"
            fill="#000000" p-id="12189"></path>
        </svg>
      </div>
    </div>
    <div class="switch_box_content_2_content_1_page_content_box_privacy" v-show="content_box_privacy">
      <svg t="1713086577301" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
        p-id="13190" width="200" height="200">
        <path
          d="M843.384925 342.396784h-16.87799v-27.889849a314.506935 314.506935 0 0 0-629.01387 0v27.889849H180.615075A137.905528 137.905528 0 0 0 42.709548 480.302312V886.094472a137.905528 137.905528 0 0 0 137.905527 137.905528h662.76985a137.905528 137.905528 0 0 0 137.905527-137.905528V480.302312a137.905528 137.905528 0 0 0-137.905527-137.905528z m-553.268744-27.889849a221.883819 221.883819 0 0 1 443.767638 0v27.889849H290.116181zM551.107538 690.865528v115.264321a39.107538 39.107538 0 0 1-78.215076 0v-115.264321a89.432764 89.432764 0 1 1 78.215076 0z"
          fill="#333333" p-id="13191"></path>
      </svg>
    </div>
    <div class="switch_box_content_2_content_1_page_content_box_img_edit">
      <div class="switch_box_content_2_content_1_page_content_box_img_edit_icon" @click="edit_imglook1">
        <svg t="1713083480072" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
          p-id="11165" width="200" height="200">
          <path
            d="M402.24 753.12l417.984-417.952a35.552 35.552 0 0 0 0-50.304l-75.424-75.424a35.552 35.552 0 0 0-50.304 0L276.576 627.392l-8.992 134.72 134.688-8.992zM193.664 801.92l13.76-205.92L644.192 159.168a106.656 106.656 0 0 1 150.848 0l75.424 75.424a106.656 106.656 0 0 1 0 150.848L433.632 822.304l-205.92 13.728A32 32 0 0 1 193.6 801.92zM644.224 259.744l-50.272 50.24 125.696 125.76 50.272-50.304-125.696-125.696z"
            fill=rgb(255,255,255) p-id="11166"></path>
        </svg>
      </div>

    </div>
    <div class="switch_box_content_2_content_1_page_content_box_img_back" @click="jump_imgpage1">

    </div>
  </div>
  <div class="switch_box_content_2_content_1_page_content_box_title" v-show="content_box_title">
    <div class="switch_box_content_2_cont_1_page_content_box_title_setpublic mt hv" @click="setpublic_btn1">
      {{setpublic}}</div>
    <div class="switch_box_content_2_content_1_page_content_box_title_setcollection mt hv " @click="setcollection_btn1">
      {{setcollection}}</div>
    <div class="switch_box_content_2_content_1_page_content_box_title_settag mt hv" @click="settag_btn1">{{settag}}
    </div>
  </div>
  <div class="switch_box_content_2_content_1_page_content_box_userbox" @mouseenter="showsubusercenter1"
    @mouseleave="hidesubusercenter1">
    <div class="switch_box_content_2_content_1_page_content_box_userbox_avatar">
      <img src="image/87328997_p0.jpg">
    </div>
    <div class="switch_box_content_2_content_1_page_content_box_userbox_name">用户名</div>
    <div class="switch_box_content_2_content_1_page_content_box_userbox_author_introduction"
      v-show="author_introduction_show">
      <div class="sub_main_usercenter">
        <div class="sub_main_usercenter_background">
          <div class="sub_main_usercenter_background_img">
            <img src="image/97165605_p0.jpg">
          </div>
          <div class="sub_main_usercenter_background_img_back">

          </div>
        </div>
        <div class="sub_main_usercenter_avatar">
          <div class="sub_main_usercenter_avatar_img">
            <img src="image/ma.png">
          </div>

        </div>
        <div class="sub_main_usercenter_name">Date锶氚麻酱</div>
        <div class="sub_main_usercenter_introduction">
          <div class="sub_main_usercenter_introduction_text">
            手工绘画，我会继续努力的，谢谢你能够喜欢我的作品，下面是联系方式，QQ号336…
          </div>
          <div class="sub_main_usercenter_introduction_btn">
            查看个人资料
          </div>
        </div>
        <div class="sub_main_usercenter_follow">已关注</div>
        <div class="sub_main_usercenter_selected_works_box">
          <div class="sub_main_usercenter_selected_works">
            <div class="sub_main_usercenter_selected_works_img">
              <img :src="img1">
              <div class="sub_main_usercenter_selected_works_ico">
                <svg t="1713083347358" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                  p-id="9142" width="200" height="200" class="icon">
                  <path
                    d="M783.1 831.7H347c-34.1 0-61.8-27.7-61.8-61.8V197.7c0-34.1 27.7-61.8 61.8-61.8h436c34.1 0 61.8 27.7 61.8 61.8V770c0 34-27.7 61.7-61.7 61.7zM347 163.9c-18.6 0-33.8 15.1-33.8 33.8V770c0 18.6 15.1 33.8 33.8 33.8h436c18.6 0 33.8-15.1 33.8-33.8V197.7c0-18.6-15.1-33.8-33.8-33.8H347z"
                    fill="#263554" p-id="9143"></path>
                  <path
                    d="M654.1 916.1H244.7c-37.2 0-67.5-27.9-67.5-62.3V291.5c0-34.3 30.3-62.3 67.5-62.3H296c7.7 0 14 6.3 14 14s-6.3 14-14 14h-51.3c-21.8 0-39.5 15.4-39.5 34.3v562.3c0 18.9 17.7 34.3 39.5 34.3h409.4c17 0 30.8-13.8 30.8-30.8v-39.5c0-7.7 6.3-14 14-14s14 6.3 14 14v39.5c0 32.4-26.4 58.8-58.8 58.8z"
                    fill="#263554" p-id="9144"></path>
                </svg>
                <div>{{ imgnum1 }}</div>
              </div>
            </div>

          </div>
          <div class="sub_main_usercenter_selected_works">
          <div class="sub_main_usercenter_selected_works_img">
            <img :src="img2">
            <div class="sub_main_usercenter_selected_works_ico">
              <svg t="1713083347358" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                p-id="9142" width="200" height="200" class="icon">
                <path
                  d="M783.1 831.7H347c-34.1 0-61.8-27.7-61.8-61.8V197.7c0-34.1 27.7-61.8 61.8-61.8h436c34.1 0 61.8 27.7 61.8 61.8V770c0 34-27.7 61.7-61.7 61.7zM347 163.9c-18.6 0-33.8 15.1-33.8 33.8V770c0 18.6 15.1 33.8 33.8 33.8h436c18.6 0 33.8-15.1 33.8-33.8V197.7c0-18.6-15.1-33.8-33.8-33.8H347z"
                  fill="#263554" p-id="9143"></path>
                <path
                  d="M654.1 916.1H244.7c-37.2 0-67.5-27.9-67.5-62.3V291.5c0-34.3 30.3-62.3 67.5-62.3H296c7.7 0 14 6.3 14 14s-6.3 14-14 14h-51.3c-21.8 0-39.5 15.4-39.5 34.3v562.3c0 18.9 17.7 34.3 39.5 34.3h409.4c17 0 30.8-13.8 30.8-30.8v-39.5c0-7.7 6.3-14 14-14s14 6.3 14 14v39.5c0 32.4-26.4 58.8-58.8 58.8z"
                  fill="#263554" p-id="9144"></path>
              </svg>
              <div>{{ imgnum2 }}</div>
            </div>
          </div>
          </div>
          <div class="sub_main_usercenter_selected_works">
          <div class="sub_main_usercenter_selected_works_img">
            <img :src="img3">
            <div class="sub_main_usercenter_selected_works_ico">
              <svg t="1713083347358" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                p-id="9142" width="200" height="200" class="icon">
                <path
                  d="M783.1 831.7H347c-34.1 0-61.8-27.7-61.8-61.8V197.7c0-34.1 27.7-61.8 61.8-61.8h436c34.1 0 61.8 27.7 61.8 61.8V770c0 34-27.7 61.7-61.7 61.7zM347 163.9c-18.6 0-33.8 15.1-33.8 33.8V770c0 18.6 15.1 33.8 33.8 33.8h436c18.6 0 33.8-15.1 33.8-33.8V197.7c0-18.6-15.1-33.8-33.8-33.8H347z"
                  fill="#263554" p-id="9143"></path>
                <path
                  d="M654.1 916.1H244.7c-37.2 0-67.5-27.9-67.5-62.3V291.5c0-34.3 30.3-62.3 67.5-62.3H296c7.7 0 14 6.3 14 14s-6.3 14-14 14h-51.3c-21.8 0-39.5 15.4-39.5 34.3v562.3c0 18.9 17.7 34.3 39.5 34.3h409.4c17 0 30.8-13.8 30.8-30.8v-39.5c0-7.7 6.3-14 14-14s14 6.3 14 14v39.5c0 32.4-26.4 58.8-58.8 58.8z"
                  fill="#263554" p-id="9144"></path>
              </svg>
              <div>{{ imgnum3 }}</div>
            </div>
          </div>
          </div>
        </div>

      </div>
    </div>

  </div>
</div>
`,
    methods: {
        switch_box_content_2_love_show_1_btn1: function () {
            if (this.switch_box_content_2_love_show_1 == true) {
                this.switch_box_content_2_love_show_1 = false;
                this.switch_box_content_2_love_show_2 = true;
            }
            else {
                this.switch_box_content_2_love_show_1 = true;
                this.switch_box_content_2_love_show_2 = false;
            }
        },
        edit_imglook1: function () {
            console.log("修改图片公开");
            // eslint-disable-next-line no-unused-vars
            var mainPage = document.querySelector('.switch_box_content_2_content_1_page_content_box_title');
            if (this.content_box_title == true) {
                this.content_box_title = false;
                console.log('fa');
            } else {
                this.content_box_title = true;
                console.log('t');
            }
            document.addEventListener('click', this.handleClickOutside1);
        },

        handleClickOutside1: function (event) {
            var mainPage = this.$el;
            var showBtn = document.querySelector('.switch_box_content_2_content_1_page_content_box_img_edit');

            // Check if the clicked target is outside the mainPage and showBtn
            if (!mainPage.contains(event.target) && !showBtn.contains(event.target)) {
                this.content_box_title = false;
                console.log('点击主窗口外部，关闭窗口');
                console.log(event.target);
                document.removeEventListener('click', this.handleClickOutside1);
            }
        },
        jump_imgpage1: function () {
            console.log('图片跳转详情页');
        },
        setpublic_btn1: function () {
            if (this.content_box_privacy == false) {
                this.content_box_privacy = true;
                this.setpublic = '设置为公开';
            }
            else {
                this.content_box_privacy = false;
                this.setpublic = '设置为私密';
            }
        },
        setcollection_btn1: function () {
            if (this.setcollection == '取消收藏') {
                this.setcollection = '收藏';
                this.switch_box_content_2_love_show_1 = false;
                this.switch_box_content_2_love_show_2 = true;
            }
            else {
                this.setcollection = '取消收藏';
                this.switch_box_content_2_love_show_1 = true;
                this.switch_box_content_2_love_show_2 = false;
            }
        },
        settag_btn1: function () {
            console.log('设置标签');
        },
        showsubusercenter1() {

            var windows_hidth = window.innerHeight;
            console.log(windows_hidth+'窗口高度');

            this.timeoutid = setTimeout(() => {
                this.author_introduction_show = true;

            }, 500);
            var mainpage = this.$el;
            console.log(mainpage.offsetHeight+ '主高度');
            var mainpage_height=mainpage.getBoundingClientRect();  
            console.log(mainpage_height.y+'主窗口距底部高度');
            var test_height = document.querySelector('.sub_main_usercenter').clientHeight;
            console.log(test_height + '子窗口高度');
        },
        hidesubusercenter1() {
            this.timeoutid = setTimeout(() => {
                this.author_introduction_show = false;
            }, 500);

        },
    },
});



// eslint-disable-next-line no-unused-vars, no-undef
var vm = new Vue({
    el: '.main_content',
    data: function () {
        return {
            edit_box_background_color_show: false,
            user_info_box_show: false,
            avatar_editbox_show: false,
            indexpage_style: {
                'border-top': "4px solid rgba(0, 150, 250, 1)",
                opacity: 1
            },
            collection_style: {
            },
            temp: {
                'border-top': "4px solid rgba(0, 150, 250, 1)",
                opacity: 1
            },
            action: {
                'background-color': 'rgba(200,200,200,0.5)',
                'border-radius': '15px',
                position: 'absolute',
                left: 2.5,
                width: '90px',
                height: '40px',
            },
            step_len: 0,
            ill_show: true,
            novel_show: false,
            invited_draft_show: false,
            function_testing_show: false,
            addpage_show: false,
            switch_box_content_1: false,
            switch_box_content_2: true,
            // eslint-disable-next-line no-dupe-keys
            temp: {
                'background-color': 'rgba(199, 197, 197,0.5)',
            },
            switch_box_content_2_title_1: { 'background-color': 'rgba(199, 197, 197,0.5)', },
            switch_box_content_2_title_2: "",
            switch_box_content_2_title_3: "",
            switch_box_content_2_title_4: "",
            switch_box_content_2_love_show_1: true,
            switch_box_content_2_love_show_2: false,
            content_box_privacy: false,
            content_box_title: false,
            setpublic: '设置为私密',
            setcollection: '取消收藏',
            settag: '设置标签',
            author_introduction_show: false,
            items: [
                { imgsrc: 'image/117349407_p0_master1200.jpg', imgnum: 3 },
                { imgsrc: 'image/117214493_p0_master1200.jpg', imgnum: 1 },
                { imgsrc: 'image/116707350_p0_master1200.jpg', imgnum: 2 },
            ],
            timeoutid: null,
            message_test: 'test',
        };
    },

    computed: {

    },
    methods: {
        edit_btn: function () {
            console.log('test');
            this.edit_box_background_color_show = true;
        },
        hidden_btn: function () {
            this.edit_box_background_color_show = false;
        },
        delete_btn: function () {
            if (window.confirm('是否删除该图片？')) {
                console.log("删除确认");
            }
            else {
                console.log("删除取消");
            }
        },
        done_upload: function () {
            console.log("上传完成");
        },
        upload_img: function () {
            console.log("选择完成");
        },
        close_user_info_box: function () {
            this.user_info_box_show = false;
        },
        open_user_info_box: function () {
            this.user_info_box_show = true;
        },
        hidden_avatar_edit_box: function () {
            this.avatar_editbox_show = false;
            console.log("test");
        },
        add_contact() {
            var targetdiv = document.querySelectorAll('.edit_userinfo_box_contact_information');
            targetdiv.forEach(function (target) {
                target.insertAdjacentHTML('beforeend', model);
            });

        },
        switch_box_btn: function (type) {
            temp = this.temp;
            if (type == 'indexpage') {
                this.indexpage_style = temp;
                this.collection_style = null;
                this.switch_box_content_1 = true;
                this.switch_box_content_2 = false;
            }
            else {
                this.collection_style = temp;
                this.indexpage_style = null;
                this.switch_box_content_1 = false;
                this.switch_box_content_2 = true;
            }
        },
        //切换动画
        switch_box_action: function (type) {
            var mainpage_width = document.querySelector('.switch_box_content_1_content_addpage_box_switch_box').offsetWidth;
            var add_width = mainpage_width / 4 + 2.5;
            var target_left = 0;

            switch (type) {
                case 0:
                    target_left = 2.5;
                    this.ill_show = true;
                    this.novel_show = false;
                    this.invited_draft_show = false;
                    this.function_testing_show = false;
                    break;
                case 1:
                    target_left = add_width - 2.5;
                    this.ill_show = false;
                    this.novel_show = true;
                    this.invited_draft_show = false;
                    this.function_testing_show = false;
                    break;
                case 2:
                    target_left = add_width * 2 - 2.5 * 2;
                    this.ill_show = false;
                    this.novel_show = false;
                    this.invited_draft_show = true;
                    this.function_testing_show = false;
                    break;
                case 3:
                    target_left = add_width * 3 - 2.5 * 3;
                    this.ill_show = false;
                    this.novel_show = false;
                    this.invited_draft_show = false;
                    this.function_testing_show = true;
                    break;
            }

            this.step_len = Math.abs(this.action.left - target_left) / 60;
            this.do_action(this.action.left, target_left);
            //this.action.left = target_left;
        },
        do_action: function (now_left, target_left, steps = 0) {
            if (now_left == target_left || steps >= 60) {
                this.action.left = target_left;
                return;
            }

            var temp = now_left < target_left ? now_left + this.step_len : now_left - this.step_len;
            this.action.left = temp;
            setTimeout(() => this.do_action(temp, target_left, steps + 1), 0.08);
        },
        show_addpage_show: function () {
            if (this.addpage_show == true) {
                this.addpage_show = false;
            }
            else {
                this.addpage_show = true;
            }
        },
        switch_box_content_2_title_btn: function (type) {
            switch (type) {
                case 1:
                    this.switch_box_content_2_title_1 = this.temp;
                    this.switch_box_content_2_title_2 = "";
                    this.switch_box_content_2_title_3 = "";
                    this.switch_box_content_2_title_4 = "";
                    break;
                case 2:
                    this.switch_box_content_2_title_1 = "";
                    this.switch_box_content_2_title_2 = this.temp;
                    this.switch_box_content_2_title_3 = "";
                    this.switch_box_content_2_title_4 = "";
                    break;
                case 3:
                    this.switch_box_content_2_title_1 = "";
                    this.switch_box_content_2_title_2 = "";
                    this.switch_box_content_2_title_3 = this.temp;
                    this.switch_box_content_2_title_4 = "";
                    break;
                case 4:
                    this.switch_box_content_2_title_1 = "";
                    this.switch_box_content_2_title_2 = "";
                    this.switch_box_content_2_title_3 = "";
                    this.switch_box_content_2_title_4 = this.temp;
                    break;
            }
        },
        jump_imgpage: function () {
            console.log("跳转图片详情页");
        },
        edit_imglook: function () {
            console.log("修改图片公开");
            // eslint-disable-next-line no-unused-vars
            var mainPage = document.querySelector('.switch_box_content_2_content_1_page_content_box_title');
            if (this.content_box_title == true) {
                this.content_box_title = false;
                console.log('fa');
            } else {
                this.content_box_title = true;
                console.log('t');
            }
            document.addEventListener('click', this.handleClickOutside);
        },

        handleClickOutside: function (event) {
            var mainPage = document.querySelector('.switch_box_content_2_content_1_page_content_box_title');
            var show_btn = document.querySelector('.switch_box_content_2_content_1_page_content_box_img_edit');
            if (!mainPage.contains(event.target) && !show_btn.contains(event.target)) {
                this.content_box_title = false;
                console.log('点击主窗口外部，关闭窗口');
                document.removeEventListener('click', this.handleClickOutside);
            }
        },

        switch_box_content_2_love_show_1_btn: function () {
            console.log('test');
            if (this.switch_box_content_2_love_show_1 == true) {
                this.switch_box_content_2_love_show_2 = true;
                this.switch_box_content_2_love_show_1 = false;
            }
            else {
                this.switch_box_content_2_love_show_1 = true;
                this.switch_box_content_2_love_show_2 = false;
            }
        },
        setpublic_btn: function () {
            if (this.content_box_privacy == false) {
                this.content_box_privacy = true;
                this.setpublic = '设置为公开';
            }
            else {
                this.content_box_privacy = false;
                this.setpublic = '设置为私密';
            }
        },
        setcollection_btn: function () {
            if (this.setcollection == '取消收藏') {
                this.setcollection = '收藏';
                this.switch_box_content_2_love_show_1 = false;
                this.switch_box_content_2_love_show_2 = true;
            }
            else {
                this.setcollection = '取消收藏';
                this.switch_box_content_2_love_show_1 = true;
                this.switch_box_content_2_love_show_2 = false;
            }
        },
        settag_btn: function () {
            console.log('设置标签');
        },
        template() {
            return this.sub_usercenter_model;
        },
        showsubusercenter() {

            var windows_hidth = window.innerHeight;
            console.log(windows_hidth);

            this.timeoutid = setTimeout(() => {
                this.author_introduction_show = true;

            }, 500);
            var sub_windows_hidth = document.querySelector('.switch_box_content_2_content_1_page_content_box_userbox_author_introduction').innerHeight;
            console.log(sub_windows_hidth);
            var test_height = document.querySelector('.sub_main_usercenter').innerHeight;
            console.log(test_height);
        },
        hidesubusercenter() {
            this.timeoutid = setTimeout(() => {
                this.author_introduction_show = false;
            }, 500);

        },

    }
});




