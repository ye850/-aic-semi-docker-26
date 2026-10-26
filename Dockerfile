# 半决赛复现镜像 —— 仅含运行环境，不含数据/代码/模型（按要求从宿主机挂载）
# 基座：官方 PyTorch runtime（无开发工具/样例，比 devel 版小很多）
FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-runtime

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    HF_HUB_OFFLINE=1 \
    TRANSFORMERS_OFFLINE=1

# 只补项目实际缺的三件（torch / numpy / Pillow 基座自带）
RUN pip install --no-cache-dir \
      transformers==5.20.2 \
      pandas==3.1.0 \
      scikit-learn==1.9.1

WORKDIR /workspace
# 说明：数据、代码、权重一律不打进镜像，运行时用 -v 挂载：
#   docker run --gpus all -v <宿主机>/data:/workspace/data \
#              -v <宿主机>/src:/workspace/src -v <宿主机>/scripts:/workspace/scripts \
#              -v <宿主机>/models:/workspace/models  <镜像>  <命令>
