## README

首先实现E_BLIND/D_LC系统

```
code
│   README.md
│   
└───data
│   data1.mat -------------------------用于存储实验1生成的水印 
│                                  _
│   accu_plot.mat                   |
│   false_neg_plot.mat              |
│   false_pos_plot.mat              |----灰度截断实验画图数据
│   accu_notruncation_plot.mat      |       
│   false_notruncationneg_plot.mat  |
│   false_notruncationpos_plot.mat _|
│  
└───input -------------------------图像数据集  
└───watermark ---------------------实验2生成的40个不同水印
└───watermark_800 -----------------灰度截断实验生成的40个不同水印   
|
│   D_LC.m ------------------------D_LC算法
│   E_BLIND.m ---------------------E_BLIND算法
│   calculate_30gray.m ------------输出黑白像素值比例小于30%的图
│   calculate_50gray.m ------------输出黑白像素值比例大于50%的图
│   False_posneg.m ----------------计算accuracy,false pos/neg rate
│   watermark_generate.m ----------水印生成
│   main.m ------------------------实验1，同一张水印嵌入不同图
│   main2.m -----------------------实验2，同一张图（黑白像素值<30%）嵌入不同水印
│   main3.m -----------------------实验3，同一张图（黑白像素值>50%）嵌入不同水印
│   gray8bit.m --------------------灰度截断，取两幅图进行对比
│   pedict.m ----------------------根据输入图像和水印返回accu，false pos/neg
│   main4.m -----------------------灰度截断，不同图像、水印分别实现灰度截断/不截断
│   plot8bittruncation.m ----------灰度截断，不同图像截断/不截断准确率对比图
```

