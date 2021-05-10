# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Build as DOCKER_BUILDKIT=1 docker build -o /tmp/out .
# Generated tarball(s) will end up in /tmp/out

FROM debian:stretch AS stretch

# TODO: Factor out the common code without rerunning apt-get on every build.

RUN set -x; echo "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y -t stretch-backports install golang && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install git systemd \
    autoconf libtool libcurl4-openssl-dev libltdl-dev libssl1.0-dev libyajl-dev \
    build-essential cmake bison flex file libsystemd-dev \
    devscripts cdbs

COPY . /work
WORKDIR /work
RUN ./pkg/deb/build.sh


FROM scratch

COPY --from=stretch /tmp/google-cloud-ops-agent-1.tgz /google-cloud-ops-agent-1-debian-stretch.tgz
COPY --from=stretch /google-cloud-ops-agent-1*.deb /

