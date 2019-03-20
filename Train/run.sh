#### For normal SR test
# python run.py --model=espcn --output_color=RGB --dataset=91-image --labeled=False

# @20181217
# python run.py --model=srcnn --add_custom_callbacks=upsample


#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
### FOR labeled HR and LR images test

#-----------------------------------------------------------
## SRCNN Model
# python run.py --model=srcnn --output_color=GRAY --dataset=texturel --labeled=True #--add_custom_callbacks=upsample

## LOG(@20181204): using the following commands, it output a relatively good test result enhancing the discontinuity of fracutre detection images
# python run.py --model=srcnn --output_color=GRAY --dataset=texturel --infer=d:/Datasets/Discontinuity/ --comment=ep100lr0.01 --labeled=True --epochs=100 # learning rate = 0.01

# @20181214
# python run.py --model=srcnn --output_color=GRAY --dataset=texturel --infer=discont --comment=ep100lr0.01k3 --labeled=True --epochs=100 # learning rate = 0.01
    # epoches=150 learning rate = 0.01 patch_size = 36, k = [11, 7, 7]
# python run.py --model=srcnn --output_color=GRAY --dataset=texturel --infer=discont --comment=ep150lr0.01k11k7k7 --labeled=True --epochs=150 

# python run.py --model=vdsr --output_color=GRAY --dataset=texturel --infer=d:/Datasets/Discontinuity/ --comment=ep100lr0.01 --labeled=True --epochs=100 # learning rate = 0.01

# For infering, also maybe --infer parameter can be included in above command
# python run.py --model=srcnn --dataset=texturel --infer=d:/Datasets/Discontinuity/

# @20181217 k=[9,5,5]
#python run.py --model=srcnn --comment='ep100lr0.01' --labeled=True --infer=d:/Datasets/Textures_manual/discont/

# @20181217 k=[9,3,3]
# python run.py --model=srcnn --comment='ep100lr0.01k3' --labeled=True --infer=d:/Datasets/Textures_manual/discont/
# python run.py --model=srcnn --comment='ep100lr0.01k3' --labeled=True --infer=d:/Datasets/Discontinuity/
# @20190123 do prediction for Interpretation paper
# python run.py --model=srcnn --comment='ep100lr0.01k3' --labeled=True --infer=d:/Datasets/Discontinuity/Dip_Amp_C3_1024_0.2.png
# @20190214 *PREDICTION* do prediction for new fracture dataset
# python run.py --model=srcnn --comment='ep100lr0.01k3' --labeled=True --infer=d:/Datasets/FracTest/time/

# @20181217 k=[9,5,3]
# python run.py --model=srcnn --output_color=GRAY --dataset=texturel --infer=discont --comment=ep100lr0.01k953 --labeled=True --epochs=100
# python run.py --model=srcnn --comment='ep100lr0.01k953' --labeled=True --infer=d:/Datasets/Discontinuity/

# @20181217 k=[9,3,5]
# python run.py --model=srcnn --output_color=GRAY --dataset=texturel --infer=d:/Datasets/Discontinuity/ --comment=ep100lr0.01k935 --labeled=True --epochs=100
# python run.py --model=srcnn --comment='ep100lr0.01k935' --labeled=True --infer=d:/Datasets/Discontinuity/

# @20181229 k=[9,5,5], lr=0.01
# python run.py --model=srcnn --output_color=GRAY --dataset=texturel --infer=d:/Datasets/Discontinuity/ --comment=ep100lr0.01k955_weights --labeled=True --epochs=100
# python run.py --model=srcnn --comment='ep100lr0.01k955_weights' --labeled=True --infer=d:/Datasets/Textures_manual/discont

# @20190104 k=[9,5,5], lr=0.01, dataset=coherence, patch_size=80
# python run.py --model=srcnn --output_color=GRAY --dataset=coherence --infer=d:/Datasets/Discontinuity/ --comment=coh_patch80k955 --labeled=True --epochs=100
# python run.py --model=srcnn --comment='ep100lr0.01k955_weights' --labeled=True --infer=d:/Datasets/Textures_manual/discont

# @20190111 k=[11,9,7], lr=0.01, dataset=coherence, patch_size=80
# python run.py --model=srcnn --output_color=GRAY --dataset=coherence --comment=coh_k11_9_7 --labeled=True --epochs=100
# python run.py --model=srcnn --output_color=GRAY --dataset=coherence --comment=coh_k9_7_3 --labeled=True --epochs=100

# file=./parameters/srcnn.yaml
# for ((i=11; i>=3; i-=2)); do
#     for ((j=11; j>=3; j-=2)); do
#         for ((k=11; k>=3; k-=2)); do
#             # echo $file
#             sed -i "6,6s/- [0-9]*/- $i/" $file
#             sed -i "7,7s/- [0-9]*/- $j/" $file
#             sed -i "8,8s/- [0-9]*/- $k/" $file
#             cmt="coh_k"$i"_"$j"_"$k""
#             python run.py --model=srcnn --output_color=GRAY --dataset=coherence \
#                     --comment=$cmt --labeled=True --epochs=100
#             echo "Process of kernel size "$cmt" complete!"
#         done
#     done
# done

# @20190214 *PREDICTION* do prediction for new fracture dataset
# python run.py --model=srcnn --output_color=GRAY --comment='coh_k9_3_11' --labeled=True --infer=d:/Datasets/FracTest/line/
# python run.py --model=srcnn --output_color=GRAY --comment='coh_k9_5_5' --labeled=True --infer=d:/Datasets/FracTest/line/

#--------------------------------
## ESPCN model
# @20181213 TEST: test espcn model for labeled LR and HR data, with upscale commented.
# Note: with upscale in Escpn.py commented, the following command didn't work
# python run.py --model=espcn --output_color=GRAY --dataset=texturel --infer=d:/Datasets/Discontinuity/ --comment=ep100lr0.01 --labeled=True --epochs=100 # learning rate = 0.01

## VDSR model
# @20181213 NOTE: almost no work
# python run.py --model=vdsr --output_color=GRAY --dataset=texturel --infer=d:/Datasets/Discontinuity/ --comment=ep100r0.01 --labeled=True --epochs=100 # learning rate = 0.01

# NOTE: The following command didn't work @20181213
# python run.py --model=vdsr --dataset=texturel --test=None --infer=d:/Datasets/Discontinuity/ --comment=ep100lr0.01 --labeled=True
