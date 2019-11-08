FROM jekyll/jekyll:3.8

LABEL maintainer "evertonagilar <evertonagilar@ufsm.br>"

ADD assets/entrypoint.sh		/var/opt/entrypoint.sh
ADD assets/update.sh			/var/opt/update.sh
ADD assets/.ssh					/root/.ssh

RUN chmod +x /var/opt/entrypoint.sh && \
	chmod -R 400 /root/.ssh && \
	echo '*/1	*	*	*	*	/var/opt/update.sh' >> /etc/crontabs/root

ENTRYPOINT ["/var/opt/entrypoint.sh"]




