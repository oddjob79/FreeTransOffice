# FreeTransOffice
Job Tracking and Invoicing App for Freelance Translators

This project was written as a first attempt at grasping OOP techniques in PHP.
It was written for 3 purposes:
  1. As a learning process for myself
  2. As a demonstration of my skills with a view of gaining employment in this area
  3. As a fully functioning tool for freelance translators to utilize
  
The app is hosted on a pre-built Bitnami LAMP stack on the Google Cloud Platform
The application is online and available for anyone who wishes to use it at https://app.freetransoffice.com. There is also a development version at https://dev.freetransoffice.com.

Comments and suggestions are welcome, but please be kind. I have flown solo on this and there are many areas I would like to clean up that I know about, as well as I'm sure many areas that I do not.

Thank you kindly,

Rob Turner


FreeTransOffice - Help

As a New User, click the New User button, otherwise enter your login credentials and hit "Login".
In the New User screen, complete your user information and click 'Add User'. You will need to scroll to the bottom of the user agreement and check the T&C box to complete this process.

Once you have logged in, you will be taken to the empty Jobs board. Before you can begin entering Jobs, you will need to enter your Clients, plus any Contacts and End Clients you may have. You should also complete your personalized setup, including Invoice setup.

Under Settings, you will find the User Settings page where you should enter more details about yourself, which can be pulled into your invoice.

Report Configuration allows you to configure your own Invoice, so that the information you want to include is available to your clients. There are different sections to this, where you can add your own text and your own fields / field headers. Unfortunately there is no preview as yet, but I will explain under Invoicing how to generate an invoice and void it so you can change the invoice if it is not to your liking.
The fields available from the Job section related to the Job / End Client that are shown on the invoice, whereas the Additional Information at the bottom relate to the Client / User / Invoice.

Also under the Settings menu is the Packages setup, where you can add the different software packages used by your clients, and the Job Types setup, where you can set different types of Job and an estimated Words per Hour. Both these options can be used with other job information to estimate how long a job will take, and to report on the efficiency of certain types of job.

Once you have configured the system, use the Navigation Panel at the top to load the Clients board and click New Client to enter a new Client. Once the Client information has been completed, Save the record using the button at the bottom. Please note the Invoice Report field under client will set which invoice type to use per client. If you have added a new invoice in the report configuration, it must be added here to be generated, when invoicing that client.
Add the rest of your Clients, plus your Contacts and End Clients in the same way.

You are now ready to enter your Jobs. To do this, either go directly to the Jobs menu from the Navigation bar, or drop down to Clients > Jobs to filter the Jobs. 

Invoicing

Click on the down arrow by the Invoicing menu to select the option to Generate Invoices.
Pick your client using the drop-down to bring up a list of jobs per client.
Use the Status filter box to ensure only "Complete" jobs are selected.
Either use the Check All box to mark all visible jobs as selected, or check the jobs individually using the check box on the right hand side.
Once you have your selection as you want it, click "Generate Invoices".
You will see a screen asking you to confirm you would like to generate an invoice for the jobs displayed.
Once you have clicked confirm, you will be prompted to download the invoice. A splash screen will ask you to proceed to the Invoice Details screen.
You will then see the Invoice Details. If there was an issue with the invoice, you can Void the Invoice from this screen, which will reset the associated jobs' status to Complete (from Invoiced). You can then repeat the Invoicing steps until everything is to your liking.



