# Docker

sudo yum update -y
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
docker --version
sudo service docker start

docker image build -t fmerger .
docker run -it --rm -v $(pwd):/home fmerger /bin/bash

# Downloads
cd home

git clone https://github.com/apple/ml-ferret.git
git clone https://huggingface.co/lmsys/vicuna-7b-v1.3
git clone https://huggingface.co/liuhaotian/llava-336px-pretrain-vicuna-7b-v1.3
curl -o ferret-7b-delta.zip https://docs-assets.developer.apple.com/ml-research/models/ferret/ferret-7b/ferret-7b-delta.zip
unzip ferret-7b-delta.zip

# Ferret

cd ml-ferret
pip install .
mkdir -p model/model/llava-336px-pretrain-vicuna-7b-v1-3
cp ../llava-336px-pretrain-vicuna-7b-v1.3/mm_projector.bin model/llava-336px-pretrain-vicuna-7b-v1-3/

python -m ferret.model.apply_delta --base ../vicuna-7b-v1.3/ --target ./model/ferret-7b-v1-3 --delta  ../ferret-7b-delta

export AWS_ACCESS_KEY_ID=<your key>
export AWS_SECRET_ACCESS_KEY=<your secret>
aws s3 sync ./model/ferret-7b-v1-3/ s3://future-prompters/ferret/ferret-7b-v1-3 