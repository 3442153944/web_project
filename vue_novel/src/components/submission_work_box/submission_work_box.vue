<template>
    <div class="submission_work_box_page">
        <div class="submission_work_box_item">
            <div class="submission_work_box_icon"><svg data-v-9c5ff6ae="" t="1713671593616" class="icon"
                    viewBox="0 0 1128 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="11605" width="200"
                    height="200">
                    <path data-v-9c5ff6ae=""
                        d="M165.789 99.167h783c22.5 0 40.5 18 40.5 40.5v319.5c-40.5-31.5-117-81-175.5-81-85.5 0-162 198-256.5 198-72-4.5-171-85.5-283.5-72-45 9-108 81-148.5 135v-499.5c0-22.5 18-40.5 40.5-40.5zM354.788 423.167c-36 0-67.5-13.5-90-36s-36-58.5-36-90c0-31.5 13.5-67.5 36-90 22.5-22.5 54-36 90-36 31.5 0 63 13.5 90 36 22.5 22.5 36 58.5 36 90 0 31.5-13.5 67.5-36 90-27 22.5-58.5 36-90 36zM971.288 40.667h-828c-45 0-81 36-81 81v738c0 45 36 81 81 81h828c45 0 81-36 81-81v-738c0-45-36-81-81-81z"
                        p-id="11606"></path>
                </svg></div>
            <div class="submission_work_box_text">插画</div>
        </div>
        <div class="submission_work_box_item">
            <div class="submission_work_box_icon"><svg t="1713690598752" class="icon" viewBox="0 0 1024 1024"
                    version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="36083" width="200" height="200">
                    <path
                        d="M512 64C264.6 64 64 264.6 64 512s200.6 448 448 448 448-200.6 448-448S759.4 64 512 64z m170.7 464.9c-2.6 4.2-6.1 7.7-10.2 10.2l-197 122.2c-15 9.3-34.7 4.7-44.1-10.3-3.1-5-4.7-10.7-4.8-16.5v-245c0.2-17.7 14.6-31.9 32.3-31.7 5.8 0.1 11.6 1.7 16.5 4.8L672 485.1c14.9 9.2 19.7 28.7 10.7 43.8z"
                        fill="#4C4C4C" p-id="36084"></path>
                </svg></div>
            <div class="submission_work_box_text">动图</div>
        </div>
        <div class="submission_work_box_item">
            <div class="submission_work_box_icon"><svg data-v-9c5ff6ae="" t="1713671802104" class="icon"
                    viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="12786" width="200"
                    height="200">
                    <path data-v-9c5ff6ae=""
                        d="M820.585833 97.34249v597.899208c0 60.511975-49.010227 109.522202-109.522202 109.522202H124.154982a51.118881 51.118881 0 0 0-51.118881 51.118881v14.185489a51.118881 51.118881 0 0 0 51.118881 51.118881H838.98863c40.256119 0 73.036101-3.067133 73.036101-43.38715V56.702979a55.208391 55.208391 0 1 1 110.352884 0v874.388455c0 47.284965-50.479895 92.780769-90.799912 92.780769H73.036101A73.036101 73.036101 0 0 1 0 950.836102V74.530689C0 34.210672 32.716084 1.494588 73.036101 1.494588h651.765729a95.847901 95.847901 0 0 1 95.847901 95.847902zM416.874472 256.450006a118.915296 118.915296 0 1 0-166.775348 166.775348l-0.638986 0.638986 122.940908 123.068706a63.898601 63.898601 0 0 0 90.41652 0L585.822373 423.86434l-0.702884-0.638986a118.915296 118.915296 0 1 0-166.775349-166.775348l-0.702884-0.766783-0.766784 0.702884z"
                        fill="#7A818A" p-id="12787"></path>
                </svg></div>
            <div class="submission_work_box_text">漫画</div>
        </div>
        <div class="submission_work_box_item">
            <div class="submission_work_box_icon"><svg data-v-9c5ff6ae="" t="1713671839534" class="icon"
                    viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="14954" width="200"
                    height="200">
                    <path data-v-9c5ff6ae="" d="M320 64h576v768H320z" fill="#47444F" p-id="14955"></path>
                    <path data-v-9c5ff6ae=""
                        d="M184.6 896c0-64 29.4-64 56.7-64H256V64h-64c-35.4 0-64 28.6-64 64v768c0 35.4 28.6 64 64 64h704v-64H184.6z"
                        fill="#47444F" p-id="14956"></path>
                </svg></div>
            <div class="submission_work_box_text">小说</div>
        </div>
    </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
    name: 'submission_work_box',
}
</script>

<script setup>

</script>

<style scoped>
.submission_work_box_page {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
}

.submission_work_box_item {
    display: flex;
    margin-top: 10px;
    width: 98%;
    height: 40px;
    padding: 5px;
    margin-left: auto;
    margin-right: auto;
    align-items: center;
}

.submission_work_box_item:hover {
    background-color: rgba(184, 184, 184, 0.7);
    cursor: pointer;
    transition: 0.2s;
    border-radius: 5px;
}

.submission_work_box_icon {
    width: 30px;
    height: 30px;
    overflow: hidden;
    margin-left: 5px;
    margin-right: 10px;
}

.submission_work_box_icon svg {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
