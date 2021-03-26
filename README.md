Rocket_Elevators_Information_System 🚀 📈

🎯 About Week 9 - An important part of Rocket Elevators' information system is still missing and that is the management of interventions. To add it, it is necessary to take inspiration from the elements already implemented in the current solution and use them again to implement a new entity.
Intervention Management Requires:

  A new form to formulate the request
  The creation of a new table
  Saving the request for intervention in the database
  Sending a service ticket to ZenDesk
  The addition of an API request that returns new interventions requests

📌 Some important information
How to connect to the BackOffice:
  Navigation bar : My Account
  Login
  Email: "nicolas.genest@codeboxx.biz"
  Password: "codeboxx"
  
Previous APIs:

 Google Maps
  In the backoffice, there is a tab labeled Map that shows all of the buildings in the Rocket Elevators database, and when a pin is clicked, information about that building is shown.

 Twilio
  The Twilio API makes it easy to send SMS. Whenever the elevator status changes to Intervention, the technical contact responsible for that building will receive an SMS, with the ID, Serial Number and Status of that elevator

 Slack
  Open the Slack app and open the channel, go to Rocket Elevators group and select elevator_operations.
  In  the backoffice, select the elevator, change elevator status and you'll see a notife in slack about the change.

 Dropbox
  The Dropbox API takes files that are uploaded via the contact form and when the contact that filled the form becomes a customer, the previously uploaded attachment will be sent to Dropbox for safekeeping.

 Sendgrid
  After customers fill out the contact form, the Sendgrid API will reach out to them via email to greet them and assure them that a representative will contact them shortly.

 IBM Watson
  We have an Update button that when is pressed, a function will be triggered. This function calls the IBM Watson API and receives a text to speech audio file that goes over key metrics of the company. This file can be played via the audio player embedded in the dashboard.

 Zendesk
  ZenDesk takes the info from a submitted lead or quote and submits it to a ticket in the ZenDesk workspace for Rocket Elevators to see and deal with.

Seed the warehouse:
 To take the data from the MySQL database to the warehouse(Postgres) you can use a one line command: rake warehouse:import

📌 New project updates

New "Interventions" Table
 A new "Intervention" Table must be added to the Relational model in the MySQL database. 

To access the intervention form:

 After logging in as an employee you will have access to the intervention page, in your navigation menu.

 When selecting the Customer, you will have access to the Building dropdown, with the buildings referring to that customer.
 After selecting the Building, you will have access to the Batteries dropdown, with the batteries referring to those buildings.
 After selecting the Battery, you will have access to the Columns dropdown, with the columns referring to those batteries.
 After selecting the Column, you will have access to the Elevators dropdown, with the elevators referring to those columns.
 You will also have to sign an employee for that intervention and leave a short description.

 When creating the intervention, it will be saved in the relational database (Mysql).

Creating a Ticket in ZenDesk

 At the time of saving the service request, the website form creates a new ticket in ZenDesk. 
To create a ticket:

 Now ZenDesk also takes information from an intervention and creates a ticket in the ZenDesk workspace so that rocket elevators can see and deal with

Creating new GET and PUT requests in the REST API
 The REST API needs to be modified and enhanced to offer data through new interaction points:

 GET: Returns all fields of all intervention Request records that do not have a start date and are in "Pending" status.
 PUT: Change the status of the intervention request to "InProgress" and add a start date and time (Timestamp).
 PUT: Change the status of the request for action to "Completed" and add an end date and time (Timestamp).

To test the new endpoints of our API you can use Postman: https://www.postman.com/ 
We have a Workspace public, where you can easily consume our API: https://app.getpostman.com/join-team?invite_code=d2fd10ac80e62fdc84f9319dec2a29bf&ws=99025ea3-54d1-4ece-82f7-e0afa8fc3014

You can access the Rest API repository here: https://github.com/cris-s-santiago/Rocket-Elevators-Foundation-Rest-API
