# SmartStyle

uozdemi1@binghamton.edu

This is the mobile side of my Senior Project at Binghamton University. Normally I planned this application to be a compliment to a Smart Bracelet. 

First intention was to be able to track physical activities and calories spent during the day via smart bracelet and then process all the data sent by smart bracelet to the phone and do necessary calculations on the phone. 

In addition to the other Sport Bracelets in the market my Project was planned to have a security feature in which if the user was feeling unsecure she/he would be able to inform their secure contacts by notifications and share their location. 

However, due to the disagreements with chip companies I was not able to receive a functional chip on time thus pivoted the project into a Mobile activity and calorie tracking application. 

After being inputted by the user, application can keep track of the remaining calories user can spend to be on track with their goals. The goals can be adjusted as "Lose Weight”, “Maintain" or "Gain Weight". 
Using the general calorie calculation methodologies, application gives daily and monthly goals and calorie balances to keep track activities/calories. 

Calorie interface is connected to a database (Unfortunately depreciated right now) which user can input the foods they have eaten. It allows users to see how many calories they can have more on the go. 
Furthermore, application utilizes the CoreMotion Libraries to give real time activity counting by sensor recognition. Right now user is able to use the application to count the sit-ups , pull-ups during the physical activity. 
Combined with the pedometer, activity tracker allows user to look at a glance in their daily calories burnt. 
Main controller combines food input and activity input to give more realistic calorie calculation for the remaining of the day. 

Remained from the old application, SmartStyle still uses the push notifications to inform other users. 
Also application welcomes you with a log in page previously designed to authenticate users from database. 
It is functional and can be easily modified if user wants to connect to a working user database. 

A physical device is required to use the sensor recognition or push notification capabilities since simulator does not support such actions. 

Frameworks Used : 
Alamofile 
Bolts 
Parse 
SwiftyJSON

Frameworks can be easily accessed using pod files. 

To open the application download the zip file and open the SmartStyle.xcworkspace file. 
