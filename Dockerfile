FROM taylorm/rpmbuilder

RUN version=$(curl -s https://api.github.com/repos/dmshaw/paperkey/releases/latest | grep -Po '"tag_name": "\K.*?(?=")' | tr -d v) && \
    curl -Lo /tmp/paperkey-${version}.tar.gz https://github.com/dmshaw/paperkey/releases/download/v${version}/paperkey-${version}.tar.gz && \
    curl -Lo /tmp/paperkey-${version}.tar.gz.sig https://github.com/dmshaw/paperkey/releases/download/v${version}/paperkey-${version}.tar.gz.sig && \
    rpmbuild -ta /tmp/paperkey-${version}.tar.gz && \
    rpm -Uvh /root/rpmbuild/RPMS/x86_64/paperkey-${version}-1.x86_64.rpm && \
    rm -rf \
      /tmp/paperkey-${version}.tar.gz \
      /tmp/paperkey-${version}.tar.gz.sig \
      /root/rpmbuild/RPMS/x86_64/paperkey-${version}-1.x86_64.rpm \
      && \
    paperkey --version
RUN echo hello


