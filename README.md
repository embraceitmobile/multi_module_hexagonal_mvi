Multi Module Hexagonal MVI
==========================
This project is a technology demonstrator for using a packages as independent modules. The project aims to provide an effective mechanism for data communication between different modules, where each module exposes APIs for data data communication.

Independent modules allow for greater testability, and scalability with a plug-n-play model where the modules can be added and removed easily.

Architecture
------------

The architecture chosen to achieve this goal is the [Hexagon Architecture](https://medium.com/ssense-tech/hexagonal-architecture-there-are-always-two-sides-to-every-story-bc0780ed7d9c), also known as the Ports and Adapter architecture. For a simple flutter project based on this architecture you can see this excellent [medium article](https://medium.com/@romainstraet/build-a-clean-game-of-life-app-in-flutter-using-hexagonal-architecture-and-tdd-part-1-50d1329a738b).

Design Pattern
--------------
The design pattern chosen here is [MVI](https://cycle.js.org/model-view-intent.html) a.k.a Model-View-Intent. 

![MVP vs MVI explained](https://miro.medium.com/max/1300/1*AoqX-t3VjgW1CLYVRwLD7Q.png)
Reference: [https://www.novatec-gmbh.de/en/blog/mvi-in-android/](https://www.novatec-gmbh.de/en/blog/mvi-in-android/)


In this design pattern, an intent is thrown by the user to the model, which emits a new state based on the received inent. The view listens to the states emitted by the model, and updates the UI accordinly.

The primary principle of this pattern is that the state never mutates: always a new state is emitted by the model. This ensures that even there are mulitple listeners for a state, they will always get the same state.

State Management
----------------
Most of the heavy duty state management is being handled in the model using [stream](https://dart.dev/tutorials/language/streams) and [streambuilder](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html). On the presentation layer however, we will be using [Bloc](https://pub.dev/packages/flutter_bloc) due to its immense popularity and greater community support. However, any state management tool can be used instead, it is upto the developer to use the tool that they are comfortable with.

***Please note: that this project is still in development, and will be updated frequently***.
