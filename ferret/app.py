import asyncio
import threading
import os

def run_controller():
    os.system("python -m ferret.serve.controller --host 0.0.0.0 --port 10000")

controller_thread = threading.Thread(target=run_controller)
controller_thread.start()

def run_gradio_web_server():
    os.system("python -m ferret.serve.gradio_web_server --controller http://localhost:10000 --model-list-mode reload --add_region_feature")

gradio_web_server = threading.Thread(target=run_gradio_web_server)
gradio_web_server.start()

def run_model_worker():
    os.system("CUDA_VISIBLE_DEVICES=0 python -m ferret.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-path ./model/ferret-7b-v1-3 --add_region_feature")

model_worker = threading.Thread(target=run_model_worker)
model_worker.start()
