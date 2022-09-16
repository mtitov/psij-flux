FROM fluxrm/flux-sched:latest

RUN sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev  \
    libnss3-dev libssl-dev libreadline-dev libffi-dev

# should be taken from "ExaWorks/SDK/docker/base/scripts"
COPY docker/install-python.sh /home/fluxuser/
RUN sudo /home/fluxuser/install-python.sh "3.7" "alternative" && \
    pip3.7 install --upgrade pip

RUN pip3.7 install cffi pyyaml git+https://github.com/ExaWorks/psi-j-python.git

COPY scripts/hello-flux-container.py /home/fluxuser/
