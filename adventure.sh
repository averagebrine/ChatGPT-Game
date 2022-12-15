#!/bin/bash

# Set the initial position of the player and enemies
player_x=1
player_y=1

enemy1_x=9
enemy1_y=8

enemy2_x=8
enemy2_y=9

# Set the position of the goal tile
goal_x=10
goal_y=10

# Set the game over and win messages
game_over_message="Game Over"
win_message="You Win!"

# Set the size of the grid
grid_width=10
grid_height=10

# Function to move the enemies
move_enemies() {
  # Move enemy 1
  ((enemy1_x += RANDOM % 3 - 1))
  ((enemy1_y += RANDOM % 3 - 1))

  # Make sure the enemy stays within the bounds of the grid
  if [ $enemy1_x -lt 1 ]; then
    ((enemy1_x++))
  elif [ $enemy1_x -gt $grid_width ]; then
    ((enemy1_x--))
  fi
  if [ $enemy1_y -lt 1 ]; then
    ((enemy1_y++))
  elif [ $enemy1_y -gt $grid_height ]; then
    ((enemy1_y--))
  fi

  # Move enemy 2
  ((enemy2_x += RANDOM % 3 - 1))
  ((enemy2_y += RANDOM % 3 - 1))

  # Make sure the enemy stays within the bounds of the grid
  if [ $enemy2_x -lt 1 ]; then
    ((enemy2_x++))
  elif [ $enemy2_x -gt $grid_width ]; then
    ((enemy2_x--))
  fi
  if [ $enemy2_y -lt 1 ]; then
    ((enemy2_y++))
  elif [ $enemy2_y -gt $grid_height ]; then
    ((enemy2_y--))
  fi
}

# Draw the grid and player
draw_grid() {
  for ((y=1; y<=grid_height; y++)); do
    for ((x=1; x<=grid_width; x++)); do
      if [ $x -eq $player_x ] && [ $y -eq $player_y ]; then
        printf "P "
      elif [ $x -eq $enemy1_x ] && [ $y -eq $enemy1_y ]; then
        printf "E "
      elif [ $x -eq $enemy2_x ] && [ $y -eq $enemy2_y ]; then
        printf "E "
      elif [ $x -eq $goal_x ] && [ $y -eq $goal_y ]; then
        printf "G "
      else
        printf ". "
      fi
    done
    printf "\n"
  done
}

# Check if the player has won or lost the game
check_game_status() {
  if [ $player_x -eq $goal_x ] && [ $player_y -eq $goal_y ]; then
    # Player has reached the goal tile
    echo $win_message
    exit
  elif [ $player_x -eq $enemy1_x ] && [ $player_y -eq $enemy1_y ]; then
    # Player has touched an enemy
    echo $game_over_message
    exit
  elif [ $player_x -eq $enemy2_x ] && [ $player_y -eq $enemy2_y ]; then
    # Player has touched an enemy
    echo $game_over_message
    exit
  fi
}

# Clear the screen and draw the grid
clear
draw_grid

# Continuously read input from the user and move the player
while true; do
  read -s -n 1 key
  case $key in
    w) ((player_y--))
       if [ $player_y -lt 1 ]; then
         ((player_y++))
       fi ;;
    a) ((player_x--))
       if [ $player_x -lt 1 ]; then
         ((player_x++))
       fi ;;
    s) ((player_y++))
       if [ $player_y -gt $grid_height ]; then
         ((player_y--))
       fi ;;
    d) ((player_x++))
       if [ $player_x -gt $grid_width ]; then
         ((player_x--))
       fi ;;
  esac
  clear
  move_enemies
  draw_grid
  check_game_status
done
