FROM ubuntu:trusty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update && \
  apt-get -y -q dist-upgrade && \
  apt-get -y -q install python-setuptools python-pip curl

WORKDIR /root
RUN curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -o awslogs-agent-setup.py
COPY awslogs.conf /root/awslogs.conf
RUN mkdir /root/logs
RUN python /root/awslogs-agent-setup.py -n -r ap-northeast-2 -c /root/awslogs.conf
COPY aws-creds.conf /var/awslogs/etc/aws.conf
RUN pip install supervisor
COPY cloudwatch.sh /usr/local/scripts/cloudwatch.sh
RUN chmod 755 /usr/local/scripts/cloudwatch.sh
COPY supervisord.conf /usr/local/etc/supervisord.conf
ARG CLIENT

ENTRYPOINT ["/usr/local/bin/supervisord"]
