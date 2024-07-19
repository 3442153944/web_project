<template>
  <div class="scroll_box">
    <div class="scroll_box_content">
      <div class="btn_box">
        <div class="left_btn" @click="scrollLeft">
          <img :src="props.left_btn" class="icon">
        </div>
        <div class="right_btn" @click="scrollRight">
          <img :src="props.right_btn" class="icon">
        </div>
      </div>
      <div class="item" v-for="(item, index) in props.msg_list" :key="index">
          <div v-if="props.msg_type === 'tags'" class="tags_item" ref="tags_item" @click="chose_item(item)">
            <span>{{ item }}</span>
          </div>
          <div v-if="props.msg_type === 'image'" class="image_item" @click="chose_item(item)">
            <img :src="item" class="image">
          </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, defineProps, defineEmits } from 'vue';

const props = defineProps({
  left_btn: {
    type: String,
    default: 'https://www.sunyuanling.com/assets/left.svg'
  },
  right_btn: {
    type: String,
    default: 'https://www.sunyuanling.com/assets/right.svg'
  },
  msg_type: {
    type: String,
    default: 'image'
  },
  msg_list: {
    type: Array,
    default: () => []
  },
  animationDuration: {
    type: Number,
    default: 1000 // Default animation duration in ms
  },
  scrollDistance: {
    type: Number,
    default: 400 // Default scroll distance in px
  }
});

const colorArr = ref([
  'rgb(126, 183, 200)', 'rgb(126, 186, 200)', 'rgb(157, 200, 126)', 'rgb(200, 126, 170)', 'rgb(200, 126, 146)',
  'rgb(126, 129, 200)', 'rgb(167, 126, 200)', 'rgb(200, 170, 126)', 'rgb(126, 200, 167)', 'rgb(126, 200, 129)'
]);

const tags_item = ref(null);
const scrollBoxContent = ref(null);

const set_tag_color = () => {
  if (tags_item.value) {
    tags_item.value.forEach((item, index) => {
      item.style.backgroundColor = colorArr.value[index % colorArr.value.length];
    });
  }
};

const emit = defineEmits(['chose_item']);
const chose_item = (item) => {
  emit('chose_item', item);
};

const scrollLeft = () => {
  scrollBoxContent.value.scrollBy({
    left: -props.scrollDistance,
    behavior: 'smooth'
  });
};

const scrollRight = () => {
  scrollBoxContent.value.scrollBy({
    left: props.scrollDistance,
    behavior: 'smooth'
  });
};

onMounted(() => {
  set_tag_color();
});
</script>

<style scoped>
.scroll_box {
  width: 100%;
  height: 100%;
  min-height: 30px;
  min-width: 50px;
  display: flex;
  align-items: center;
}

.scroll_box_content {
  width: 100%;
  height: 100%;
  overflow-x: scroll;
  position: relative;
  display: flex;
  align-items: center;
  overflow: hidden;
  min-height: 30px;
  min-width: 50px;
  scroll-behavior: smooth;
}

.btn_box {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  position: absolute;
  left: 0;
  top: 0;
  opacity: 0;
  transition: opacity 0.2s ease-in-out;
}

.scroll_box:hover .btn_box {
  opacity: 1;
}

.left_btn {
  width: 60px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  position: absolute;
  left: 0;
  background: linear-gradient(to right, rgba(255, 255, 255, 0), rgba(255, 255, 255, 1));
}

.right_btn {
  width: 60px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  position: absolute;
  right: 0;
  background: linear-gradient(to left, rgba(255, 255, 255, 0), rgba(255, 255, 255, 1));
}

.icon {
  width: 25px;
  height: 25px;
  object-fit: cover;
}

.item {
  width: auto;
  height: auto;
  display: flex;
  align-items: center;
  gap: 10px;
}

.tags_item {
  width: auto;
  height: auto;
  display: flex;
  align-items: center;
  justify-content: center;
  color: rgba(255, 255, 255, 1);
  cursor: pointer;
  padding: 5px 10px;
  border-radius: 10px;
}

.image_item {
  width: auto;
  height: auto;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border-radius: 15px;
  overflow: hidden;
  min-width: 100px;
  min-height: 80px;
  max-height: 300px;
  max-width: 400px;
}
</style>
