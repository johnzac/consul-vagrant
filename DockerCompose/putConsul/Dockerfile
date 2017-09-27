From alpine
RUN apk add --no-cache python2
RUN apk add --no-cache py-pip
RUN pip install flup
RUN pip install requests
RUN pip install flask
RUN mkdir -p /var/www/html
COPY python/* /home/putConsul/
WORKDIR "/home/putConsul"
EXPOSE 8888
CMD ["python","/home/putConsul/putConsul.py"]
