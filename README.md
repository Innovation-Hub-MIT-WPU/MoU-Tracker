# MoU-Tracker

## How to contribute

- Make sure to follow the given structure
- Communicate with all developers assigned to a page *( Especially for the tabs page )*
- *Do not merge code with conflicts*

### Classes

- Classes are used to be imported for different types of access levels
- Make sure to make these classes neat and clean
- They might not have methods of their own and can only be used to store data in certain format

### Screens

- Make sure to use `FutureBuilders` for developing tabs where data is updated regularly
- `Do not instantiate unnecessary timers` and setup only necessary ones
- Setting up a `StreamSubscription` is better than setting up timers for data updating in a period
- If widgets are common for multiple screens, add them in the common_widgets. Same applies for common_utils.
- Only make named routes to pages
- The tabs given will be integrated into a single page, with help of tab controller. Do not make separate pages out of it, i.e. don't overuse the Scaffold widget there
- Animations are a must in this, make sure to note down widgets where you can add animations for later implementation
- Optimization of code is a must, hence try to reduce redundant code writing and make full use of dart's power.
- Take into consideration that the app may also be released on the iOS platform. Make sure to not use packages which do not `support iOS`.
- `Adhere by all the rules` of making screens as it should not be the case that the app works on android but not on iOS

### Services

- We are using Firebase as the primary backend here. Setup basic CRUD operations and along with that setup methods which will be required to read / write specific information to different pages
- Make the requesting methods `async` as and when needed
- Do not mess up Future methods. `async-await errors should be avoided at all costs`
- `Do not put the firebase_options in gitignore` for this project as other students will also have to use it
- `Use Firebase SDK only`, do not used raw methods of making https requests from the app
