FROM gsoci.azurecr.io/giantswarm/klaus:0.0.30
USER root
RUN apk add --no-cache git python3 py3-pip
LABEL io.giantswarm.klaus.type=toolchain \
      io.giantswarm.klaus.name=python
USER klaus
