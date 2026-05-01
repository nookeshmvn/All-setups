# 1. Install Java
yum install java-17-amazon-corretto -y

# 2. Download Tomcat 9.0.112 from the permanent archive (Fixes the 404 error)
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.112/bin/apache-tomcat-9.0.112.tar.gz

# 3. Extract the files
tar -zxvf apache-tomcat-9.0.112.tar.gz

# 4. Add Manager roles and user credentials
sed -i '56a\<role rolename="manager-gui"/>' apache-tomcat-9.0.112/conf/tomcat-users.xml
sed -i '57a\<role rolename="manager-script"/>' apache-tomcat-9.0.112/conf/tomcat-users.xml
sed -i '58a\<user username="tomcat" password="admin@123" roles="manager-gui, manager-script"/>' apache-tomcat-9.0.112/conf/tomcat-users.xml
sed -i '59a\</tomcat-users>' apache-tomcat-9.0.112/conf/tomcat-users.xml

# 5. Clean up the original closing tag
sed -i '56d' apache-tomcat-9.0.112/conf/tomcat-users.xml

# 6. Remove the IP restriction Valve so you can access the Manager app remotely
sed -i '21d' apache-tomcat-9.0.112/webapps/manager/META-INF/context.xml
sed -i '22d' apache-tomcat-9.0.112/webapps/manager/META-INF/context.xml

# 7. Start Tomcat
sh apache-tomcat-9.0.112/bin/startup.sh
