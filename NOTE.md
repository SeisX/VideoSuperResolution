# 学习实践记录
- 项目安装
    1. 在GitRepo目录下clone VideoSuperResolution代码
    2. 以管理员权限打开terminal，使用 **pip install -e .** 命令安装VSR，这样该工程执行中进行import就能够找到VSR了

- 模型训练
    1. 准备数据，下载各种datasets保存到d盘Datasets路径下
    2. 使用python train.py srcnn --batch=128执行模型训练，默认情况下需要有91-image数据
    3. 根据LoSealL后续更新，在201811月份版本中，项目的执行文件修改为run.py

## 架构设计
### 调用结构
- 执行文件：run.py (Train/run.py)
- 参数解析：对tf.flags.FLAGS中定义的参数进行解析，包括输入输出、运算控制等参数，其中训练数据由Data/datasets.yaml文件提供，可以获取不同图片数据集名称及路径等
    - 准备网络模型
    - 获取训练、测试、预测数据
    - 获取训练、测试、预测参数
- 机器学习网络训练 (model相对应对的trainer，见VSR/Framework/Trainer.py)
    - 利用QuickLoader加载图片数据到内存
    - 训练：trainer.fit
    - 验证：trainer.benchmark
    - 预测：trainer.infer
    - 输出：trainer.export

---
### 功能组件 (VSR/Util/)
#### Config.py
> Parse configuration from multiple sources
- class Config(easydict.EasyDict)
    > 继承自easydict.EasyDict类
    - 从json或yaml文件中解析参数

#### ImageProcess.py
> Image processing tools

---
### 数据接口 (VSR/DataLoader/)
#### VirtualFile.py
> virtual file is an abstraction of a file or a collection of ordered frames

- class File
    > An abstract file object

- class RawFile(File)
    > 继承自File类

    > For reading raw files. The file is lazy loaded, which means the file is opened but not loaded into memory at initialization.

- *list* _ALLOWED_RAW_FORMAT 
    > Supported RAW format

- class ImageFile(File)
    > 继承自File类

    > Open image file or a sequence of image frames

#### Dataset.py
> offline dataset collector, support random crop

- class Dataset(Config)
    > 继承自Config

    > Dataset provides training/validation/testing data for neural network.

#### Loader.py
- Class
    - class EpochIterator
        > An iterator for generating batch data in one epoch
    
        用于生成HR与LR图像数组及名字，被BasicLoader与QuickLoader中的make_one_shot_iterator函数调用并返回

    - class BasicLoader 
        > Basic loader in single thread
    - class QuickLoader(BasicLoader)
        > Async data loader with high efficiency

- 关联
    - Loader需要调用Config类，解析数据参数文件，例如srcnn.yaml

---
### 网络框架 (VSR/Framework)
> 提供SuperResolution的基类网络结构，以及网络训练的通用模块

#### LayersHelper.py
> commonly used layers helper
- class Layers(object)
    > 对卷积神经网络所用到的基本网络层进行封装定义，并提供一些基本的操作
    - batch_norm
    - conv2d
    - conv3d
    - deconv2d
    - deconv3d
    - dense
    - resblock
    - resblock3d


#### SuperResolution.py
> Framework for network model (tensorflow)
- class SuperResolution(Layers)
    > A utility class helps for building SR architectures easily
    - **train_batch**
        > training one batch one step.
    - 
- class SuperResolutionDisc(SuperResolution)
    > SuperResolution with Discriminator. 用于GAN网络

#### Trainer.py
> Extend the pre-Environment module, provide different and extensible training methodology for SISR, VSR or other image tasks.
- class Trainer
    > A pure interface trainer

- class VSR(Trainer)
    > Default trainer for task SISR or VSR
    - fit
    - infer
    - benchmark
    ---
    - fn_train_each_epoch
    - fn_train_each_step
    - fn_infer_each_step
    - fn_benchmark_each_step
    - fn_benchmark_body

#### Callbacks.py
> Training environment callbacks preset

---
### 网络模型 (VSR/Models)
> 实现不同SuperResolution CNN模型，这些网络模型都是派生于基类**SuperResolution**


## 注意事项
- TensorFlow版本

    Source code基于TensorFlow 1.10版本，所以在正确运行该项目之前，需要首先对TensorFlow进行版本升级，从1.4升级到1.10
    - 由于所用TensorFlow版本是GPU版本，所以在使用 **pip install --upgrade tensorflow-gpu** 的同时，还需要升级Cuda以及cuDNN的版本
    - Windows上非常简单，直接将原有的Cuda8.0版本卸载，并安装Cuda9.0
    - 然后下载对应的cuDnn7.2.1版本，解压替换原来6.*版本的cuDNN即可。

- VSCode调试

    - **存在问题**：使用默认VSCode配置文件，调试的当前路径是VideoSuperResolution，而run.py位于当前路径的Train子路径下，导致程序中无法根据相对路径获取数据集参数的配置文件，调试无法进行
    - **解决方式**：修改.vscode下*launch.json*调试配置文件，以当前所用的Current File类型调试器为例，添加cwd控制参数，设置调试器的当前工作目录为"<u>cwd</u>": "${workspaceFolder}/Train"，然后调试能够正常进行。

## 测试Examples
### SRCNN
- Logs 
> (@20181204): using the following commands, it output a relatively good test result enhancing the discontinuity of fracutre detection images

- Commands
    ```
    python run.py --model=srcnn --output_color=GRAY --dataset=texturel --infer=d:/Datasets/Discontinuity/ --comment=ep100lr0.01 --labeled=True --epochs=100 # learning rate = 0.01
    ```
    
- Performances

![in](./Results/srcnn_ep100lr0.01/dataset/pic_295_in.jpg "Instance")
![out](./Results/srcnn_ep100lr0.01/dataset/pic_295_out.jpg "Label")

尝试了不同参数进行测试

下图参数：k = [9,3,3]

![prd](./Results/srcnn_ep100lr0.01k3/TEXTUREL/pic_295_in_PR.png "Prediction")


下图参数：k = [9,5,5]

![prd](./Results/srcnn_ep100lr0.01k955_weights/TEXTUREL/pic_295_in_PR.png "Prediction")

下图参数：k = [11,7,7]

![prd](./Results/srcnn_ep150lr0.01k11k7k7/TEXTUREL/pic_295_in_PR.png "Prediction")

## 待办事项
### @20181204
- [x] infer操作不受控制
    - @20181217，对于超分辨率学习，srcnn可以正常infer，但是对于有标定的连续性学习，无法infer，需要关注VSR.infer函数定义及其传入的参数
        > 经过测试，主要由于infer函数传入的loader对象导致，对于QuickLoaderL，其中的_read_files及其他函数都有进行修改，包含了file_objects与infile_objects，而infer时只需要有file_objects就可以。
        > **解决方案**：infer函数传入的loader对象不使用QuickLoaderL，而是使用QuickLoader。
- [ ] 除SRCNN及VDSR外，其他模型数据准备存在问题，可能与upsample的现象有关
    - @20181213，初步猜测受LayersHelper.upscale操作影响，Espcn、Carn等网络中都有调用
        > 经初步测试Espcn网络，仅注释掉upscale语句，并不能解决问题