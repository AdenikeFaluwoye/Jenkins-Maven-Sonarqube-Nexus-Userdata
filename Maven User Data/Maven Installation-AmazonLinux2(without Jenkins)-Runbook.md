Maven new installation Amazon linux 2



Below are commands you run to manually install Maven, Java 11 and also set Environment variables for both Java and Maven on your amazon linux 2 instance But if you'd rather use a userdata, copy the userdata in the file "Maven-Java11-installation-userdata.sh"

----------------------------------------------------------------------------------------------------------
FIRST LETS INSTALL JAVA11
---------------------------------------------------------------------------------------------------------

Install Java 11 (needed for Maven to work)

Make this setup persistent across reboots (if running into issues with source)


Java is not yet installed yet and JAVA_HOME is not yet set.

Let’s fix it in 2 steps:

✅ Step 1: Install Java
Run:

sudo yum install -y java-11-amazon-corretto

Then confirm:

java -version

You should see something like:


openjdk version "11.0.xx"  Amazon Corretto


✅ Step 2: Set JAVA_HOME
Find Java path that you installed ( The path to the directory where Java was installed on your Instance):

readlink -f $(which java)

You’ll get something like:

/usr/lib/jvm/java-11-amazon-corretto.x.x.x/bin/java

- Now So set JAVA_HOME like this (adjust the path if different):

Run: Copy all and paste

-----------------------------------------------------------------------------------
sudo tee /etc/profile.d/java.sh > /dev/null <<EOF
export JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
export PATH=\$JAVA_HOME/bin:\$PATH
EOF
-----------------------------------------------------------------------------------
# Apply it now: The next command applies the changes you just made

source /etc/profile.d/java.sh

✅ Step 3: Test Maven

mvn -v

You should now see both Maven and Java versions without errors.


You're all set to start building Java projects with Maven on your Amazon Linux 2 instance.

✅ (Optional) Confirm Environment Variables ( Just to be sure Mavrn home is set, Java home is set and they are both installed correctly )

You can double-check the variables with:

echo $JAVA_HOME
echo $M2_HOME
which mvn

You should see:

------------------------------------------------------------------------------
/usr/lib/jvm/java-11-amazon-corretto

/opt/maven

/opt/maven/bin/mvn


---------------------------------------------------------------------------------
NOW LETS INSTALL MAVEN
---------------------------------------------------------------------------------

🔧 Full Working Commands to Install Maven 3.9.6 on Amazon Linux 2
Run this step-by-step:


# 1. Download Apache Maven 3.9.6 from a reliable source
curl -O https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz

# 2. Extract to /opt
sudo tar -xvzf apache-maven-3.9.6-bin.tar.gz -C /opt/

# 3. Create a symbolic link
sudo ln -s /opt/apache-maven-3.9.6 /opt/maven

# 4. Set environment variables
sudo tee /etc/profile.d/maven.sh > /dev/null <<EOF
export M2_HOME=/opt/maven
export PATH=\$M2_HOME/bin:\$PATH
EOF

# 5. Apply the environment variables you just set
source /etc/profile.d/maven.sh

# 6. Verify Maven is installed
mvn -v

📌 Sample Output from mvn -version:

Apache Maven 3.9.6 (...)
Java version: 11.0.22, vendor: Amazon.com Inc.

----------------------------------------------------------------------------------------------

END OF INSTALLATION COMMANDS 
----------------------------------------------------------------------------------------------



Now project Specific commands 

---------------------------------------------------------------------------------------------------
To to see your folder structure in a neat format   install tree: 

sudo yum install tree -y

To install Git :  

sudo yum install git -y


To clone the repo where we have the source code and the POM.xml file run the command:

git clone https://github.com/Oluwole-Faluwoye/Maven-Build-Automation.git

( Optional :You can paste the link alone on your browser to see the project codes) : 


Change directory into the repo you just cloned : 

cd Maven-Build-Automation

List all the files in the repo :  ls

change Directory to where you have the source code and the pom.xml   : 

cd JavaWebApp

List all the files in the JavaWebApp to confirm your pom.xml and your src folder:

ls


----------------------------------------------------------------------------------------------------------
Optional : To get Maven documentation use this link :   https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html
---------------------------------------------------------------------------------------------------------


You must be in the directory of the pom.xml file and the source code to be able to execute maven


Now run the following commands to build and package your app:

mvn validate 

mvn compile

mvn test

Note:  When you run mnv test, the unit test and integration test is done and a report is generated inside a folder {surefire-report}

mvn package 


once you run say mvn package and you have ran mvn test before then, it wont say you have ran it before, maven would still run from validate all to package. 

To list the content of the directory that was just created when you ran mvn package:  ls target