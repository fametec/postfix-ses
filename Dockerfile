FROM centos:7

MAINTAINER eduardo.fraga@fametec.com.br

ENV SES_USER yyyyyyyyyyyyyyyyyy

ENV SES_PASS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

ENV SES_RELAYHOST email-smtp.us-west-2.amazonaws.com

# See https://docs.aws.amazon.com/general/latest/gr/rande.html#ses_region


RUN yum -y install postfix cyrus-sasl-plain mailx


RUN { \
	echo ; \
	echo 'inet_interfaces = all' ; \
	echo '#Set the relayhost' ; \
	echo 'mydestination = localhost.localdomain, localhost' ; \
	echo 'relayhost = [SES_RELAYHOST]:587' ; \
	echo 'smtp_sasl_auth_enable = yes' ; \
	echo 'smtp_sasl_password_maps = static:SES_USER:SES_PASS' ; \
	echo 'smtp_sasl_security_options = noanonymous' ; \
	echo ; \
	echo '# TLS support' ; \
	echo 'smtp_use_tls = yes' ; \
	echo 'smtp_tls_CAfile = /etc/pki/tls/certs/ca-bundle.crt' ; \
	echo 'smtp_tls_security_level = may' ; \
	echo 'smtpd_tls_security_level = may' ; \
	echo 'smtp_tls_note_starttls_offer = yes' ; \
	echo ; \
	echo 'smtp_cname_overrides_servername=no' ; \
	echo ; \
    } >> /etc/postfix/main.cf


RUN { \
        echo '#!/bin/bash' ; \
        echo ; \
        echo 'sed -i s/SES_USER/$SES_USER/g /etc/postfix/main.cf' ; \
        echo 'sed -i s/SES_PASS/$SES_PASS/g /etc/postfix/main.cf' ; \
        echo 'sed -i s/SES_RELAYHOST/$SES_RELAYHOST/g /etc/postfix/main.cf' ; \
	echo 'postfix start' ; \
        echo ; \
        echo 'while true; do' ;\
        echo '  mailq ' ; \
        echo '  sleep 10' ; \
        echo 'done' ; \
        echo ; \
    } > /entrypoint.sh && chmod +x /entrypoint.sh


EXPOSE 25

CMD [ "/entrypoint.sh" ]

