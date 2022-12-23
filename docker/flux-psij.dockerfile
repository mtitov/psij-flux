FROM fluxrm/flux-sched:latest

# configuration:
#   https://flux-framework.readthedocs.io/en/latest/adminguide.html#configuring-the-flux-system-instance
#   https://flux-framework.readthedocs.io/projects/flux-core/en/latest/man5/flux-config-bootstrap.html
RUN sudo mkdir -p /etc/flux/system && \
    flux broker sudo -u fluxuser flux keygen /tmp/curve.cert && \
    printf '\
[bootstrap] \n\
\n\
curve_cert = "/etc/flux/system/curve.cert" \n\
\n\
[[bootstrap.hosts]] \n\
host = "flux-psij" \n\
bind = "tcp://*:9001" \n\
connect = "tcp://%%h:9001" \n\
[[bootstrap.hosts]] \n\
host = "flux-sched" \n\
' > /tmp/system.toml &&  \
    sudo mv /tmp/curve.cert /tmp/system.toml /etc/flux/system/

RUN sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev  \
    libnss3-dev libssl-dev libreadline-dev libffi-dev

# should be taken from "ExaWorks/SDK/docker/base/scripts"
COPY docker/install-python.sh /home/fluxuser/
RUN sudo /home/fluxuser/install-python.sh "3.7" "alternative" && \
    pip3.7 install --upgrade pip

RUN pip3.7 install cffi pyyaml git+https://github.com/ExaWorks/psij-python.git

USER fluxuser
WORKDIR /home/fluxuser/workdir/
COPY --chown=fluxuser:fluxuser scripts/hello-flux-container.py /home/fluxuser/workdir/
