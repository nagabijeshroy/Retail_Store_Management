README.TXT
Instructions for running the application in a local environment on a 64 bit system. 
- Platform to be executed on Windows
- Download JDK 1.7 Windows installer from here http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html and install it. 
  Set JAVA_HOME environment variable to JDK installed path folder. 
- Download Eclipse Luna JAVA EE Developer version from here https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/luna/SR1/eclipse-java-luna-SR1-win32-x86_64.zip. 
  Extract it to install it.
- The application needs Wildfly server 8.1.0 Final. Download it form here:
  http://wildfly.org/downloads/ . Extract it to install it.
- Go to wildfly-8.1.0.Final\standalone\configuration and open standalone.xml in a text editor and search for 8080. 
  Replace with 8083 and save it.  
- Start the Wildfly server. Go to wildfly-8.1.0.Final\bin and enter standalone.bat to start it 
- The application consists of two Eclipse projects submitted with this package
  - nrscmService - nrscm business logic exposed as SOAP web service  
  - nrscmWebGUI - nrscm web GUI exposed as REST service and the jsp files  
- Import nrscmService into Eclipse luna workspace
  nrscmService has the following dependencies:
  mySQL-jdbc-driver provided with the package
  Add the jar to project build path
- Again go to wildfly-8.1.0.Final\bin open command prompt and type in the following command:
  wsconsume.bat -k path to wsdl file bundled with this package  
  Run this for each wsdl file given.  
  The soap classes corresponding to the wsdl files will be generated in 
  wildfly-8.1.0.Final\bin\output\com\nrscm\service. Copy just the java files from this folder
  into the com.nrscm.service package in nrscmService imported package in Eclipse  
- Export the nrscmService as a war into wildfly-8.1.0.Final\standalone\deployments
  The nrscmProject should be deployed and show 5 services running namely,
  1) ItemService
  2) PCService
  3) CpsService
  4) CNSServiceImpl
  5) POSService
- Select the java files generated using wsconsume tool and copied into com.nrscm.service 
  (Don't select the Service implementation files already in the package) and export them as 
  nrscm.jar to some location and save it
- Now import the second project nrscmWebGUI provided with the package and import it into 
  Eclipse workspace. 
  nrscmWebGUI has the following dependencies:
  gson-2.3.jar and nrscmService.jar generated in the previous step to nrscmWebGUI build path
  Also copy nrscmService.jar to nrscmWebGUI\WebContent\WEB-INF\lib
  nrscmWebGUI UI related dependencies:
  - jquery-1.11.1.js used extensively for ajax calls and parsing json strings
  - jquery-ui-1.11.2 for date picker
  - form2js to convert form values to json string
  - The UI pages also uses DataTables - a jquery plugin cdn to populate table data (http://www.datatables.net/) 
  - bootstrap.css for UI styling
- Now export the nrscmWebGUI as a war to wildfly-8.1.0.Final\standalone\deployments  
- The database used by application is MySQL version 5.2.6
- We have used XAMPP version 1.8.3 distribution to install MySQL 
  Download win32 installer from here: http://sourceforge.net/projects/xampp/files/XAMPP%20Windows/1.8.3/
  Double click on exe	
- MySQL used with default configuration
  port: 3306, user: root and no password
- Start XAMPP. Run it as administrator. Start Apache server and MYSQL from the control panel
- Run the sqlscript.sql given with this package in the sql editor from phpMyAdmin
  Access phpMyAdmin by going to XAMPP home page which is localhost:8080 by default
- Access the application from Mozilla Firefox or Google Chrome web browser as follows:
  http://localhost:8083/nrscmWebGUI/login.jsp
- As discussed during demonstration 
  Login with Administrator credentials as follows:
  username: Administrator
  password: pass
  Credentials for other users:
  Store Head:
  username: SH
  password: pass
  Department Head:
  username: DH
  password: pass
  Service Desk operator:
  username: SDO
  password: pass
  Point of Sales executive  
  username: POS
  password: pass
  Currently the UI for the above 4 users is hard coded for store named Niner Mart
  with Store Is 1 and two Departments with id 1 and 2
  These can be created using Administrator credentials provided for the application and 
  then proceed with the remaining user credentials  




