# iphone_mqtt_controller
A simple iOS app that communicates with an MQTT network to control lighting functions, over local network or the internet. 
Related to [this LED project.](https://github.com/bodhiconnolly/mqtt_home_control)

## How it works
Singleton data class that sends/receives MQTT messages. View controller that processes user input. All server settings are easily changeable to suit your needs.