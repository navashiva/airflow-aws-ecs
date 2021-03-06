FROM puckel/docker-airflow:1.10.9

USER root

COPY config/airflow.cfg ./airflow.cfg
COPY /dags ./dags

COPY config/entrypoint.sh /entrypoint.sh
COPY config/requirements.txt /requirements.txt

RUN chmod ugo+x /entrypoint.sh

# Add directory in which pip installs to PATH
ENV PATH="/usr/local/airflow/.local/bin:${PATH}"

USER airflow

ENTRYPOINT ["/entrypoint.sh"]

# Just for documentation. Expose webserver, worker and flower respectively
EXPOSE 8080
EXPOSE 8793
EXPOSE 5555