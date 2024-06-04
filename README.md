# m1pro-leafletpicker

Leaflet Robot project uses a robotic hand to pick up a leaflet from fixated slots on a surface and dropping them in a fixed slot position. Purpose of the project is to attract new students to the university.

This project consists of 4 parts:

1. [Graphical user interface implemented in Raspberry PI.](https://github.com/np425/pi-dobot-gui)
2. [Candy physical movement implemented with Dobot robotic hand.](https://github.com/aidasgau/dobotmg400-candypicker)
3. [Leaflet physical movement implemented with Dobot robotic hand.](https://github.com/aidasgau/m1pro-leafletpicker)
4. Electrical wiring connecting both components and providing communication.

This github repository covers the third part of this project.

## Usage

Before using this script, ensure that you have the following:

- [Dobot Studio](https://www.dobot-robots.com/service/download-center) installed.
- Dobot M1 PRO robotic hand set up and connected to Dobot Studio.

1. **Download the Script:**
   Clone or download this repository to your local machine.

   ```bash
   git clone https://https://github.com/aidasgau/m1pro-leafletpicker
Open Dobot Studio:
Launch Dobot Studio on your computer.

Connect Dobot M1 PRO:
Connect your Dobot M1 PRO robotic hand to Dobot Studio.

Load Lua Script:
In Dobot Studio, load the Lua script file (leaflet3.lua).

Run the Script
