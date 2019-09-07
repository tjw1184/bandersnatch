FROM python:3

# Dockerfile based on sample provided at bandersnatch repository https://github.com/pypa/bandersnatch

# Docker metadata
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Bandersnatch" \
      org.label-schema.maintainer="tjw1184" \      
      org.label-schema.description="Preconfigured Bandersnatch Server" \
      org.label-schema.url="https://github.com/tjw1184/bandersnatch" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/tjw1184/bandersnatch" \
      org.label-schema.vendor="tjw1184" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

RUN mkdir -p /src
ADD runner.py /src

# Add default config, can link a file to /etc/bandersnatch.conf and override it
ADD bandersnatch.conf /etc

## document ports and volumes to be remapped
VOLUME /srv/pypi

RUN pip install --upgrade pip
RUN pip install --upgrade bandersnatch

# Runs a sync once a day
CMD ["python", "/src/runner.py", "3600"]
