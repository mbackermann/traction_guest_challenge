# Traction Guest Tracking (Challenge)

### About the Project

Possible improvements for Traction Guest:

Tracking guests inside client's premises:
Ways of implementation:
Using wireless devices, like BLE (Bluetooth Low Energy) devices, or proprietary protocols, like NordicSemi [1] or HopeRF [2] SOCs (System-On-Chip).
Using computer vision.

The implementation would be made around thre components:
Wireless system:
Wireless name tags (one for each guest) with a low power transmitter, transmitting the tag ID/serial number. This ID is associated to the guest own ID.
A set of receivers installed around the premises, tunned to the same frequency of the name tag transmitters. Each receiver would then transmit its own ID, coupled with the devices' IDs it can "see", and their receiving signal power level. This info is then sent to a backend via a HTTP POST request, for database storing and processing. Some receivers

Computer Vision:
The guest image (or picture) is inserted on the system, together with his/her data. Then, a set of cameras deployed around the areas to be covered tracks the guest around by using computer vision. The camera could be coupled to a embedded computer module (as Raspbery Pi W Zero, or similar) or an Android/IOS device. The device would run the CV algorithm and send (POST) the results to the backend. Also, maybe a feedback can be provided by the device (using its own screen or by a HDMI screen connected).

Backend (for both methods):
The backend would consist of a HTTP server, receiving the POST requests provided by the sensors (beying them Wireless or CV), storing the data on a database and providing feedback, if apropriate.

Going further:
The system could be used for controlling/directing the guest as he walks around the place:
Using panels with the guest name and arrows pointing the right direction to follow.
Unlocking doors, to enforce proper access control. The locking system should be in a way that could be opened easily from inside (if thats fits), and would unlock automatically in case of power outages, like in a fire or other emergency(again, if thats fits) [3]. For features like that, a magnetic lock [4] could be used.
Generating an alert if some one is on an prohibited area (to avoid tailgating/piggybacking) [5]
Some method of authentication between the sensors/name tags and the receivers, and the receivers and the backend should be implemented, to avoid someone from tampering with the system.
Every event (like door locking/unlocking) should be logged for auditing

### Usage

To describe our idea we developed an API so it would be easier to explain. We have three Models in our App. __Guests__, __Rooms__ and __Tracks__. The idea is that we log in the database whenever a guest enters or leaves a room.


```
git clone https://github.com/mbackermann/traction_guest_challenge.git
cd traction_guest_challenge
make build
make migrate
make start
```
#### API

#### Endpoints

##### Rooms

```
GET /rooms # Get all rooms registerd
```
```
GET /rooms/:id # Get specific room by id
params:
	id (integer, required)
```
```
POST /rooms # Creates a new room
params:
	name (string, required): Name of the room
```
```
PATCH /rooms/:id # Updates an existing room
params:
	id (integer, required)
	name (string): Name of the room
```
```
DELETE /rooms/:id # Deletes a room and all tracks related
params:
	id (integer, required)
```

##### Guests

```
GET /guests # Get all guests registerd
```
```
GET /guests/:id # Get specific guest by id
params:
	id (integer, required)
```
```
POST /guests # Creates a new guest
params:
	first_name (string, required),
	last_name (string, required),
	email (string, required),
	document_id (string, required)
```
```
PATCH /guests/:id # Updates an existing guest
params:
	id (integer, required)
    first_name (string),
	last_name (string),
	email (string),
	document_id (string)
```
```
DELETE /guests/:id # Deletes a Guest and all tracks related
params:
	id (integer, required)
```

##### Tracks

```
GET /tracks # Get all tracks registerd
```
```
GET /guests/:guest_id/tracks # Get all tracks by specific user
params:
	guest_id (integer, required)
```
```
GET /rooms/:room_id/tracks # Get all tracks by specific room
params:
	room_id (integer, required)
```
```
POST /rooms/:room_id/tracks # Creates a new track
params:
	room_id (integer, required),
    guest_id (integer, required),
    status (string, required) [Entered/Left]
```
```
DELETE /tracks/:id # Deletes a Track
params:
	id (integer, required)
```

#### Authors
* Maurício Ackermann (Backend)
* Fabiano Pires (Devops)
