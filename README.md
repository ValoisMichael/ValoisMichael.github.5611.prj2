<p align="right">
Michael Valois (valoi016)
</p>
<p align="right">
CSCI 5611 Project 2
</p>
<h1 align="center">
Physically-Based Animations
</h1>

Here is my 5611 project 2 page. Below are images from each of my three simulations created for this project. There is a Multi-Rope, 3D Cloth, and Water simulation that are explored below.

<h2 align="center">
Multiple Ropes Simulation
</h2>

<p align="center">
  <img width="800" height="500" src="https://github.com/ValoisMichael/ValoisMichael.github.5611.prj2/assets/85034605/509534af-8494-411f-8f65-ab608d73b834">
</p>

<h2 align="center">
Cloth Simulation
</h2>

<p align="center">
  <img width="800" height="500" src="https://github.com/ValoisMichael/ValoisMichael.github.5611.prj2/assets/85034605/70ea66bf-c007-42d4-9612-b05cc282a5d8">
</p>

<h2 align="center">
SPH Water Simulation
</h2>

<p align="center">
  <img width="800" height="400" src="https://github.com/ValoisMichael/ValoisMichael.github.5611.prj2/assets/85034605/ea0d739e-5f28-4bcb-9c2b-f8acba0c3f52">
</p>

# Video Link
https://youtu.be/P6YiePL7Ork

(These timestamps are also listed in the description of the video)
| Feature  | Time Stamp |
| ------------- | ------------- |
| Multiple Ropes | 0:05 |
| Cloth Simulation | 0:42 |
| 3D Simulation  | 0:53 |
| High-quality Rendering  | 1:08 |
| Air Drag for Cloth  | 1:30 |
| User Interaction  | 3:10 |
| SPH Fluid Simulation  | 3:25 |

<br>

# Features

### Multiple Ropes (0:05)
Using the base rope I made in homework 2, I was able to adapt it into a multi-rope simulation. I also added a circle to the scene and gave the ropes collision with the sphere. The ropes are affected by gravity, swing, and accurately collide with the sphere. 

<br>

### Cloth Simulation (0:42)
Foe the cloth simulation, I was able to chain together points and connect them using arrays. Each square in the cloth is made of two triangels. The links all have slight elasticity to give the cloth a more realistic efect. The sphere was added to the scene to help demonstrate the cloth's physicis as wel as add an interactive part to the cloth.

<br>

### 3D Simulation (0:53)
The rendering of the 3D cloth uses the base 3D camera functions given by Processing. The camera uses WASD for tilt and Y position and Arrow keys for X and Z position.

<br>

### High-quality Rendering (1:08)
High-qualtiy render added lighting and texture to the scene. The lighting uses basic pointLight to simulate an overhead light source pointing down. I drew up a simple texture in Aseprite for the cloth.

<br>

### Air Drag for Cloth (1:30)
The cloth scene has a "fan" added blowing from behind the cloth. It has an adjustable speed which is demonstarted in the video.

<br>

### User Interaction (3:10 )
For the ropes, each rope can be clicked and dragged with the mouse. The sphere in the cloth scene is controlable with 5, 1, 2, 3 on the numpad. When the mouse is click in the water simulation, new particles are spawned in.

<br>

### SPH Fluid Simulation (3:25)
The SPH simulation uses the main SPH calculations discussed in lecture. With both pressures accounted for, each water particle is given a specific shade of blue depending on the pressure it is recieving. Low pressure yields whiter particles while high pressure yields bluer particles. This is in hopes to mimic actual water.

# Code

Github link: https://github.com/ValoisMichael/ValoisMichael.github.5611.prj2

All code was written by me.

# Tools

Resources Used:
* I used the lecture slides, labs, and notes from class.
* I used this website for understand a lot of the 3D functionality in Processing: https://processing.org/reference
* I also used Aseprite for creating the cloth texture: https://www.aseprite.org/

I used no extra libraries

# Difficulties
The rope simulation was pretty straight forward; I was prepped from the second homework to effectivly add more ropes. The cloth on the other hand was trickier. Mainly geting the ellasticity to a spot where the cloth held together after collisions with the sphere and didn't sag, but didn't compress in on itself. There was a fiar amount of time getting it just right, and I think the finished product turned out good.

In regards to the water simulation, the hardest part was going through and tweaking each attribute until I had the simulation looking and acting how I wanted it. The patricle's size, density area, and viscosity were the parts most experimented with. Also adding the color map to the pressure of each particle took a while to get how I wanted it.

 <br>
 
# Art Contest:
<p align="center">
   Here is my submission for the art contest. Here we can see the sphere is peaking out from behind the curtain.
</p>
<p align="center">
  <img width="800" height="500" src="https://github.com/ValoisMichael/ValoisMichael.github.5611.prj2/assets/85034605/70ea66bf-c007-42d4-9612-b05cc282a5d8">
</p>
