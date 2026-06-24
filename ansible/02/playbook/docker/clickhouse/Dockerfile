FROM rockylinux:9

RUN dnf install -y \
    openssh-server \
    python3 \
    sudo \
    tar \
    gzip && \
    dnf clean all

RUN echo 'root:root' | chpasswd

RUN ssh-keygen -A

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
