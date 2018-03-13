FROM tutum/lamp:latest
RUN rm -rf /app && git clone https://github.com/inclusive-design/AChecker.git /app
RUN mkdir /app/temp && chmod a+rw /app/temp
RUN touch /app/include/config.inc.php && chmod a+rw /app/include/config.inc.php
EXPOSE 80 3306
CMD ["/run.sh"]

