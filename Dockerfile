FROM jekyll/jekyll:3.8

LABEL maintainer "evertonagilar <evertonagilar@ufsm.br>"

ADD assets/entrypoint.sh	/var/opt/entrypoint.sh
ADD src/					/var/opt/knowledge-base/
ADD assets/.ssh				/root/.ssh

RUN chmod +x /var/opt/entrypoint.sh && \
	chmod -R 400 /root/.ssh


ENTRYPOINT ["/var/opt/entrypoint.sh"]




