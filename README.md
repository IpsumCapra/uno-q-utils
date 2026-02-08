# Arduino UNO Q Development Utils

## Who is this for?

At the time of writing (07/02/2026) the 'preferred' way of programming the UNO Q is with arduino app lab, or the `arduino-app-cli` command.
If you, like me, think these commands are poorly documented, offer little to no transparency, and seem slow and bloated, my utils may be something for you.

These utils are made for people who feel comfortable using the terminal, docker and platforms like `platformio`,
and offer more freedom and versatility when developing for the UNO Q.

## Requirements

On the development machine:

- `arduino-cli`
- `rsync`

While optional, I recommend you to add your SSH key to the uno-q for easy login.
Suffices to say you need to be able to SSH to your UNO Q for the sync features of this util set to work.

## What is included

### Containers

Two simple docker containers which provide the bare necessities of running apps on the UNO Q.
The base image includes version 0.7.0 of the official `arduino_app_bricks` wheel.
Compared to version 0.7.0, the containers included are less than half their official counterparts' size. (290MB vs 770MB)

After having created a python app using either `create-app` or `create-project` you may tell the Dockerfile to install additional wheels using requirements.txt inside of the app's folder.

### Commands

The heart of the uno-q-utils, streamlining your development process:

- `create-sketch <name>` Creates a sketch using the template in this repository.
- `create-app <name>` Creates a python app using the template in this repository.
- `create-project <name>` Creates a project with a template python app and sketch.
- `compile [name]` May be used from the project directory, or the path to your sketch may be passsed. Will compile the sketch for the unoq target.

**The following commands only work locally on the UNO Q:**

- `upload [name]` Same as with compile, but also uploads the sketch to the MCU of the UNO Q.
- `start-app [name]` May be used from the project directory, or the path to your app may be passed. Will create and start a docker container with your app.
- `stop-app [name]` May be used from the project directory, or the path to your app may be passed. Will stop and destroy the specified docker container.

**The following commands only work on your development machine:**

- `sync-up [name]` Uses rsync to upload your project to `~/Development/<project name or specified folder>`.
- `sync-down [name]` Uses rsync to download a projet from `~/Development/<project name or specified folder>`.

## Example usage

To begin using the included commands, clone this repository on your development machine, and `source` `env.sh`.
You may have to alter env.sh to reflect the username and hostname you wish to use to conenct to your UNO Q.
_In general I recommend you to read through env.sh to get a feeling for how the utils work!_

**Sync this repository to the UNO Q:**

- Navigate to the repository folder.
  `sync-up`
  Sync up called without arguments will upload the directory you are currently in to `~/Development/<dir>` on the UNO Q.

**Create a new project:**

`create-project my-project`
This will create a folder in the current directory named `my-project` containg a template python app and sketch.

**Create and compile a standalone sketch**

- `create-sketch blink`
- `compile blink` or `compile .` when inside of the folder.

---

Other commands work in the same vein as the examples mentioned above.
I once again recommend you to read env.sh to really get a feel for how to take control of manually uploading apps and sketches on the UNO Q.

## Disclaimer

I made these tools for my environment, and do not guarantee they will work for you.
I use these utils in conjunction with a venv containing the official `arduino_app_bricks` wheel, and develop on NeoVim with custom config.

Please do not create issues asking for environment specific help. They will be closed.
