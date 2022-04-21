# Name: master.sls
# Description: Used to deploy reactor to the saltmaster

copy_reactor:
  file.managed:
    - name: /etc/salt/master.d/reactor.conf
    - source: salt://reactor/files/reactor.conf

restart_master:
  service.running:
    - name: salt-master
    - watch:
      - copy_reactor
