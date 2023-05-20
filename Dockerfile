from centos:7


RUN yum -y install gdb && \
   yum clean all

ADD bcl-convert.rpm /bcl-convert.rpm
RUN rpm -i /bcl-convert.rpm && \
   rm /bcl-convert.rpm 


ENTRYPOINT ["bcl-convert"]
