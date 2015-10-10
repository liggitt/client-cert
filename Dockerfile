# Clone from the Fedora 22 image
FROM fedora:22

MAINTAINER Jordan Liggitt <jliggitt@redhat.com>

EXPOSE 9443

ENTRYPOINT /server

ADD localhost.crt localhost.crt
ADD localhost.key localhost.key
ADD server server
