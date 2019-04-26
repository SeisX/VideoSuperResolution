# 学习实践记录
- 项目安装
    1. 在GitRepo目录下clone VideoSuperResolution代码
    2. 以管理员权限打开terminal，使用 **pip install -e .** 命令安装VSR，这样该工程执行中进行import就能够找到VSR了

- 模型训练
    1. 准备数据，下载各种datasets保存到d盘Datasets路径下
    2. 使用python train.py srcnn --batch=128执行模型训练，默认情况下需要有91-image数据

- 实际操作
    1. VDSR超分辨率，Interpretation论文
        - @20190423：python train.py vdsr --dataset=FRACTURE --scale=2 --epochs=500 --batch=64 --comment=fracture
            > 当batch从16变为64时，计算时间增加3到4倍

## 注意事项
- TensorFlow版本

    Source code基于TensorFlow 1.10版本，所以在正确运行该项目之前，需要首先对TensorFlow进行版本升级，从1.4升级到1.10
    - 由于所用TensorFlow版本是GPU版本，所以在使用 **pip install --upgrade tensorflow-gpu** 的同时，还需要升级Cuda以及cuDNN的版本
    - Windows上非常简单，直接将原有的Cuda8.0版本卸载，并安装Cuda9.0
    - 然后下载对应的cuDnn7.2.1版本，解压替换原来6.*版本的cuDNN即可。