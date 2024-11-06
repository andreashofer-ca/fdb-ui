# fdb-ui : Repository for Omnichannel Banking UI


## To setup FDB-UI on local environment please follow below steps:
### Prerequisite:
```
  1.	Clone fdb-ui repo from Fioneer github.
  2.	Clone fdb-ui5 library repo from Fioneer github.
  3.	Install npm and node server on local machine.
          https://docs.npmjs.com/downloading-and-installing-node-js-and-npm
          The node server needs to be configured, that can be used to serve the front application
  4.    Install VS code in local machine.

```
### Running fdb-ui application:

```
    1.	Open fdb-ui folder in VS-code.
    2.	Go to terminal and go inside “fdb-ui/OCBMobileWeb”
    3.	Run command  “node server.js”
    4.	You will received a message
    “Server running at http://127.0.0.1:8125/”
    5.	Open Chrome browser in disabled web security mode
    To open chrome in web-security disabled mode
    a)	 Open command prompt and run command
    "C:\Program Files\Google\Chrome\Application\chrome.exe" --disable-web-security --user-data-dir="C:\Users\<folder_name_with_userId>\Documents\Temp"

    Or

    b)	 Append parameter --disable-web-security --user-data-dir="C:\Users\\<folder_name_with_userId>\ in  chrome shortcut.

    6.	Access UI using URL: http://localhost:8125/WebContent/main.html

    7.	Click on SAP Fioneer icon on login page and configure connection settings - server, server-port and app type Business\Consumer.

```
Jenkins Dev Build
http://10.136.68.49:8080/job/OCBDEV_ORB/
