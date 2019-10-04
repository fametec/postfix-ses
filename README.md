# run

    docker run --rm -p 30025:25 -d --name postfix \
    -e MAILGUN_USER=AAAAAAAAAAAAAAAAAAAAAAAA \
    -e MAILGUN_PASS=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB \
    -e MAILGUN_RELAYHOST=email-smtp.us-east-1.amazonaws.com \
    fametec/postfix-ses:latest

# docker-compose

    version: '3.2'
    #
    ### Services
    #
    services:
    #
    # SES
    #
      relay:
        build: .
        image: fametec/postfix-ses:latest
        restart: unless-stopped
        container_name: relay-ses
        ports:
         - "30025:25"
        environment:
         SES_USER: XXXXXXXXXXXXXXXX
         SES_PASS: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
         SES_RELAYHOST: email-smtp.us-east-1.amazonaws.com

# testing

    echo "Email Test" | mail -s "This is a simple test" contato@fametec.com.br
 
or

    sendmail -f sender@example.com recipient@example.com
    From: Sender Name <sender@example.com>
    Subject: Amazon SES Test                
    This message was sent using Amazon SES.                
    .


