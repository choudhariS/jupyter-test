FROM jupyter/base-notebook:python-3.10

USER root

# System dependencies required by opencv
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgl1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch back to default notebook user
USER ${NB_UID}

# Install Python libraries
RUN pip install --no-cache-dir opencv-python
RUN pip install --no-cache-dir kubernetes
RUN pip install --no-cache-dir swat
RUN pip install --no-cache-dir saspy
RUN pip install --no-cache-dir xgboost
RUN pip install --no-cache-dir scikit-learn
RUN pip install --no-cache-dir matplotlib
RUN pip install --no-cache-dir lightgbm

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
