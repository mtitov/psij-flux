FROM fluxrm/flux-sched:latest

# configuration:
#   https://flux-framework.readthedocs.io/en/latest/adminguide.html#configuring-the-flux-system-instance
#   https://flux-framework.readthedocs.io/projects/flux-core/en/latest/man5/flux-config-bootstrap.html
RUN sudo mkdir -p /etc/flux/system && \
    flux broker sudo -u fluxuser flux keygen /tmp/curve.cert && \
    sudo mv /tmp/curve.cert /etc/flux/system/ && \
    printf '\
[bootstrap] \n\
\n\
curve_cert = "/etc/flux/system/curve.cert" \n\
default_port = 8050 \n\
default_bind = "tcp://*:%%p" \n\
default_connect = "tcp://%%h:%%p" \n\
\n\
[[bootstrap.hosts]] \n\
host = "flux-psij" \n\
[[bootstrap.hosts]] \n\
host = "flux-extra" \n\
' > /home/fluxuser/system.toml && \
    chmod +x /home/fluxuser/system.toml

RUN sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev  \
    libnss3-dev libssl-dev libreadline-dev libffi-dev

# should be taken from "ExaWorks/SDK/docker/base/scripts"
COPY docker/install-python.sh /home/fluxuser/
RUN sudo /home/fluxuser/install-python.sh "3.7" "alternative" && \
    pip3.7 install --upgrade pip

RUN pip3.7 install cffi pyyaml git+https://github.com/ExaWorks/psi-j-python.git

COPY scripts/hello-flux-container.py /home/fluxuser/
