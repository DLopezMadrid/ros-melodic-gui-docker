FROM osrf/ros:melodic-desktop-full

RUN sudo apt update
RUN apt-get install -y \
    ros-melodic-base-local-planner \
    ros-melodic-clear-costmap-recovery \
    ros-melodic-costmap-2d \
    ros-melodic-move-base-msgs \
    ros-melodic-nav-core \
    ros-melodic-navfn \
    ros-melodic-rotate-recovery \
    ros-melodic-voxel-grid \
    ros-melodic-move-base \
    ros-melodic-gmapping \
    ros-melodic-amcl \
    ros-melodic-teleop-twist-keyboard \
    ros-melodic-map-server 

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
    dbus-x11 \
    pcmanfm

# ======== Install extra stuff for IDE compatibility ========
RUN apt-get install -y \
    gdb \
    curl \
    rsync \
    zsh \
    unzip \
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


# install vscode 
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
RUN sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
RUN sudo apt install apt-transport-https
RUN sudo apt update
RUN sudo apt install code # or code-insiders


# create alias for sourcing ros env on zsh
ENV SHELL /usr/bin/zsh
RUN echo 'alias rs="source /opt/ros/melodic/setup.zsh"' >> ~/.zshrc
RUN echo 'source /opt/ros/melodic/setup.zsh' >> ~/.zshrc
RUN echo 'alias cs="source /root/catkin_ws/devel/setup.zsh"' >> ~/.zshrc
RUN echo 'source /root/catkin_ws/devel/setup.zsh' >> ~/.zshrc
RUN echo 'alias vscode="code --user-data-dir=/root/vscode_dir"' >> ./.zshrc

# start zsh
CMD ["zsh"]
