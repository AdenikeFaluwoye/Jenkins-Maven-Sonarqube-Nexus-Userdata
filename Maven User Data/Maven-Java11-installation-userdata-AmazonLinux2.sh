#!/bin/bash
# Update system packages
yum update -y

# Install Java 11 (Amazon Corretto)
yum install -y java-11-amazon-corretto

# Set JAVA_HOME persistently
tee /etc/profile.d/java.sh > /dev/null <<'EOF'
export JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
export PATH=$JAVA_HOME/bin:$PATH
EOF

# Download and install Maven 3.9.6
curl -sO https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
tar -xzf apache-maven-3.9.6-bin.tar.gz -C /opt/
ln -s /opt/apache-maven-3.9.6 /opt/maven

# Set M2_HOME persistently
tee /etc/profile.d/maven.sh > /dev/null <<'EOF'
export M2_HOME=/opt/maven
export PATH=$M2_HOME/bin:$PATH
EOF

# Clean up
rm -f apache-maven-3.9.6-bin.tar.gz
