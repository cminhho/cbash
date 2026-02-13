# ==============================
# Docker Helpers
# ==============================

# Function to list all running containers with their names and IDs
docker_running() {
    docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Image}}"
}

# Function to stop all running containers
docker_stop_all() {
    docker stop $(docker ps -q)
    echo "All running containers stopped."
}

# Function to remove all stopped containers
docker_remove_stopped() {
    docker rm $(docker ps -a -q)
    echo "All stopped containers removed."
}

# Function to remove all unused images
docker_remove_unused_images() {
    docker image prune -a -f
    echo "All unused images removed."
}

docker_kill_all() {
    echo "Performing action 'kill all services'"

    docker ps -a -q | xargs -n 1 -P 8 -I {} docker stop {} || echo "No running docker containers are left"
    docker kill $(docker ps -q) || echo "No running containers to kill"
    docker rm $(docker ps -a -q) || echo "No running containers to remove"
    docker volume rm $(docker volume ls -q) || echo "No volumes to remove"

    echo "Successfully killed all services"
}