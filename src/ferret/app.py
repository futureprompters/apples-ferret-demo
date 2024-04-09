import threading
import os
import subprocess
import time

from ferret.utils import print_gpu_info


def run_controller():
    os.system("python -m ferret.serve.controller --host 0.0.0.0 --port 10000")


controller_thread = threading.Thread(target=run_controller)
controller_thread.start()


def run_gradio_web_server():
    os.system(
        "python -m ferret.serve.gradio_web_server --controller http://localhost:10000 --add_region_feature --share"
    )


gradio_web_server = threading.Thread(target=run_gradio_web_server)
gradio_web_server.start()


def run_model_worker():
    os.system(
        "CUDA_VISIBLE_DEVICES=0 python -m ferret.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-path ./model/ferret-7b-v1-3 --add_region_feature"
    )


model_worker = threading.Thread(target=run_model_worker)
model_worker.start()


def run_gpu_monitor():
    while True:
        result = subprocess.run(
            ["nvidia-smi"], capture_output=True, text=True, shell=True
        )
        if result.returncode == 0:
            print(result.stdout)
        else:
            print(f"Error running nvidia-smi: {result.stderr}")
        time.sleep(10)


gpu_monitor_thread = threading.Thread(target=run_gpu_monitor)
gpu_monitor_thread.start()
