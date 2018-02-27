# Check-Scheduler-status-and-email-PowerShell
This repo uses powershell script to check status of any scheduler task.
Compares how long the task has been running based on task1:that whenever it runs,it logs a text file with 
time stamp.

Depending on hours of task1 being run and still in running state, this script helps to take further action like kill the process
or trigger another process or completely do something else.
And finally send an email reading the email ids using filter from a XML files that can be easily managed.
