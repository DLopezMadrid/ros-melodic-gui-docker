XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# allow x server connection
xhost +local:root

# to set up the right environment variables in CLion
echo "Set \$DISPLAY parameter to $DISPLAY" 

docker start ros-docker-nv-mk2
docker exec ros-docker-nv-mk2 /usr/bin/zsh -c '~/zsh_ros_entrypoint.sh' 
docker attach ros-docker-nv-mk2 

# disallow x server connection
xhost -local:root
