<template>
    <div>
      <Bar :data="chartData" :options="chartOptions" />
    </div>
  </template>
  
  <script setup>
  import { defineComponent, ref } from 'vue';
  import { Bar } from 'vue-chartjs';
  import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend } from 'chart.js';
  
  // 注册 Chart.js 组件
  ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend);
  
  // 图表数据和选项
  const chartData = ref({
    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
    datasets: [
      {
        label: '数据分析1',
        backgroundColor: '#42A5F5',
        data: [40, 39, 10, 40, 39, 80, 40]
      },
      {
        label: '数据分析2',
        backgroundColor: '#FF6384',
        data: [30, 29, 20, 50, 49, 70, 60]
      }
    ]
  });
  
  const chartOptions = ref({
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
      tooltip: {
        callbacks: {
          label: function (tooltipItem) {
            return tooltipItem.dataset.label + ': ' + tooltipItem.raw;
          }
        }
      }
    }
  });
  </script>
  
  <style scoped>
  /* Add styles here */
  </style>
  