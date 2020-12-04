FROM osrf/ros:melodic-desktop-full

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# avoid user interaction requests during installation
RUN DEBIAN_FRONTEND=noninteractive
RUN sudo apt update
RUN DEBIAN_FRONTEND=noninteractive apt-get install keyboard-configuration -y

# install nvidia drivers
RUN sudo apt update
RUN sudo apt install software-properties-common -y
RUN sudo add-apt-repository ppa:graphics-drivers 
RUN sudo apt install nvidia-driver-450 -y

# ======== Installing productivity tools ========
RUN apt-get install -y \
    sudo \
    vim \
    terminator \
    dbus \
    dbus-x11

# ======== Install extra stuff for IDE compatibility ========
RUN apt-get install -y \
    gdb \
    curl \
    rsync \
    zsh \
    openssh-server


# ======== start ssh ============
RUN ssh-keygen -A  && service ssh start

# ======== install sublime text ==========
RUN wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
RUN sudo apt-get install apt-transport-https
RUN echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
RUN sudo apt-get update
RUN sudo apt-get install sublime-text -y

# ========== install oh my zsh ===============

# the user we're applying this too (otherwise it most likely install for root)
USER $USERNAME
# terminal colors with xterm
ENV TERM xterm
# set the zsh theme
ENV ZSH_THEME agnoster

# run the installation script  
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# start zsh
CMD [ "zsh" ]

# create ros entry point
RUN touch ~/zsh_ros_entrypoint.sh
RUN echo '#!/usr/bin/zsh' >> ~/zsh_ros_entrypoint.sh
RUN echo 'set -e' >> ~/zsh_ros_entrypoint.sh
RUN echo 'source "/opt/ros/melodic/setup.zsh"' >> ~/zsh_ros_entrypoint.sh
RUN echo 'exec "$@"' >> ~/zsh_ros_entrypoint.sh
RUN sudo chmod +x ~/zsh_ros_entrypoint.sh
RUN ~/zsh_ros_entrypoint.sh