FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && useradd -m docker
RUN apt install -y --no-install-recommends\ 
	curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

