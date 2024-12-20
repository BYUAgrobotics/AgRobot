#!/bin/bash
# Created by Nelson Durrant, Sep 2024
#
# Starts or enters the tmux session
# - Use 'bash tmux.sh kill' to kill the session

function printInfo {
  echo -e "\033[0m\033[36m[INFO] $1\033[0m"
}

function printWarning {
  echo -e "\033[0m\033[33m[WARNING] $1\033[0m"
}

function printError {
  echo -e "\033[0m\033[31m[ERROR] $1\033[0m"
}

case $1 in
  "kill")
    printWarning "Killing the tmux session..."
    tmux kill-session -t agrobot
    ;;
  *)
    # Check if the tmux session is already running
    if [ -z "$(tmux list-sessions | grep agrobot)" ]; then

      printInfo "Starting the tmux session..."

      # Start the tmux session
      tmux new-session -d -s agrobot
      tmux split-window -h -t agrobot
      tmux split-window -v -t agrobot
      tmux select-pane -t agrobot:0.0
      tmux split-window -v -t agrobot
      tmux select-pane -t agrobot:0.0

      # Send commands to the tmux session
      tmux send-keys -t agrobot:0.0 "bash compose.sh" ENTER
      tmux send-keys -t agrobot:0.0 "cd ~/ros2_ws" ENTER
      tmux send-keys -t agrobot:0.0 "clear" ENTER
      tmux send-keys -t agrobot:0.1 "bash compose.sh" ENTER
      tmux send-keys -t agrobot:0.1 "cd ~/ros2_ws" ENTER
      tmux send-keys -t agrobot:0.1 "clear" ENTER
      tmux send-keys -t agrobot:0.2 "bash compose.sh" ENTER
      tmux send-keys -t agrobot:0.2 "cd ~/ros2_ws" ENTER
      tmux send-keys -t agrobot:0.2 "clear" ENTER
      tmux send-keys -t agrobot:0.3 "bash compose.sh" ENTER
      tmux send-keys -t agrobot:0.3 "cd ~/config" ENTER
      tmux send-keys -t agrobot:0.3 "clear" ENTER

      tmux send-keys -t agrobot:0.0 "bash launch.sh <task>" # Don't start just yet
      tmux send-keys -t agrobot:0.1 "bash test.sh" # Don't start just yet
      tmux send-keys -t agrobot:0.2 "bash init.sh <task>" # Don't start just yet
      tmux send-keys -t agrobot:0.3 "cat vehicle_params.yaml" ENTER

    else
      printInfo "Attaching to the tmux session..."
    fi

    # Attach to the tmux session
    tmux attach-session -t agrobot
    ;;
esac
